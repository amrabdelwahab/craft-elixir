defmodule Craft.Echo do
  @receive_timeout 50
  def start_link do
    pid = spawn_link(Craft.Echo, :keep_receiving, [])

    {:ok, pid}
  end

  def send(pid, msg) do
    Kernel.send(pid, {msg, self()})
  end

  def keep_receiving do
    receive do
      {msg, caller} -> 
        Kernel.send(caller, msg)
        keep_receiving()
      _msg -> keep_receiving()
    after
      @receive_timeout -> exit(:normal)
    end
  end
end
