defmodule CompoundsChallengeApi.DataUpload.Bulk do
  alias CompoundsChallengeApi.Compounds

  def upload_bulk_data(file = %Plug.Upload{}) do
    json = parse_file(file)

    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    {compounds, nested_assay_results} =
      json
      |> Stream.map(&map_compound(&1))
      |> Stream.map(fn {compound_record, assay_results} ->
        {add_timestamps(compound_record, now), assay_results}
      end)
      |> Enum.unzip()

    compounds
    |> Enum.to_list()
    |> Compounds.bulk_upload_compounds()

    nested_assay_results
    |> Stream.flat_map(fn {compound_id, assay_result_records} ->
      assay_result_records
      |> Stream.map(fn assay_result_record ->
        map_assay_result(assay_result_record, compound_id)
      end)
    end)
    |> Stream.map(&add_timestamps(&1, now))
    |> Enum.to_list()
    |> Compounds.bulk_upload_assay_results()
  end

  defp parse_file(file) do
    file.path
    |> File.read!()
    |> trim_bom()
    |> Jason.decode!()
  end

  defp trim_bom(content), do: String.trim_leading(content, <<0xFEFF::utf8>>)

  defp add_timestamps(record, now),
    do: Map.merge(record, %{inserted_at: now, updated_at: now})

  defp map_compound(record) do
    {%{
       compound_id: record["compound_id"],
       alogp: record["ALogP"],
       image_path: record["image"],
       molecular_formula: record["molecular_formula"],
       molecular_weight: record["molecular_weight"],
       num_rings: record["num_rings"],
       smiles: record["smiles"]
     }, {record["compound_id"], record["assay_results"]}}
  end

  defp map_assay_result(record, compound_id) do
    %{
      compound_id: compound_id,
      result_id: record["result_id"],
      target: record["target"],
      result: record["result"],
      operator: record["operator"],
      value: record["value"] / 1,
      unit: record["unit"]
    }
  end
end
