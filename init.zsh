p6df::modules::go::version() { echo "0.0.1" }
p6df::modules::go::deps()    {
	ModuleDeps=(
	)
}

p6df::modules::go::external::brew() {

  brew install go
}

p6df::modules::go::init() {

  p6df::modules::go::goenv::init
}

p6df::modules::go::goenv::init() {
    [ -n "$DISABLE_ENVS" ] && return

    GOENV_ROOT=/Users/pgollucci/.local/share/syndbg/goenv

    if [ -x $GOENV_ROOT/bin/goenv ]; then
      export GOENV_ROOT
      export HAS_GOENV=1

      p6dfz::util::path_if $GOENV_ROOT/bin
      eval "$(goenv init - zsh)"
    fi
}

p6df::prompt::go::line() {

  env_version "go"
}
