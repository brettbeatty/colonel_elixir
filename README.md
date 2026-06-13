# [Colonel](https://youtu.be/0Xb-oLS-cyY?t=18)

Colonel is intended to provide functions that could be imagined in Kernel but aren't there.

## Installation

The package can be installed by adding `colonel` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:colonel, "~> 0.5.0"}
  ]
end
```

## Colonel vs. Colonel.Experimental

The `Colonel` module is intended to contain stable, popular functions that should stick around awhile. New functions are added to `Colonel.Experimental` for folks to try out before they make it to `Colonel`. These functions are more likely to be changed or deprecated.
