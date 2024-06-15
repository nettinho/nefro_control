defmodule NefroControlWeb.Router do
  use NefroControlWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {NefroControlWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug NefroControl.UAInspectPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NefroControlWeb do
    pipe_through :browser

    live "/", HomeLive
    live "/modal/intakes", HomeLive, :intakes
    live "/modal/outputs", HomeLive, :outputs
    live "/modal/events", HomeLive, :events

    live "/intakes", IntakeLive.Index, :index
    live "/intakes/new", IntakeLive.Index, :new
    live "/intakes/:id/edit", IntakeLive.Index, :edit
    live "/intakes/:id", IntakeLive.Show, :show
    live "/intakes/:id/show/edit", IntakeLive.Show, :edit

    live "/outputs", OutputLive.Index, :index
    live "/outputs/new", OutputLive.Index, :new
    live "/outputs/:id/edit", OutputLive.Index, :edit
    live "/outputs/:id", OutputLive.Show, :show
    live "/outputs/:id/show/edit", OutputLive.Show, :edit

    live "/events", EventLive.Index, :index
    live "/events/new", EventLive.Index, :new
    live "/events/:id/edit", EventLive.Index, :edit
    live "/events/:id", EventLive.Show, :show
    live "/events/:id/show/edit", EventLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", NefroControlWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:nefro_control, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: NefroControlWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
