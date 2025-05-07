import Config

config :rustler, :crates,
  rs_protect_nif: [
    path: "native/rs_protect_nif",
    mode: if(config_env() == :prod, do: :release, else: :debug)
  ]
