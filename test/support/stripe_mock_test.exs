defmodule Stripe.StripeMockTest do
  use ExUnit.Case, async: false
  alias Stripe.StripeMock
  require StripeMock

  # needed because the external process takes a while to spin up
  defp delay(time \\ 100) do
    Process.sleep(time)
  end

  defp assert_port_open(port) do
    delay()
    assert {:ok, socket} = :gen_tcp.connect('localhost', port, [])
    :gen_tcp.close(socket)
  end

  @tag :disabled
  test "mock can be started globally and defaults to port 12111" do
    assert {:ok, pid} = StripeMock.start_link(global: true)
    assert Process.whereis(StripeMock) == pid
    assert_port_open(12111)
    StripeMock.stop()
  end

  @tag :disabled
  test "mock can be started locally" do
    assert {:ok, pid} = StripeMock.start_link()
    refute Process.whereis(StripeMock) == pid
    assert_port_open(12111)
    StripeMock.stop(pid)
  end

  @tag :disabled
  test "mock can be started with a specific port" do
    assert {:ok, pid} = StripeMock.start_link(port: 19275)
    assert_port_open(19275)
    StripeMock.stop(pid)
  end

  @tag :disabled
  test "mock can be reset" do
    assert {:ok, pid} = StripeMock.start_link(port: 19275)
    assert_port_open(19275)
    assert :ok = StripeMock.reset(pid)
    assert_port_open(19275)
    StripeMock.stop(pid)
  end
end
