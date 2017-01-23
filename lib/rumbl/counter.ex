defmodule Rumbl.Counter do
  @moduledoc """
  iex> alias Rumbl.Counter
  iex> {:ok, counter} = Counter.start_link(0)
  iex> Counter.inc(counter)
  :inc
  iex> Counter.inc(counter)
  :inc
  iex> Counter.val(counter)
  2
  iex> Counter.dec(counter)
  :dec
  iex> Counter.val(counter)
  1
  """

  def inc(pid), do: GenServer.cast(pid, :inc)
  def dec(pid), do: GenServer.cast(pid, :dec)
  def val(pid), do: GenServer.call(pid, :val)

  def start_link(initial_val) do
    GenServer.start_link(__MODULE__, initial_val)
  end

  def init(initial_val) do
    {:ok, initial_val}
  end

  def handle_cast(:inc, val) do
    {:noreply, val + 1}
  end

  def handle_cast(:dec, val) do
    {:noreply, val - 1}
  end

  def handle_call(:val, _from, val) do
    {:reply, val, val}
  end
end
