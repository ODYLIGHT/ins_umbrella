defmodule Ins.Application do
  @moduledoc """
  The Ins Application Service.

  The ins system business domain lives in this application.

  Exposes API to clients such as the `InsWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Ins.Repo, []),
    ], strategy: :one_for_one, name: Ins.Supervisor)
  end
end
