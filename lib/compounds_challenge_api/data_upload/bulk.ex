defmodule CompoundsChallengeApi.DataUpload.Bulk do
  alias CompoundsChallengeApi.Compounds

  def upload_bulk_data(file = %Plug.Upload{}) do
    json = parse_file(file)

    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    compounds =
      json
      |> Stream.map(fn compound_record ->
        map_compound(compound_record)
      end)
      |> Stream.map(fn compound_record ->
        Map.merge(
          compound_record,
          %{inserted_at: now, updated_at: now}
        )
      end)
      |> Enum.to_list()
      |> Compounds.bulk_upload_compounds()
  end

  defp parse_file(file) do
    file.path
    |> File.read!()
    |> trim_bom()
    |> Jason.decode!()
  end

  defp trim_bom(content), do: String.trim_leading(content, <<0xFEFF::utf8>>)

  defp map_compound(record) do
    %{
      compound_id: record["compound_id"],
      alogp: record["ALogP"],
      image_path: record["image"],
      molecular_formula: record["molecular_formula"],
      molecular_weight: record["molecular_weight"],
      num_rings: record["num_rings"],
      smiles: record["smiles"]
    }
  end
end
