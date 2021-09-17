defmodule WTF.UserController do
  require IEx
  # import Pluggy.Template, only: [render: 2] #det här exemplet renderar inga templates
    alias WTF.User
    import Plug.Conn, only: [send_resp: 3]
    import WTF.Template, only: [render: 2]

    def index(conn) do
      # get user if logged in
      session_user = conn.private.plug_session["user_id"]

      current_user =
        case session_user do
          nil -> nil
          _ -> User.get([session_user])
        end

      send_resp(conn, 200, render("index", user_id: current_user))
    end

    def login(conn, params) do
      username = params["username"]
      password = params["password"]

      result =
        Postgrex.query!(DB, "SELECT user_id, password FROM users WHERE username = $1", [username],
          pool: DBConnection.ConnectionPool
        )

      case result.num_rows do
        # no user with that username
        0 ->
          redirect(conn, "/")
        # user with that username exists
        _ ->
          [[id, password]] = result.rows

          # make sure password is correct
            Plug.Conn.put_session(conn, :user_id, id)
            |> redirect("/schools") #skicka vidare modifierad conn
            redirect(conn, "/")
        
      end
    end

    def logout(conn) do
      Plug.Conn.configure_session(conn, drop: true) #tömmer sessionen
      |> redirect("/")
    end

    def new(conn), do: send_resp(conn, 200, render("users/new", []))
    def show(conn, id), do: send_resp(conn, 200, render("users/show", user: Users.get(id)))
    def edit(conn, id), do: send_resp(conn, 200, render("users/edit", user: Users.get(id)))

    def create(conn, params) do
      User.create(params["username"], params["password"], params["user_url"], params["user_admin"])
      redirect(conn, "/schools")
    end

    def update(conn, id, params) do
      User.update(id, params["username"], params["password"], params["user_url"], params["user_admin"])
      redirect(conn, "/schools")
    end

    def destroy(conn, id) do
      User.delete(id)
      redirect(conn, "/schools")
    end

    defp redirect(conn, url), do: Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  end
