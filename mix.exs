defmodule RSProtect.MixProject do
  use Mix.Project

  @source_url "https://github.com/ewildgoose/rs_protect"
  @version "0.1.0"

  def project do
    [
      app: :rs_protect,
      description: description(),
      package: package(),
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        extras: ["README.md"],
        main: "readme",
        source_url: @source_url,
        source_ref: "v#{@version}"
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
      {:rustler, "~> 0.29"},
      {:ex_doc, "~> 0.30", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Elixir/rust wrapper around Reed-Solomon error correction code library.
    Suitable for protecting short binary packets against bit errors on noisy channels.
    """
  end

  defp package do
    %{
      name: "rs_protect",
      files: ["lib", "native", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Ed Wildgoose"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    }
  end
end
