defmodule WTF.Router do
  use Plug.Router
  use Plug.Debugger

  alias WTF.SchoolController
  alias WTF.ClassController
  alias WTF.StudentController

  plug(Plug.Static, at: "/", from: :wtf)
  plug(:put_secret_key_base)

  plug(Plug.Session,
    store: :cookie,
    key: "_wtf_session",
    encryption_salt: "cookie store encryption salt",
    signing_salt: "cookie store signing salt",
    key_length: 64,
    log: :debug,
    secret_key_base: "-- LONG STRING WITH AT LEAST 64 BYTES -- LONG STRING WITH AT LEAST 64 BYTES --"
  )

  plug(:fetch_session)
  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])
  plug(:match)
  plug(:dispatch)

  # Schools

  get("/schools", do: SchoolController.index(conn))
  get("/schools/new", do: SchoolController.new(conn))
  get("/schools/:id", do: SchoolController.show(conn, id))
  get("/schools/:id/edit", do: SchoolController.edit(conn, id))
  post("/schools", do: SchoolController.create(conn, conn.body_params))
  post("/schools/:id/edit", do: SchoolController.update(conn, id, conn.body_params))
  post("/schools/:id/destroy", do: SchoolController.destroy(conn, id))

  # post("/schools/login", do: UserController.login(conn, conn.body_params))
  # post("/schools/logout", do: UserController.logout(conn))

  # Classes
  get("/classes", do: ClassController.index(conn))
  get("/classes/new", do: ClassController.new(conn))
  get("/classes/:id", do: ClassController.show(conn, id))
  get("/classes/:id/edit", do: ClassController.edit(conn, id))

  post("/classes", do: ClassController.create(conn, conn.body_params))

  post("/classes/:id/edit", do: ClassController.update(conn, id, conn.body_params))

  post("/classes/:id/destroy", do: ClassController.destroy(conn, id))

  # Students
  get("/students", do: StudentController.index(conn))
  get("/students/new", do: StudentController.new(conn))
  get("/students/:id", do: StudentController.show(conn, id))
  get("/students/:id/edit", do: StudentController.edit(conn, id))

  post("/students", do: StudentController.create(conn, conn.body_params))

  post("/students/:id/edit", do: StudentController.update(conn, id, conn.body_params))

  post("/students/:id/destroy", do: StudentController.destroy(conn, id))


  get("/students", do: StudentController.index(conn))
  get("/students/new", do: StudentController.new(conn))
  get("/students/:id", do: StudentController.show(conn, id))
  get("/students/:id/edit", do: StudentController.edit(conn, id))
  post("/students", do: StudentController.create(conn, conn.body_params))
  post("/students/:id/edit", do: StudentController.update(conn, id, conn.body_params))
  post("/students/:id/destroy", do: StudentController.destroy(conn, id))

  match _ do
    send_resp(conn, 404, "oops")
  end

  defp put_secret_key_base(conn, _) do
    put_in(
      conn.secret_key_base,
      "-- LONG STRING WITH AT LEAST 64 BYTES LONG STRING WITH AT LEAST 64 BYTES --"
    )
  end
end
