defmodule Colonel.Experimental do
  @moduledoc """
  A proving ground for functions before they make it into `Colonel` proper.
  """

  @doc """
  Translates to `left + right`.

  ## Examples

      iex> add(1, 2)
      3

  """
  @doc since: "0.1.0"
  @spec add(integer(), integer()) :: integer()
  @spec add(float(), float()) :: float()
  @spec add(integer(), float()) :: float()
  @spec add(float(), integer()) :: float()
  def add(left, right) do
    left + right
  end

  @doc """
  Translates to `left && right`.

  ## Examples

      iex> and?(nil, false)
      nil

      iex> and?(1, nil)
      nil

      iex> and?(false, 2)
      false

      iex> and?(true, 2)
      2

  """
  @doc since: "0.1.0"
  @spec and?(as_boolean(left), as_boolean(right)) :: as_boolean(left | right)
        when left: term(), right: term()
  def and?(left, right) do
    left && right
  end

  @doc """
  Translates to `left <> right`.

  ## Examples

      iex> binary_concat("foo", "bar")
      "foobar"

  """
  @doc since: "0.1.0"
  @spec binary_concat(binary(), binary()) :: binary()
  def binary_concat(left, right) do
    left <> right
  end

  @doc """
  Delete from structure if condition is met.

  Uses the `Access` behaviour to perform the delete, so keys are a list as with
  `Kernel.get_and_update_in/3` and its companions.

  ## Examples

      iex> delete_if(%{items: [:a, :b, :c]}, true, [:items, Access.at(1)])
      %{items: [:a, :c]}

      iex> delete_if(%{key: "value"}, false, [:key])
      %{key: "value"}

  """
  @doc since: "unreleased"
  @spec delete_if(data, as_boolean(term()), [
          Access.get_and_update_fun(data, term()) | term(),
          ...
        ]) :: data
        when data: Access.container()
  def delete_if(data, condition, keys) do
    if condition do
      {_value, data} = pop_in(data, keys)
      data
    else
      data
    end
  end

  @doc """
  Translates to `left / right`.

  ## Examples

      iex> divide(1, 2)
      0.5

  """
  @doc since: "0.1.0"
  @spec divide(number(), number()) :: float()
  def divide(left, right) do
    left / right
  end

  @doc """
  Translates to `left == right`.

  ## Examples

      iex> equal?(1, 2)
      false

      iex> equal?(1, 1.0)
      true

  """
  @doc since: "0.1.0"
  @spec equal?(term(), term()) :: boolean()
  def equal?(left, right) do
    left == right
  end

  @doc """
  Translates to `left > right`.

  ## Examples

      iex> greater_than?(1, 2)
      false

  """
  @doc since: "0.1.0"
  @spec greater_than?(term(), term()) :: boolean()
  def greater_than?(left, right) do
    left > right
  end

  @doc """
  Translates to `left >= right`.

  ## Examples

      iex> greater_than_or_equal?(1, 2)
      false

  """
  @doc since: "0.1.0"
  @spec greater_than_or_equal?(term(), term()) :: boolean()
  def greater_than_or_equal?(left, right) do
    left >= right
  end

  @doc """
  Translates to `left != right`.

  ## Examples

      iex> inequal?(1, 2)
      true

      iex> inequal?(1, 1.0)
      false

  """
  @doc since: "0.1.0"
  @doc deprecated: "Prefer `unequal?/2`"
  @spec inequal?(term(), term()) :: boolean()
  def inequal?(left, right) do
    left != right
  end

  @doc """
  Does the same thing as `inspect/2` but returns IO data instead of a string.

  See ["`iodata` and `chardata`"](`e:elixir:io-and-the-file-system.html#iodata-and-chardata`).

  ## Examples

      iex> iodata_inspect(:foo)
      [":foo"]

      iex> iodata_inspect([1, 2, 3, 4, 5], limit: 3)
      ["[", "1", ",", " ", "2", ",", " ", "3", ",", " ", "...", "]"]

      iex> iodata_inspect([1, 2, 3], pretty: true, width: 0)
      ["[", "1", ",", "\\n ", "2", ",", "\\n ", "3", "]"]

      iex> iodata_inspect("olá" <> <<0>>)
      ["<<", "111", ",", " ", "108", ",", " ", "195", ",", " ", "161", ",", " ", "0", ">>"]

      iex> iodata_inspect("olá" <> <<0>>, binaries: :as_strings)
      [~S("olá\\0")]

      iex> iodata_inspect("olá", binaries: :as_binaries)
      ["<<", "111", ",", " ", "108", ",", " ", "195", ",", " ", "161", ">>"]

      iex> iodata_inspect([0 | ~c"bar"])
      ["[", "0", ",", " ", "98", ",", " ", "97", ",", " ", "114", "]"]

      iex> iodata_inspect(100, base: :octal)
      ["0o144"]

      iex> iodata_inspect(100, base: :hex)
      ["0x64"]

  """
  @doc since: "0.2.0"
  @spec iodata_inspect(Inspect.t(), keyword()) :: iodata()
  def iodata_inspect(term, opts \\ []) when is_list(opts) do
    opts = Inspect.Opts.new(opts)

    limit =
      case opts.pretty do
        true -> opts.width
        false -> :infinity
      end

    term
    |> Inspect.Algebra.to_doc(opts)
    |> Inspect.Algebra.group()
    |> Inspect.Algebra.format(limit)
  end

  @doc """
  Translates to `left < right`.

  ## Examples

      iex> less_than?(1, 2)
      true

  """
  @doc since: "0.1.0"
  @spec less_than?(term(), term()) :: boolean()
  def less_than?(left, right) do
    left < right
  end

  @doc """
  Translates to `left <= right`.

  ## Examples

      iex> less_than_or_equal?(1, 2)
      true

  """
  @doc since: "0.1.0"
  @spec less_than_or_equal?(term(), term()) :: boolean()
  def less_than_or_equal?(left, right) do
    left <= right
  end

  @doc """
  Translates to `left ++ right`.

  ## Examples

      iex> list_concat([1], [2, 3])
      [1, 2, 3]

  """
  @doc since: "0.1.0"
  @spec list_concat(list(), term()) :: maybe_improper_list()
  def list_concat(left, right) do
    left ++ right
  end

  @doc """
  Translates to `left -- right`.

  ## Examples

      iex> list_subtract([1, 2, 3], [1, 2])
      [3]

  """
  @doc since: "0.1.0"
  @spec list_subtract(list(), list()) :: list()
  def list_subtract(left, right) do
    left -- right
  end

  @doc """
  Calls `fun` with `acc` until halted.

  Function takes an acc and can return two things:
  - `{:cont, new_acc}` results in `fun` being called with `new_acc`
  - `{:halt, final_acc}` results in `loop/2` returning `final_acc`

  ## Examples

      iex> loop({5, 1}, fn
      ...>   {1, total} -> {:halt, total}
      ...>   {n, total} -> {:cont, {n - 1, n * total}}
      ...> end)
      120

  """
  @doc since: "0.3.0"
  @spec loop(acc, (acc -> {:cont, acc} | {:halt, final_acc})) :: final_acc
        when acc: term(), final_acc: term()
  def loop(acc, fun) do
    case fun.(acc) do
      {:cont, new_acc} -> loop(new_acc, fun)
      {:halt, final_acc} -> final_acc
    end
  end

  @doc """
  Translates to `left * right`.

  ## Examples

      iex> multiply(1, 2)
      2

  """
  @doc since: "0.1.0"
  @spec multiply(integer(), integer()) :: integer()
  @spec multiply(float(), float()) :: float()
  @spec multiply(integer(), float()) :: float()
  @spec multiply(float(), integer()) :: float()
  def multiply(left, right) do
    left * right
  end

  @doc """
  Translates to `-value`.

  ## Examples

      iex> negative(2)
      -2

  """
  @doc since: "0.1.0"
  @spec negative(0) :: 0
  @spec negative(pos_integer()) :: neg_integer()
  @spec negative(neg_integer()) :: pos_integer()
  @spec negative(float()) :: float()
  def negative(value) do
    -value
  end

  @doc """
  Translates to `!value`.

  ## Examples

      iex> not?(nil)
      true

      iex> not?(1)
      false

  """
  @doc since: "0.1.0"
  @spec not?(as_boolean(term())) :: boolean()
  def not?(value) do
    !value
  end

  @doc """
  Translates to `left || right`.

  ## Examples

      iex> or?(nil, false)
      false

      iex> or?(1, nil)
      1

      iex> or?(false, 2)
      2

      iex> or?(true, 2)
      true

  """
  @doc since: "0.1.0"
  @spec or?(as_boolean(left), as_boolean(right)) :: as_boolean(left | right)
        when left: term(), right: term()
  def or?(left, right) do
    left || right
  end

  @doc """
  Translates to `+value`.

  ## Examples

      iex> positive(1)
      1

  """
  @doc since: "0.1.0"
  @spec positive(integer()) :: integer()
  @spec positive(float()) :: float()
  def positive(value) do
    +value
  end

  @doc """
  Translates to `base ** exponent`.

  ## Examples

      iex> pow(2, 5)
      32

      iex> pow(36, 0.5)
      6.0

      iex> pow(4, -1)
      0.25

  """
  @doc since: "unreleased"
  @spec pow(integer(), non_neg_integer()) :: integer()
  @spec pow(integer(), neg_integer()) :: float()
  @spec pow(float(), float()) :: float()
  @spec pow(integer(), float()) :: float()
  @spec pow(float(), integer()) :: float()
  def pow(base, exponent) do
    base ** exponent
  end

  @doc """
  Put value into structure if condition is met.

  Uses the `Access` behaviour to perform the put, so keys are a list as with
  `Kernel.get_and_update_in/3` and its companions.

  ## Examples

      iex> put_if(%{data: %{}}, true, [:data, :my_key], "my value")
      %{data: %{my_key: "my value"}}

      iex> put_if([], false, [:only], [:a, :b, :c])
      []

  """
  @doc since: "unreleased"
  @spec put_if(
          data,
          as_boolean(term()),
          [Access.get_and_update_fun(data, term()) | term(), ...],
          term()
        ) :: data
        when data: Access.container()
  def put_if(data, condition, keys, value) do
    if condition do
      put_in(data, keys, value)
    else
      data
    end
  end

  @doc """
  Build a recursive anonymous function.

  This macro must be passed the function in the `fn` syntax.

  Generated functions can call themselves using `super`.

  ## Examples

      iex> reverse = recursive fn
      ...>   [], acc -> acc
      ...>   [head | tail], acc -> super(tail, [head | acc])
      ...> end
      iex> reverse.([1, 2, 3], [])
      [3, 2, 1]

  """
  @doc since: "0.1.0"
  defmacro recursive(fun) do
    {:fn, meta, clauses} = fun

    self_fun = Macro.unique_var(:self_fun, __MODULE__)

    new_clauses =
      Enum.map(clauses, fn {:->, clause_meta, [args, body]} ->
        new_args = put_fn_clause_arg(args, self_fun)
        new_body = replace_fn_super(body, self_fun)
        {:->, clause_meta, [new_args, new_body]}
      end)

    wrapper_args =
      fun
      |> fn_arity()
      |> Macro.generate_unique_arguments(__MODULE__)

    quote do
      fn unquote_splicing(wrapper_args) ->
        fun = unquote({:fn, meta, new_clauses})
        fun.(fun, unquote_splicing(wrapper_args))
      end
    end
  end

  @spec put_fn_clause_arg(Macro.t(), Macro.t()) :: Macro.t()
  defp put_fn_clause_arg(args_or_guard, arg) do
    case args_or_guard do
      [{:when, meta, args}] when is_list(args) ->
        [{:when, meta, [arg | args]}]

      args when is_list(args) ->
        [arg | args]
    end
  end

  @spec replace_fn_super(Macro.t(), Macro.t()) :: Macro.t()
  defp replace_fn_super(body, fun) do
    Macro.prewalk(body, fn quoted_expression ->
      with {:super, call_meta, args} <- quoted_expression do
        {{:., [], [fun]}, call_meta, [fun | args]}
      end
    end)
  end

  @spec fn_arity(Macro.t()) :: arity()
  defp fn_arity({:fn, _meta, clauses}) do
    case hd(clauses) do
      {:->, _clause_meta, [[{:when, _guard_meta, args}], _body]} when is_list(args) ->
        length(args) - 1

      {:->, _clause_meta, [args, _body]} when is_list(args) ->
        length(args)
    end
  end

  @doc """
  Handles the sigil `~i` for iodata.

  See ["`iodata` and `chardata`"](`e:elixir:io-and-the-file-system.html#iodata-and-chardata`).

  ## Modifiers

    - `s`: interpolated values should be transformed by `to_string/1` (default)
    - `i`: interpolated values should be transformed by `iodata_inspect/1`
    - `d`: interpolated values are already iodata/chardata and do not need transformed

  Using the `~i` sigil with the `s` or `i` modifiers will always return iodata. The `d` modifier
  allows for chardata that is not iodata by passing through interpolated chardata.

  > #### The `d` modifier {: .warning}
  >
  > The `d` modifier does not transform interpolated values, so they will appear in the generated
  > list as-is. This makes the operation cheaper when interpolated values are already
  > iodata/chardata but allows construction of invalid iodata/chardata. Care should be taken when
  > using the `d` modifier that all interpolated values are valid iodata/chardata.

  ## Examples

      iex> ~i"some \#{["list", ["of", "nested"], "values"]} and \#{:such}"
      ["some ", "listofnestedvalues", " and ", "such"]

      iex> ~i"some \#{["list", ["of", "nested"], "values"]} and \#{:such}"s
      ["some ", "listofnestedvalues", " and ", "such"]

      iex> ~i"some \#{["list", ["of", "nested"], "values"]} and \#{:such}"i
      [
        "some ",
        [
          "[",
          "",
          ~S("list"),
          ",",
          " ",
          "[",
          ~S("of"),
          ",",
          " ",
          ~S("nested"),
          "]",
          ",",
          " ",
          ~S("values"),
          "",
          "]"
        ],
        " and ",
        [":such"]
      ]

      iex> ~i"some \#{["list", ["of", "nested"], "values"]} and \#{to_string(:such)}"d
      ["some ", ["list", ["of", "nested"], "values"], " and ", "such"]

  """
  @doc since: "0.2.0"
  defmacro sigil_i(term, modifiers) do
    {:<<>>, _meta, parts} = term
    transform = transform_sigil_i(modifiers)

    Enum.map(parts, fn
      {:"::", _meta, [value, {:binary, _meta2, _context}]} ->
        transform.(value)

      string when is_binary(string) ->
        string
    end)
  end

  @spec transform_sigil_i(charlist()) :: (Macro.t() -> Macro.t())
  defp transform_sigil_i(modifiers)

  defp transform_sigil_i(~c"d") do
    fn {{:., _meta, [Kernel, :to_string]}, _meta2, [value]} -> value end
  end

  defp transform_sigil_i(~c"i") do
    fn {{:., meta, [Kernel, :to_string]}, meta2, [value]} ->
      {{:., meta, [__MODULE__, :iodata_inspect]}, meta2, [value]}
    end
  end

  defp transform_sigil_i(modifiers) when modifiers in [~c"", ~c"s"] do
    &Function.identity/1
  end

  defp transform_sigil_i(_modifiers) do
    raise ArgumentError, "modifier must be one of: s, i, d"
  end

  @doc """
  Translates to `left === right`.

  ## Examples

      iex> strictly_equal?(1, 2)
      false

      iex> strictly_equal?(1, 1.0)
      false

  """
  @doc since: "0.1.0"
  @spec strictly_equal?(term(), term()) :: boolean()
  def strictly_equal?(left, right) do
    left === right
  end

  @doc """
  Translates to `left !== right`.

  ## Examples

      iex> strictly_inequal?(1, 2)
      true

      iex> strictly_inequal?(1, 1.0)
      true

  """
  @doc since: "0.1.0"
  @doc deprecated: "Prefer `strictly_unequal?/2`"
  @spec strictly_inequal?(term(), term()) :: boolean()
  def strictly_inequal?(left, right) do
    left !== right
  end

  @doc """
  Translates to `left !== right`.

  ## Examples

      iex> strictly_unequal?(1, 2)
      true

      iex> strictly_unequal?(1, 1.0)
      true

  """
  @doc since: "0.3.0"
  @spec strictly_unequal?(term(), term()) :: boolean()
  def strictly_unequal?(left, right) do
    left !== right
  end

  @doc """
  Translates to `left - right`.

  ## Examples

      iex> subtract(1, 2)
      -1

  """
  @doc since: "0.1.0"
  @spec subtract(integer(), integer()) :: integer()
  @spec subtract(float(), float()) :: float()
  @spec subtract(integer(), float()) :: float()
  @spec subtract(float(), integer()) :: float()
  def subtract(left, right) do
    left - right
  end

  @doc """
  Create tagged tuple, wrapping `value` in a tuple with `tag`.

  ## Examples

      iex> tag(:cool, :ok)
      {:ok, :cool}

  """
  @doc since: "0.3.0"
  @spec tag(value, tag) :: {tag, value} when tag: term(), value: term()
  def tag(value, tag) do
    {tag, value}
  end

  @doc """
  Apply `fun` to `term` if `condition` is met.

  Otherwise `term` is passed through as-is.

  ## Examples

      iex> then_if(%{}, true, &Map.put(&1, :key, "value"))
      %{key: "value"}

      iex> then_if(7, false, fn x -> x + 1 end)
      7

  """
  @doc since: "unreleased"
  @spec then_if(input, as_boolean(term()), (input -> output)) :: input | output
        when input: term(), output: term()
  def then_if(term, condition, fun) do
    if condition do
      fun.(term)
    else
      term
    end
  end

  @doc """
  Translates to `left != right`.

  ## Examples

      iex> unequal?(1, 2)
      true

      iex> unequal?(1, 1.0)
      false

  """
  @doc since: "0.3.0"
  @spec unequal?(term(), term()) :: boolean()
  def unequal?(left, right) do
    left != right
  end

  @doc """
  Unwrap tagged tuple, asserting first element is `tag` and returning the second.

  ## Examples

      iex> untag({:ok, :cool}, :ok)
      :cool

      iex> untag({:error, :oops}, :ok)
      ** (MatchError) no match of right hand side value: {:error, :oops}

  """
  @doc since: "0.3.0"
  @spec untag({tag, value}, tag) :: value when tag: term(), value: term()
  def untag(tuple, tag) do
    {^tag, value} = tuple
    value
  end

  @doc """
  Update value in structure if condition is met.

  Uses the `Access` behaviour to perform the update, so keys are a list as with
  `Kernel.get_and_update_in/3` and its companions.

  ## Examples

      iex> update_if([bounds: 1..10], true, [:bounds, Access.key!(:first)], fn x -> x + 3 end)
      [bounds: 4..10]

      iex> update_if(%{limit: 7}, false, [:limit], fn limit -> limit * 2 end)
      %{limit: 7}

  """
  @doc since: "unreleased"
  @spec update_if(
          data,
          as_boolean(term()),
          [Access.get_and_update_fun(data, current_value) | term(), ...],
          (current_value -> term())
        ) :: data
        when current_value: term(), data: Access.container()
  def update_if(data, condition, keys, fun) do
    if condition do
      update_in(data, keys, fun)
    else
      data
    end
  end
end
