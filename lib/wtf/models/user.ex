defmodule WTF.User do 
    defstruct(user_id: nil, username: "", password: "", user_url: "", user_admin: nil)
  
    alias WTF.User 
  
    def all do
      Postgrex.query!(DB, "SELECT * FROM users", [], pool: DBConnection.ConnectionPool).rows 
      |> to_struct_list
    end

    def get(user_id) do
      Postgrex.query!(DB, "SELECT id, username FROM users WHERE id = $1 LIMIT 1", [id],
        pool: DBConnection.ConnectionPool
      ).rows
      |> to_struct
    end

    def update(user_id, username, password, user_url, user_admin) do
      user_id = String.to_integer(student_id)

        Postgrex.query!(
          DB,
          "UPDATE students SET username = $2, password = $3, user_url = $4, user_admin = $5 WHERE user_id = $1",
          [student_id, student_name, student_url, school_id, class_id],
          pool: DBConnection.ConnectionPool
    end

    def create() do
      Postgrex.query!(DB, "INSERT INTO users (username, password, user_url, user_admin) VALUES ($1, $2, $3, $4)", [school_name],
      pool: DBConnection.ConnectionPool
      
    end

    def delete(user_id) do
      Postgrex.query!(DB, "DELETE FROM users WHERE user_id = $1", [String.to_integer(user_id)]),
      pool: DBConnection.ConnectionPool
    end
  
    def to_struct([[user_id, username]]) do
      %User{user_id: user_id, username: username, password: password, user_url: user_url, user_admin: user_admin}
    end

    def to_struct_list(rows) do
      for [user_id, username, password, user_url, user_admin] <- rows, do: %Users{user_id: user_id, username: username, password: password, user_url: user_url, user_admin: user_admin}
    end
  end
  