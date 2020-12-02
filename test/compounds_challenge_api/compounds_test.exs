defmodule CompoundsChallengeApi.CompoundsTest do
  use CompoundsChallengeApi.DataCase

  alias CompoundsChallengeApi.Compounds

  describe "compounds" do
    alias CompoundsChallengeApi.Compounds.Compound

    @valid_attrs %{compound_id: 42, image_path: "some image_path", molecular_formula: "some molecular_formula", molecular_weight: 120.5, num_rings: 42, smiles: "some smiles"}
    @update_attrs %{compound_id: 43, image_path: "some updated image_path", molecular_formula: "some updated molecular_formula", molecular_weight: 456.7, num_rings: 43, smiles: "some updated smiles"}
    @invalid_attrs %{compound_id: nil, image_path: nil, molecular_formula: nil, molecular_weight: nil, num_rings: nil, smiles: nil}

    def compound_fixture(attrs \\ %{}) do
      {:ok, compound} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Compounds.create_compound()

      compound
    end

    test "list_compounds/0 returns all compounds" do
      compound = compound_fixture()
      assert Compounds.list_compounds() == [compound]
    end

    test "get_compound!/1 returns the compound with given id" do
      compound = compound_fixture()
      assert Compounds.get_compound!(compound.id) == compound
    end

    test "create_compound/1 with valid data creates a compound" do
      assert {:ok, %Compound{} = compound} = Compounds.create_compound(@valid_attrs)
      assert compound.compound_id == 42
      assert compound.image_path == "some image_path"
      assert compound.molecular_formula == "some molecular_formula"
      assert compound.molecular_weight == 120.5
      assert compound.num_rings == 42
      assert compound.smiles == "some smiles"
    end

    test "create_compound/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Compounds.create_compound(@invalid_attrs)
    end

    test "update_compound/2 with valid data updates the compound" do
      compound = compound_fixture()
      assert {:ok, %Compound{} = compound} = Compounds.update_compound(compound, @update_attrs)
      assert compound.compound_id == 43
      assert compound.image_path == "some updated image_path"
      assert compound.molecular_formula == "some updated molecular_formula"
      assert compound.molecular_weight == 456.7
      assert compound.num_rings == 43
      assert compound.smiles == "some updated smiles"
    end

    test "update_compound/2 with invalid data returns error changeset" do
      compound = compound_fixture()
      assert {:error, %Ecto.Changeset{}} = Compounds.update_compound(compound, @invalid_attrs)
      assert compound == Compounds.get_compound!(compound.id)
    end

    test "delete_compound/1 deletes the compound" do
      compound = compound_fixture()
      assert {:ok, %Compound{}} = Compounds.delete_compound(compound)
      assert_raise Ecto.NoResultsError, fn -> Compounds.get_compound!(compound.id) end
    end

    test "change_compound/1 returns a compound changeset" do
      compound = compound_fixture()
      assert %Ecto.Changeset{} = Compounds.change_compound(compound)
    end
  end

  describe "assay_results" do
    alias CompoundsChallengeApi.Compounds.AssayResult

    @valid_attrs %{operator: "some operator", result: "some result", result_id: 42, target: "some target", unit: "some unit", value: 120.5}
    @update_attrs %{operator: "some updated operator", result: "some updated result", result_id: 43, target: "some updated target", unit: "some updated unit", value: 456.7}
    @invalid_attrs %{operator: nil, result: nil, result_id: nil, target: nil, unit: nil, value: nil}

    def assay_result_fixture(attrs \\ %{}) do
      {:ok, assay_result} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Compounds.create_assay_result()

      assay_result
    end

    test "list_assay_results/0 returns all assay_results" do
      assay_result = assay_result_fixture()
      assert Compounds.list_assay_results() == [assay_result]
    end

    test "get_assay_result!/1 returns the assay_result with given id" do
      assay_result = assay_result_fixture()
      assert Compounds.get_assay_result!(assay_result.id) == assay_result
    end

    test "create_assay_result/1 with valid data creates a assay_result" do
      assert {:ok, %AssayResult{} = assay_result} = Compounds.create_assay_result(@valid_attrs)
      assert assay_result.operator == "some operator"
      assert assay_result.result == "some result"
      assert assay_result.result_id == 42
      assert assay_result.target == "some target"
      assert assay_result.unit == "some unit"
      assert assay_result.value == 120.5
    end

    test "create_assay_result/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Compounds.create_assay_result(@invalid_attrs)
    end

    test "update_assay_result/2 with valid data updates the assay_result" do
      assay_result = assay_result_fixture()
      assert {:ok, %AssayResult{} = assay_result} = Compounds.update_assay_result(assay_result, @update_attrs)
      assert assay_result.operator == "some updated operator"
      assert assay_result.result == "some updated result"
      assert assay_result.result_id == 43
      assert assay_result.target == "some updated target"
      assert assay_result.unit == "some updated unit"
      assert assay_result.value == 456.7
    end

    test "update_assay_result/2 with invalid data returns error changeset" do
      assay_result = assay_result_fixture()
      assert {:error, %Ecto.Changeset{}} = Compounds.update_assay_result(assay_result, @invalid_attrs)
      assert assay_result == Compounds.get_assay_result!(assay_result.id)
    end

    test "delete_assay_result/1 deletes the assay_result" do
      assay_result = assay_result_fixture()
      assert {:ok, %AssayResult{}} = Compounds.delete_assay_result(assay_result)
      assert_raise Ecto.NoResultsError, fn -> Compounds.get_assay_result!(assay_result.id) end
    end

    test "change_assay_result/1 returns a assay_result changeset" do
      assay_result = assay_result_fixture()
      assert %Ecto.Changeset{} = Compounds.change_assay_result(assay_result)
    end
  end
end
