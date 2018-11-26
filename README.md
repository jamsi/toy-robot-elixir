# Toy Robot

This project aims to solve the popular Toy Robot Similation, a programming challenge developed by Jon Eaves when he had to evaluate a [large number of hires @ ANZ in 2007](https://joneaves.wordpress.com/2014/07/21/toy-robot-coding-test/).

This implementation uses the Elixir programming language and takes advantage of GenServers!

To interact with the robot, launch an IEX console

```bash
iex -S mix
```

You'll find that the robot has already followed a set of instructions, being;

```
PLACE 0,0,NORTH
MOVE
MOVE
RIGHT
MOVE
MOVE
LEFT
LEFT
MOVE
REPORT
```

The expected result should be 1,2,WEST

Once the IEX console is open, you can perform the following commands;

```elixir
iex(1)> ToyRobot.report
{1, 2, "WEST"}
iex(2)> ToyRobot.right
:ok
iex(3)> ToyRobot.report
{1, 2, "NORTH"}
iex(4)> ToyRobot.right
:ok
iex(5)> ToyRobot.report
{1, 2, "EAST"}
iex(6)> ToyRobot.move
:ok
iex(7)> ToyRobot.report
{2, 2, "EAST"}
iex(8)>
```