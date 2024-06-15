
defmodule NefroControl.UAInspectPlug  do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    conn
      |> Plug.Conn.get_req_header("user-agent")
      |> dbg
    conn
  end
end
