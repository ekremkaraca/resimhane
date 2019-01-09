defmodule Resimhane.Repo do
  use Ecto.Repo,
    otp_app: :resimhane,
    adapter: Ecto.Adapters.Postgres
end
