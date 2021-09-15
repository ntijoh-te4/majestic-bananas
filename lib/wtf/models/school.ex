defmodule WTF.School do
  defstruct(id: nil, school_name: "")

  alias WTF.School

  def all do
    Postgrex.query!(DB, "SELECT * FROM schools", [], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
  end

  def get(id) do
    Postgrex.query!(DB, "SELECT * FROM schools WHERE id = $1 LIMIT 1", [String.to_integer(id)],
      pool: DBConnection.ConnectionPool
    ).rows
    |> to_struct
  end

  def update(id, school_name) do
    id = String.to_integer(id)

    Postgrex.query!(
      DB,
      "UPDATE schools SET school_name = $1 WHERE id = $2",
      [school_name, id],
      pool: DBConnection.ConnectionPool
    )
  end

  def create(school_name) do
    Postgrex.query!(DB, "INSERT INTO schools (school_name) VALUES ($1)", [school_name],
      pool: DBConnection.ConnectionPool
    )
  end

  def delete(id) do
    Postgrex.query!(DB, "DELETE FROM schools WHERE id = $1", [String.to_integer(id)],
      pool: DBConnection.ConnectionPool
    )
  end

  def to_struct([[id, school_name]]) do
    %School{id: id, school_name: school_name}
  end

  def to_struct_list(rows) do
    for [id, school_name] <- rows, do: %School{id: id, school_name: school_name}
  end
end
