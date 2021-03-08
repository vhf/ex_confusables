defmodule ExConfusables.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_confusables,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      xref: [exclude: [:inets, :httpc]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :kernel, :stdlib]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:benchee, git: "https://github.com/bencheeorg/benchee.git", only: :dev}
    ]
  end
end
