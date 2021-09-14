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
    IO.puts("Dropping tables..")
    Postgrex.query!(DB, "DROP TABLE IF EXISTS classes", [], pool: DBConnection.ConnectionPool)
  end

  defp create_tables() do
    IO.puts("Creating tables..")
    Postgrex.query!(DB, "Create TABLE classes (id SERIAL, school_name VARCHAR(255) NOT NULL)", [], pool: DBConnection.ConnectionPool)
  end

  defp seed_data() do
    IO.puts("Seeding data..")
    Postgrex.query!(DB, "INSERT INTO classes(school_name) VALUES($1)", ["TE4"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO classes(school_name) VALUES($1)", ["3B"], pool: DBConnection.ConnectionPool)
  end

end
