import Config

if File.exists?("config/config.secret.exs") do
  import_config "config.secret.exs"
end

config :erlexec,
  # erlexec is very particular about how it is run as root
  user: System.get_env("USER")
