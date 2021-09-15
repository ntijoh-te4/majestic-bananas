defmodule WTF.Router do
  use Plug.Router
  use Plug.Debugger

  alias WTF.SchoolController

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

  # should be put /fruits/:id, but put/patch/delete are not supported without hidden inputs
  post("/schools/:id/edit", do: SchoolController.update(conn, id, conn.body_params))

  # should be delete /fruits/:id, but put/patch/delete are not supported without hidden inputs
  post("/schools/:id/destroy", do: SchoolController.destroy(conn, id))

  # post("/schools/login", do: UserController.login(conn, conn.body_params))
  # post("/schools/logout", do: UserController.logout(conn))

  # Classes

  # Students

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
