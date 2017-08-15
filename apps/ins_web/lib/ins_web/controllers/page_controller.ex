defmodule InsWeb.PageController do
  use InsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
