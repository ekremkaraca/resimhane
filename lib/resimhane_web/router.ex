defmodule ResimhaneWeb.Router do
  use ResimhaneWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :api_auth do
    plug :ensure_authenticated
  end

  scope "/api", ResimhaneWeb do
    pipe_through :api
    post "/users/sign_in", UserController, :sign_in
  end

  scope "/api", ResimhaneWeb do
    pipe_through [:api, :api_auth]
    resources "/users", UserController, except: [:new, :edit]
  end

  defp ensure_authenticated(conn, _opts) do
    current_user_id = get_session(conn, :current_user_id)
    if current_user_id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> render(ResimhaneWeb.ErrorView,
                "401.json",
                message: "Authentication Failed")
      |> halt()
    end
  end
end
