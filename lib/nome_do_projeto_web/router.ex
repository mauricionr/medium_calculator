defmodule NomeDoProjetoWeb.Router do
  use NomeDoProjetoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {NomeDoProjetoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NomeDoProjetoWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  scope "/api", NomeDoProjetoWeb do
    pipe_through :api
    get "/soma/:a/:b", CalculatorController, :add
    get "/subtracao/:a/:b", CalculatorController, :subtract
    get "/multiplicacao/:a/:b", CalculatorController, :multiply
    get "/divisao/:a/:b", CalculatorController, :divide
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:nome_do_projeto, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: NomeDoProjetoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
