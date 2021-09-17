#reuse with changed variable names

defmodule WTF.SchoolController do
  require IEx

  alias WTF.User
  alias WTF.School
  alias WTF.Class
  import WTF.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def index(conn) do
    # get user if logged in
    session_user = conn.private.plug_session["user_id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> User.get(session_user)
      end

    send_resp(conn, 200, render("schools/index", schools: School.all(), user: current_user))
  end

  def new(conn), do: send_resp(conn, 200, render("schools/new", []))
  def show(conn, id), do: send_resp(conn, 200, render("schools/show", school: School.get(id), classes: Class.all(id)))
  def edit(conn, id), do: send_resp(conn, 200, render("schools/edit", school: School.get(id), classes: Class.all(id)))

  def create(conn, params) do
    School.create(params["school_name"])
    redirect(conn, "/schools")
  end

  def update(conn, id, params) do
    School.update(id, params["school_name"])
    redirect(conn, "/schools")
  end

  def destroy(conn, id) do
    School.delete(id)
    redirect(conn, "/schools")
  end

  defp redirect(conn, url) do
    Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  end
end
