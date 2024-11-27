defmodule Colonel.MixProject do
  use Mix.Project

  @source_url "https://github.com/brettbeatty/colonel_elixir"

  def project do
    [
      app: :colonel,
      version: "0.2.0",
      elixir: "~> 1.13",
      source_url: @source_url,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Colonel",
      description: "Supplements Kernel module",
      docs: [
        main: "readme",
        extras: ["README.md", "CHANGELOG.md"]
      ],
      package: [
        licenses: ["Apache-2.0"],
        links: %{"GitHub" => @source_url}
      ],
      dialyzer: [
        plt_file: {:no_warn, "priv/plt/project.plt"}
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.35.1", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
