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
  @spec inequal?(term(), term()) :: boolean()
  def inequal?(left, right) do
    left != right
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
  @spec strictly_inequal?(term(), term()) :: boolean()
  def strictly_inequal?(left, right) do
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
end
