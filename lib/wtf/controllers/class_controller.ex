defmodule WTF.ClassController do
  require IEx

  alias WTF.Class
  alias WTF.School
  alias WTF.User
  alias WTF.Student
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

    send_resp(conn, 200, render("classes/index", classes: Class.all(), user: current_user))
  end

  def index_teacher(conn) do
    # get user if logged in
    session_user = conn.private.plug_session["user_id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> User.get(session_user)
      end

    send_resp(conn, 200, render("teacher/classes/index", classes: Class.all(), user: current_user))
  end
  def show_teacher(conn, id), do: send_resp(conn, 200, render("teacher/classes/show", class: Class.get(id), school: School.get(Class.get(id).school_id), students: Student.all(id)))

  def new(conn), do: send_resp(conn, 200, render("classes/new", []))
  def show(conn, id), do: send_resp(conn, 200, render("classes/show", class: Class.get(id), school: School.get(Class.get(id).school_id), students: Student.all(id)))
  def edit(conn, id), do: send_resp(conn, 200, render("classes/edit", class: Class.get(id), school: School.get(Class.get(id).school_id), students: Student.all(id)))

  def create(conn, params) do
    Class.create(params["class_name"], String.to_integer(params["school_id"]))
    redirect(conn, "/classes")
  end

  def update(conn, id, params) do
    Class.update(id, params["class_name"], String.to_integer(params["school_id"]))
    redirect(conn, "/classes")
  end

  def destroy(conn, id) do
    Class.delete(id)
    redirect(conn, "/classes")
  end

  defp redirect(conn, url) do
    Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  end
end
