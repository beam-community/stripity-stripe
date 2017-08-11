defmodule Stripe.StripeMock do
  use GenServer
  require Logger

  def start_link(opts \\ []) do
    start_opts =
      case opts[:global] do
        true -> [name: __MODULE__]
        _ -> []
      end

    GenServer.start_link(__MODULE__, opts, start_opts)
  end

  def reset(pid \\ __MODULE__) do
    GenServer.call(pid, :reset)
  end

  def stop (pid \\ __MODULE__) do
    GenServer.stop(pid)
  end

  @impl true
  def init(opts) do
    port_args =
      case opts[:port] do
        nil -> []
        port when is_number(port) -> ["-port", Integer.to_string(port)]
        _ -> raise "port must be a number"
      end

    executable = opts[:stripe_mock_path] || System.find_executable "stripe-mock"
    unless executable, do: raise "Could not find stripe-mock. Make sure it's in your PATH or pass the :stripe_mock_path option."

    mock = Port.open({:spawn_executable, executable}, [:binary, args: port_args])
    Logger.debug("Starting stripe_mock")
    {:ok, %{mock: mock, port_args: port_args, executable: executable}}
  end

  @impl true
  def handle_call(:reset, _from, %{mock: mock, port_args: port_args, executable: executable} = state) do
    Port.close(mock)
    Process.sleep(500) # allow external process to close
    mock = Port.open({:spawn_executable, executable}, [:binary, args: port_args])
    {:reply, :ok, %{state | mock: mock}}
  end

  @impl true
  def terminate(_reason, %{mock: mock}) do
    Logger.debug("Terminating StripeMock")
    if Port.info(mock), do: Port.close(mock)
  end
end