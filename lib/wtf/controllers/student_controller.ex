defmodule WTF.StudentController do
  require IEx

  alias WTF.Student
  alias WTF.User
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

    send_resp(conn, 200, render("students/index", students: Student.all(), user: current_user))
  end

  def index_teacher(conn) do
    # get user if logged in
    session_user = conn.private.plug_session["user_id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> User.get(session_user)
      end

    send_resp(conn, 200, render("teacher/students/index", students: Student.all(), user: current_user))
  end
  def show_teacher(conn, id), do: send_resp(conn, 200, render("teacher/students/show", student: Student.get(id)))

  def new(conn), do: send_resp(conn, 200, render("students/new", []))
  def show(conn, id), do: send_resp(conn, 200, render("students/show", student: Student.get(id)))
  def edit(conn, id), do: send_resp(conn, 200, render("students/edit", student: Student.get(id)))

  def create(conn, params) do
    Student.create(params["student_name"], params["student_url"], String.to_integer(params["school_id"]), String.to_integer(params["class_id"]))
    redirect(conn, "/students")
  end

  def update(conn, id, params) do
    Student.update(id, params["student_name"])
    redirect(conn, "/students")
  end

  def destroy(conn, id) do
    Student.delete(id)
    redirect(conn, "/students")
  end

  defp redirect(conn, url) do
    Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  end
end
