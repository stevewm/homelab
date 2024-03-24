# Playit.gg agent

There are two ways of deploying this. If you want to pre-generate the secret key:

1. Register an account on playit.gg
2. Download the playit.gg client for your OS and run it
3. Copy the value for `secret_key` from the file `$XDG_CONFIG_HOME/playit/playit.toml`

Alternatively if you don't want to do the above, simply run the pod without mounting `playit.toml`. Unfortunately from here it's ClickOps. The logs will then prompt you to click a URL to set the tunnel up and register an account.

It appears that playit doesn't support hostnames for the local tunnel endpoints.
