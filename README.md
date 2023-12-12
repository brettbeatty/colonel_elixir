# [Colonel](https://youtu.be/0Xb-oLS-cyY?t=18)

Colonel is intended to provide functions that could be imagined in Kernel but aren't there.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `colonel` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:colonel, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/colonel>.

## Ideas

### Chardata/IO Data Sigil

Strings and the [~s sigil](https://hexdocs.pm/elixir/Kernel.html#sigil_s/2) construct binaries from interpolated values.
There can be a number of advantages to [IO data](https://hexdocs.pm/elixir/IO.html#module-io-data) or
[chardata](https://hexdocs.pm/elixir/IO.html#module-chardata) over binaries, but building them with literals may not
read as obviously. It would be fairly easy to have a sigil that builds lists instead of binaries.

### Inspect to Chardata/IO Data

[Kernel.inspect/2](https://hexdocs.pm/elixir/Kernel.html#inspect/2) uses the
[Inspect](https://hexdocs.pm/elixir/Inspect.html) protocol to inspect Elixir terms. It builds iodata then constructs
a binary as its [last step](https://github.com/elixir-lang/elixir/blob/v1.15.7/lib/elixir/lib/kernel.ex#L2367).

There can be a number of advantages to instead return [IO data](https://hexdocs.pm/elixir/IO.html#module-io-data) or
[chardata](https://hexdocs.pm/elixir/IO.html#module-chardata), which could be accomplished by cutting out that last
step.


### Formatted Strings

Can we do anything to make [:io_lib.format/2](https://www.erlang.org/doc/man/io_lib.html#format-2) more Elixir-friendly?

### Then/Tap With/If

Frequently I find myself wanting to modify a value only if a condition is met. Often this means rebinding variables to
conditional expressions.

"with" expressions are convenient for modifying values only if they meet a certain condition. "if" expressions require
an "else" to return values when the condition is not met. But neither is great for modifying values via piping with `|>`.
Not without combining with [then/2](https://hexdocs.pm/elixir/Kernel.html#then/2).

I like to imagine a construct that makes it easy to make conditional changes to a value in a pipeline.

### Named Operators

Operators look great inline, but if you're piping values with `|>` calling operators you either end up with strange
steps like `|> Kernel.+(1)`, or you use [then/2](https://hexdocs.pm/elixir/Kernel.html#then/2) to build anonymous
wrappers like `|> then(fn x -> x + 1 end)`.

It would sometimes be nice to have named operators so you could just make calls like `|> add(1)`.

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

### Recursive Anonymous Functions

Erlang allows named anonymous functions (funny to call it that), which enables recursive calls in anonymous functions.
Elixir does not have that, so you have to pass the function in to itself to make recursive calls.

That could be easier with a utility function that takes an n-arity function and returns an (n-1)-arity function that
calls the original function with a reference to itself.

```elixir
recursive(fn
  [item | items], recurse ->
    [item + 1 | recurse.(items)

  [], _recurse ->
    []
end)
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
