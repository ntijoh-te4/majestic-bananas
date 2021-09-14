defmodule WTF do
  use Application

  def start(_type, _args) do
    WTF.Supervisor.start_link({})
  end

end
