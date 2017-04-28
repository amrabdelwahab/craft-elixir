defmodule Craft.EchoTest do
  use ExUnit.Case, async: true
  alias Craft.Echo

  test "echo" do
    {:ok, pid} = Echo.start_link()
    Echo.async_send(pid, :hello)
    assert_receive :hello
    Echo.async_send(pid, :hello)
    assert_receive :hello
    Echo.async_send(pid, :hello)
    assert_receive :hello

    send(pid, :another_message)
    assert Process.alive?(pid )
  end

  test "times out after 50 ms" do
    {:ok, pid} = Echo.start_link()
    Process.sleep(51)
    refute Process.alive?(pid )
  end
end
