# [Colonel](https://youtu.be/0Xb-oLS-cyY?t=18)

Colonel is intended to provide functions that could be imagined in Kernel but aren't there.

## Installation

The package can be installed by adding `colonel` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:colonel, "~> 0.4.0"}
  ]
end
```

## Ideas

### Formatted Strings

Can we do anything to make [:io_lib.format/2](https://www.erlang.org/doc/man/io_lib.html#format-2) more Elixir-friendly?

### Function Wrapper

I sometimes find myself wanting to build anonymous functions that return already-known values. Often these functions are
0-arity, but occasionally they take arguments.

I'm imagining a function that does something like this:
```elixir
fn_wrap({:ok, value})
#=> fn -> {:ok, value} end

fn_wrap([a, b, c], 2)
#=> fn _, _ -> [a, b, c] end
```

### Non-Integer Ranges

Ranges are great for testing inclusion and generating series, but the built-in ones only support integers. It would be
cool to have ranges that could support any orderable and/or incrementable values, such as floats or dates.

### Local Accumulators

This one would be more an exercise to see if I could do it than something I personally want, but could the proposed
[local accumulator](https://elixirforum.com/t/local-accumulators-for-cleaner-comprehensions/60130) functionality be
provided by a library instead of being built into the language?

### Pipe-Friendly Flat Map Reduce

I see [Enum.flat_map_reduce/3](https://hexdocs.pm/elixir/Enum.html#flat_map_reduce/3) as one of the most powerful
constructs for working through enumerables, but if your acc is very complicated it can get unwieldy.

Would there be some structure into which we could reduce to provide a similar functionality? I'm picturing something
like this:
```elixir
acc =
  for value <- my_enumerable, reduce: Acc.new(a: %{}, b: 0) do
    acc ->
      acc
      |> Acc.yield(value * 2)
      |> Acc.update(:a, &Map.put(&1, value, acc[:b]))
      |> Acc.update(:b, & &1 + value)
  end

# get list
Acc.yielded(acc)

# get accumulated value
acc[:a]
```

### Match Function Builder

Most of the time I use `Kernel.match?/2` I am wrapping it an an anonymous function, like
`&match?({:some, pattern}, &1)`. Seems like a `match/1` macro to return the anonymous function
might be convenient: `match({:some, pattern})`.

### Secure Compare

For apps that want to do timing-safe comparison of strings that might not be the same length but
don't have a dependency on plug, should this library include a secure compare function?

### DateTime Comparison to Now

Right now it takes a few steps to answer questions like "has this datetime passed?" or "was this
datetime more than n minutes ago"? I think there could be some nice functions there.
