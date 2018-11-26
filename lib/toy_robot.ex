defmodule ToyRobot do
  use GenServer

  def init(_) do
    {:ok, {0,0,"NORTH"}}
  end

  def start do
    GenServer.start_link(ToyRobot, [], name: ToyRobot)

    """
    PLACE 0,0,NORTH
    MOVE
    MOVE
    RIGHT
    MOVE
    MOVE
    LEFT
    LEFT
    MOVE
    REPORT\
    """
    |> String.split("\n")
    |> Enum.each(fn

      "PLACE " <> args ->
        args = String.split(args, ",")
        place(String.to_integer(Enum.at(args, 0)), String.to_integer(Enum.at(args, 1)), Enum.at(args, 2))

      "LEFT" ->
        left()

      "RIGHT" ->
        right()

      "MOVE" ->
        move()

      "REPORT" ->
        report()
    end)
  end

  def place(x, y, f) do
    GenServer.call(ToyRobot, {:place, x, y, f})
  end

  def move do
    GenServer.call(ToyRobot, :move)
  end

  def report do
    GenServer.call(ToyRobot, :report)
  end

  def left do
    GenServer.call(ToyRobot, :left)
  end

  def right do
    GenServer.call(ToyRobot, :right)
  end

  def handle_call({:place, x, y, f}, _from), do: {:reply, :ok, {x, y, f}}
  def handle_call(:move, _from, {x, y, "NORTH"}) when y < 4, do: {:reply, :ok, {x, y+1, "NORTH"}}
  def handle_call(:move, _from, {x, y, "SOUTH"}) when y > 0, do: {:reply, :ok, {x, y-1, "SOUTH"}}
  def handle_call(:move, _from, {x, y, "WEST"}) when x > 0, do: {:reply, :ok, {x-1, y, "WEST"}}
  def handle_call(:move, _from, {x, y, "EAST"}) when x < 4, do: {:reply, :ok, {x+1, y, "EAST"}}
  def handle_call(:left, _from, {x, y, "NORTH"}), do: {:reply, :ok, {x, y, "WEST"}}
  def handle_call(:left, _from, {x, y, "EAST"}), do: {:reply, :ok, {x, y, "NORTH"}}
  def handle_call(:left, _from, {x, y, "WEST"}), do: {:reply, :ok, {x, y, "SOUTH"}}
  def handle_call(:left, _from, {x, y, "SOUTH"}), do: {:reply, :ok, {x, y, "EAST"}}
  def handle_call(:right, _from, {x, y, "NORTH"}), do: {:reply, :ok, {x, y, "EAST"}}
  def handle_call(:right, _from, {x, y, "EAST"}), do: {:reply, :ok, {x, y, "SOUTH"}}
  def handle_call(:right, _from, {x, y, "WEST"}), do: {:reply, :ok, {x, y, "NORTH"}}
  def handle_call(:right, _from, {x, y, "SOUTH"}), do: {:reply, :ok, {x, y, "EAST"}}
  def handle_call(:report, _from, state), do: {:reply, state, state}

  # Default
  def handle_call(_, _from, state), do: {:reply, :nochange, state}

end
