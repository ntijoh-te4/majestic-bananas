defmodule Mix.Tasks.Seed do
  use Mix.Task

  @shortdoc "Resets & seeds the DB."
  def run(_) do
    Mix.Task.run "app.start"
    drop_tables()
    create_tables()
    seed_data()
  end

  defp drop_tables() do
    IO.puts("Dropping schools table..")
    Postgrex.query!(DB, "DROP TABLE IF EXISTS schools", [], pool: DBConnection.ConnectionPool)

    IO.puts("Dropping classes table..")
    Postgrex.query!(DB, "DROP TABLE IF EXISTS classes", [], pool: DBConnection.ConnectionPool)

    IO.puts("Dropping students table..")
    Postgrex.query!(DB, "DROP TABLE IF EXISTS students", [], pool: DBConnection.ConnectionPool)

    IO.puts("Dropping users table..")
    Postgrex.query!(DB, "DROP TABLE IF EXISTS users", [], pool: DBConnection.ConnectionPool)
  end

  defp create_tables() do
    IO.puts("Creating schools table..")
    Postgrex.query!(DB, "Create TABLE schools (school_id SERIAL, school_name VARCHAR(255) NOT NULL)", [], pool: DBConnection.ConnectionPool)

    IO.puts("Creating classes table..")
    Postgrex.query!(DB, "Create TABLE classes (class_id SERIAL, class_name VARCHAR(255) NOT NULL, school_id SERIAL)", [], pool: DBConnection.ConnectionPool)

    IO.puts("Creating student table..")
    Postgrex.query!(DB, "Create TABLE students (student_id SERIAL, student_name VARCHAR(255) NOT NULL, student_url VARCHAR(255) NOT NULL, school_id SERIAL, class_id SERIAL)", [], pool: DBConnection.ConnectionPool)

    IO.puts("Creating student table..")
    Postgrex.query!(DB, "Create TABLE users (user_id SERIAL, username VARCHAR(255) NOT NULL, password VARCHAR(255), user_url VARCHAR(255) NOT NULL, user_admin BOOL)", [], pool: DBConnection.ConnectionPool)
  end

  defp seed_data() do
    IO.puts("Seeding school data..")
    Postgrex.query!(DB, "INSERT INTO schools(school_name) VALUES($1)", ["NTI"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO schools(school_name) VALUES($1)", ["LBS"], pool: DBConnection.ConnectionPool)

    IO.puts("Seeding class data..")
    Postgrex.query!(DB, "INSERT INTO classes(class_name, school_id) VALUES($1, $2)", ["2A", 1], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO classes(class_name, school_id) VALUES($1, $2)", ["SY18", 2], pool: DBConnection.ConnectionPool)

    IO.puts("Seeding student data..")
    Postgrex.query!(DB, "INSERT INTO students(student_name, student_url, school_id, class_id) VALUES($1, $2, $3, $4)", ["Tom Cruise", "/images/Tom.jpg", 1, 1], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO students(student_name, student_url, school_id, class_id) VALUES($1, $2, $3, $4)", ["Chris Hemsworth", "/images/chris.jpg", 2, 2], pool: DBConnection.ConnectionPool)

    IO.puts("Seeding user data..")
    Postgrex.query!(DB, "INSERT INTO users(username, password, user_url, user_admin) VALUES($1, $2, $3, $4)", ["admin", "admin", "https/admin.png", true], pool: DBConnection.ConnectionPool)
  end

end
