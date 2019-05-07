p6df::modules::go::version() { echo "0.0.1" }
p6df::modules::go::deps()    {
	ModuleDeps=(
	)
}

p6df::modules::go::external::brew() {

  brew install go
}

p6df::modules::go::home::symlink() {
 
  # XXX: ENV move
  true;
}

p6df::modules::go::init() {

  p6df::modules::go::goenv::init "$P6_DFZ_SRC_DIR"
}

p6df::modules::go::goenv::init() {
    local dir="$1"

    [ -n "$DISABLE_ENVS" ] && return

    GOENV_ROOT=$dir/syndbg/goenv

    if [ -x $GOENV_ROOT/bin/goenv ]; then
      export GOENV_ROOT
      export HAS_GOENV=1

      p6df::util::path_if $GOENV_ROOT/bin
      eval "$(goenv init - zsh)"
      p6df::util::path_if $GOPATH/bin
    fi
}

p6df::prompt::go::line() {

  env_version "go"
}
