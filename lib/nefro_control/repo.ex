defmodule NefroControl.Repo do
  use Ecto.Repo,
    otp_app: :nefro_control,
    adapter: Ecto.Adapters.Postgres
end
