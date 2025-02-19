defmodule ExConfusables.Data do
  @moduledoc false

  def get() do
    bin = File.read!(Path.join([:code.priv_dir(:ex_confusables), "confusables.txt"]))
    process(bin)
  end

  defp process(confusables_bin) do
    {:utf8, len} = :unicode.bom_to_encoding(confusables_bin)

    :binary.part(confusables_bin, len, byte_size(confusables_bin) - len)
    |> String.split("\n", trim: true)
    |> Enum.filter(&is_not_comment_or_empty/1)
    |> build_list()
  end

  defp is_not_comment_or_empty(""), do: false
  defp is_not_comment_or_empty("#" <> _Res), do: false
  defp is_not_comment_or_empty(_), do: true

  defp build_list(lines), do: build_list(lines, [])

  defp build_list([], acc), do: acc

  defp build_list([line | tail], acc) do
    [c1, c2 | _] = String.split(line, ";", trim: true)
    key = String.trim(c1)

    value = String.split(c2, [" ", "\t"], trim: true)

    build_list(tail, [{key, value} | acc])
  end
end
