defmodule WTF.Student do
    defstruct(student_id: nil, student_name: "", student_url: "", school_id: nil, class_id: nil)

    alias WTF.Student

    def all do
        Postgrex.query!(DB, "SELECT * FROM students", [], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
    end

    def get(student_id) do
        Postgrex.query!(DB, "SELECT * FROM students WHERE student_id = $1 LIMIT 1", [String.to_integer(student_id)],
          pool: DBConnection.ConnectionPool
        ).rows
        |> to_struct
    end

    def update(student_id, student_name, student_url, class_id, student_url, school_id) do
        student_id = String.to_integer(student_id)

        Postgrex.query!(
          DB,
          "UPDATE students SET student_name = $2, student_url = $3, school_id = $4, class_id = $5 WHERE student_id = $1",
          [student_id, student_name, student_url, school_id, class_id],
          pool: DBConnection.ConnectionPool
        )
    end

    def create(student_name, student_url, school_id, class_id) do
        Postgrex.query!(DB, "INSERT INTO students (student_name, student_url, school_id, class_id) VALUES ($1, $2, $3, $4)", [student_name, student_url, school_id, class_id],
        pool: DBConnection.ConnectionPool
      )
    end

    def delete(student_id) do
        Postgrex.query!(DB, "DELETE FROM students WHERE student_id = $1", [String.to_integer(student_id)],
        pool: DBConnection.ConnectionPool
      )
    end

    def to_struct([[student_id, student_name, student_url, class_id, school_id]]) do
        %Student{student_id: student_id, student_name: student_name, student_url: student_url, school_id: school_id, class_id: class_id}
    end
    def to_struct_list(rows) do
        for [student_id, student_name, student_url, class_id, school_id] <- rows, do: %Student{student_id: student_id, student_name: student_name, student_url: student_url, school_id: school_id, class_id: class_id }
    end
end
