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

    export GOENV_ROOT=/Users/pgollucci/.local/share/wfarr/goenv
    p6dfz::util::path_if $GOENV_ROOT/bin

    if [ -x $GOENV_ROOT/bin/goenv ]; then
      export HAS_GOENV=1
      eval "$(goenv init - zsh)"
    fi
}

p6df::prompt::go::line() {

  env_version "go"
}

p6df::modules::go::init
