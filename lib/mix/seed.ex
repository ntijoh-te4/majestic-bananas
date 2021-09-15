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
    Postgrex.query!(DB, "DROP TABLE IF EXISTS schools", [], pool: DBConnection.ConnectionPool)
  end

  defp create_tables() do
    IO.puts("Creating tables..")
    Postgrex.query!(DB, "Create TABLE schools (id SERIAL, school_name VARCHAR(255) NOT NULL)", [], pool: DBConnection.ConnectionPool)
  end

  defp seed_data() do
    IO.puts("Seeding data..")
    Postgrex.query!(DB, "INSERT INTO schools(school_name) VALUES($1)", ["NTI"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO schools(school_name) VALUES($1)", ["LBS"], pool: DBConnection.ConnectionPool)
  end

end
