defmodule Craft.EchoTest do
  use ExUnit.Case, async: true
  alias Craft.Echo

  test "echo" do
    {:ok, pid} = Echo.start_link()
    Echo.send(pid, :hello)
    assert_receive :hello
    Echo.send(pid, :hello)
    assert_receive :hello
    Echo.send(pid, :hello)
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
