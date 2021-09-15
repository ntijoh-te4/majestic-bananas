defmodule WTF.School do
  defstruct(school_id: nil, school_name: "")

  alias WTF.School

  def all do
    Postgrex.query!(DB, "SELECT * FROM schools", [], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
  end

  def get(school_id) do
    Postgrex.query!(DB, "SELECT * FROM schools WHERE school_id = $1 LIMIT 1", [String.to_integer(school_id)],
      pool: DBConnection.ConnectionPool
    ).rows
    |> to_struct
  end

  def update(school_id, school_name) do
    school_id = String.to_integer(school_id)

    Postgrex.query!(
      DB,
      "UPDATE schools SET school_name = $1 WHERE school_id = $2",
      [school_name, school_id],
      pool: DBConnection.ConnectionPool
    )
  end

  def create(school_name) do
    Postgrex.query!(DB, "INSERT INTO schools (school_name) VALUES ($1)", [school_name],
      pool: DBConnection.ConnectionPool
    )
  end

  def delete(school_id) do
    Postgrex.query!(DB, "DELETE FROM schools WHERE school_id = $1", [String.to_integer(school_id)],
      pool: DBConnection.ConnectionPool
    )
  end

  def to_struct([[school_id, school_name]]) do
    %School{school_id: school_id, school_name: school_name}
  end

  def to_struct_list(rows) do
    for [school_id, school_name] <- rows, do: %School{school_id: school_id, school_name: school_name}
  end
end
