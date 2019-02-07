defmodule BlogWeb.Router do
  use BlogWeb, :router

#  def require_token_middleware(conn, _opts) do
#    token = conn |> get_req_header("token") |> List.first()
#
#    if (is_nil(token) || String.length(String.trim(token)) <= 0) do
#      conn
#      |> Plug.Conn.resp(:unauthorized, "") # 401
#      |> Plug.Conn.send_resp
#      |> Plug.Conn.halt()
#    else
#      conn
#    end
#  end

  pipeline :api do
    plug :accepts, ["json"]
    # plug :require_token_middleware
  end

  scope "/api", BlogWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/posts", PostController, except: [:new, :edit] do
      resources "/comments", CommentController, except: [:new, :edit]
    end
  end
end
