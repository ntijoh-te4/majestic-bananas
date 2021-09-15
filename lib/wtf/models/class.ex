defmodule WTF.Class do
    defstruct(class_id: nil, class_name: "", school_id: nil)

    alias WTF.Class

    def all do
        Postgrex.query!(DB, "SELECT * FROM classes", [], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
    end

    def get(class_id) do
        Postgrex.query!(DB, "SELECT * FROM classes WHERE class_id = $1 LIMIT 1", [String.to_integer(class_id)],
          pool: DBConnection.ConnectionPool
        ).rows
        |> to_struct
    end

    def update(class_id, class_name, school_id) do
        class_id = String.to_integer(class_id)

        Postgrex.query!(
          DB,
          "UPDATE classes SET class_name = $1, school_id = $3 WHERE class_id = $2" ,
          [class_name, class_id, school_id],
          pool: DBConnection.ConnectionPool
        )
    end

    def create(class_name) do
        Postgrex.query!(DB, "INSERT INTO classes (class_name) VALUES ($1)", [class_name],
        pool: DBConnection.ConnectionPool
      )
    end

    def delete(class_id) do
        Postgrex.query!(DB, "DELETE FROM classes WHERE class_id = $1", [String.to_integer(class_id)],
        pool: DBConnection.ConnectionPool
      )
    end

    def to_struct([[class_id, class_name, school_id]]) do
        %Class{class_id: class_id, class_name: class_name, school_id: school_id}
      end

    def to_struct_list(rows) do
        for [class_id, class_name, school_id] <- rows, do: %Class{class_id: class_id, class_name: class_name, school_id: school_id}
    end
end
