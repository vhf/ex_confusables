defmodule ExConfusables.Confusables do
  @moduledoc false

  alias ExConfusables.Data
  confusables_list = Data.get()

  for {key, value} <- confusables_list do
    target =
      case length(value) do
        1 ->
          "0x" <> Enum.at(value, 0)

        _ ->
          target =
            Enum.map(value, fn e -> "0x" <> e end)
            |> Enum.join(",")

          "[" <> target <> "]"
      end

    Code.eval_quoted(
      Code.string_to_quoted("""
        def prototype(0x#{key}), do: #{target}
      """),
      [],
      __ENV__
    )
  end

  def prototype(c), do: c
end
