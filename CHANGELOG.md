# Changelog

## Unreleased

### Conditional updates

Because of the way variables are bound in Elixir, conditionally applying many operations to data
can get verbose. `Colonel` now provides some pipe-friendly options for conditionally modifying
values:
- `Colonel.Experimental.then_if/3` is like a conditional `Kernel.then/2`
- `Colonel.Experimental.delete_if/3` is like a conditional `Kernel.pop_in/2` that returns only the updated structure
- `Colonel.Experimental.put_if/4` is like a conditional `Kernel.put_in/3`
- `Colonel.Experimental.update_if/4` is like a conditional `Kernel.update_in/3`
- `Colonel.Experimental.then_with/3` is an alternate form for single-clause `with`

### Power

`Colonel.Experimental` was missing an alias for `base ** exponent`, so `pow/2` was added.

## Introduce support for Elixir 1.18, drop 1.13

This is to stay in line with the versions of Elixir that receive security patches and the versions
of Erlang compatible with those Elixir versions.

## 0.3.0 (2024-11-29)

### Tag and Untag

A lot of Elixir code involves tagged tuples like `{:ok, value}` and `{:error, reason}`.
`Colonel.Experimental.tag/2` and `Colonel.Experimental.untag/2` allow for wrapping/unwrapping
values in/from tagged tuples.

### Loops

`Enum` has some great higher-order functions for working with enumerables, but they only work with
enumerables. `Colonel.Experimental.loop/2` provides a higher-order function for more generalized
recursion.

### Rename Inequal to Unequal

"Inequal" is an archaic synonym to "unequal", so `Colonel.Experimental.inequal?/2` and
`Colonel.Experimental.strictly_inequal?/2` are getting soft-deprecated in favor of the new
`Colonel.Experimental.unequal?/2` and `Colonel.Experimental.strictly_unequal?/2`.

## 0.2.0 (2024-06-15)

### Iodata conveniences

[Iodata and chardata](https://hexdocs.pm/elixir/io-and-the-file-system.html#iodata-and-chardata) can be cheaper than strings to build, but they're often not as nice to work with. `Colonel` now provides two conveniences for working with iodata and chardata:
- `Colonel.Experimental.iodata_inspect/2` does what `Kernel.inspect/2` does but returns the result as iodata instead of building one string from it.
- `Colonel.Experimental.sigil_i/2` provides an `~i` sigil for building iodata or chardata with a string interpolation syntax.

## 0.1.0 (2024-05-02)

### Named Aliases for Operators

Operators look great inline, but there some cases where named functions work better:
- When piping function calls with `|>`, operators can be a bit strange. You either have to pipe into an anonymous function using the operator, or you have to use the fully-qualified name like `|> Kernel.+(1)`.
- When creating anonymous functions with the `&` syntax, you can wrap named functions without additional parentheses.

Colonel 0.1.0 introduces to `Colonel.Experimental` a number of aliases for common operators:

`Colonel.Experimental` Function       | Operator
------------------------------------- | --------
`add(left, right)`                    | `left + right`
`and?(left, right)`                   | `left && right`
`binary_concat(left, right)`          | `left <> right`
`divide(left, right)`                 | `left / right`
`equal?(left, right)`                 | `left == right`
`greater_than?(left, right)`          | `left > right`
`greater_than_or_equal?(left, right)` | `left >= right`
`inequal?(left, right)`               | `left != right`
`less_than?(left, right)`             | `left < right`
`less_than_or_equal?(left, right)`    | `left <= right`
`list_concat(left, right)`            | `left ++ right`
`list_subtract(left, right)`          | `left -- right`
`multiply(left, right)`               | `left * right`
`negative(value)`                     | `-value`
`not?(value)`                         | `!value`
`or?(left, right)`                    | `left \|\| right`
`positive(value)`                     | `+value`
`strictly_equal?(left, right)`        | `left === right`
`strictly_inequal?(left, right)`      | `left !== right`
`subtract(left, right)`               | `left - right`

### Recursive Anonymous Functions

Anonymous functions can't reference themselves without taking a function as an argument and being called with it. `Colonel.Experimental.recursive/1` takes care of that boilerplate to make recursive anonymous functions.
