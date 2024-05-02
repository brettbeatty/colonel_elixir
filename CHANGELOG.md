# Changelog

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
