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

  def stop(pid \\ __MODULE__) do
    GenServer.stop(pid)
  end

  @impl true
  def init(opts) do
    {:ok, manager_pid, os_pid} = start_stripe_mock(opts)
    {:ok, %{manager_pid: manager_pid, os_pid: os_pid, opts: opts, restarting: false}}
  end

  @impl true
  def handle_call(:reset, from, %{manager_pid: manager_pid, os_pid: os_pid} = state) do
    kill_stripe_mock(manager_pid)
    # restart automatically happens on receiving confirmation of death
    {:noreply, %{state | manager_pid: manager_pid, os_pid: os_pid, restarting: {true, from}}}
  end

  @impl true
  def terminate(_reason, %{manager_pid: manager_pid}) do
    Logger.debug("Terminating StripeMock")
    kill_stripe_mock(manager_pid)
  end

  @impl true
  def handle_info({:stdout, os_pid, msg}, %{os_pid: os_pid} = state) do
    Logger.debug("[stripe-mock:out] #{String.trim(msg)}")
    {:noreply, state}
  end

  @impl true
  def handle_info({:stderr, os_pid, msg}, %{os_pid: os_pid} = state) do
    Logger.debug("[stripe-mock] #{String.trim(msg)}")
    {:noreply, state}
  end

  @impl true
  def handle_info(
        %{os_pid: os_pid, opts: opts, restarting: {true, from}} = state,
        {:DOWN, os_pid, :process, _ex_pid, _reason}
      ) do
    {:ok, manager_pid, os_pid} = start_stripe_mock(opts)
    GenServer.reply(from, :ok)
    {:noreply, %{state | manager_pid: manager_pid, os_pid: os_pid, restarting: false}}
  end

  defp start_stripe_mock(opts) do
    executable = opts[:stripe_mock_path] || System.find_executable("stripe-mock")

    unless executable do
      raise(
        "Could not find stripe-mock. Make sure it's in your PATH or pass the :stripe_mock_path option."
      )
    end

    port = opts[:port] || 12111

    port_args =
      case port do
        nil -> []
        port when is_number(port) -> ["-port", Integer.to_string(port)]
        _ -> raise "port must be a number"
      end

    Logger.debug("Starting stripe_mock on port #{port}")
    Exexec.run([executable | port_args], monitor: true, stdout: true, stderr: true)
  end

  defp kill_stripe_mock(manager_pid) do
    Logger.debug("Killing stripe_mock")

    case Exexec.stop(manager_pid) do
      :ok ->
        :ok

      {:error, err} ->
        Logger.error("Error killing stripe_mock: #{inspect(err)}")
        :ok
    end
  end
end
