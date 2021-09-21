defmodule WTF.Game do

  alias WTF.Student

  def get_correct_student(string) do
    Postgrex.query!(DB, "SELECT * FROM students WHERE student_id NOT in (#{string}) ORDER BY RANDOM() LIMIT 1", [], pool: DBConnection.ConnectionPool).rows
    |> Student.to_struct_list
  end

  def get_random do
    Postgrex.query!(DB, "SELECT * FROM students ORDER BY RANDOM() LIMIT 5", [], pool: DBConnection.ConnectionPool).rows
    |> Student.to_struct_list
  end

  def get_random_students(correct_student_id) do
    Postgrex.query!(DB, "SELECT * FROM students WHERE student_id NOT in (#{correct_student_id}) ORDER BY RANDOM() LIMIT 4", [], pool: DBConnection.ConnectionPool).rows
    |> Student.to_struct_list
  end
end
