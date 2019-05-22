p6df::modules::go::version() { echo "0.0.1" }
p6df::modules::go::deps()    { ModuleDeps=(syndbg/goenv) }

p6df::modules::go::home::symlink() {

  ln -fs $P6_DFZ_SRC_DIR $GOPATH/src 
}

p6df::modules::go::langs() {

  goenv install 1.12.4
  goenv global 1.12.4
  goenv rehash

  go get -u golang.org/x/tools/cmd/oracle
  go get -u golang.org/x/tools/cmd/goimports
  go get -u golang.org/x/tools/cmd/godoc

  go get -u github.com/stretchr/testify
  go get -u github.com/golang/lint/golint
  go get -u github.com/aws/aws-sdk-go

  go get -u gopkg.in/check.v1

  goenv rehash
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

p6df::prompt::gopath::line() {

  echo "GOPATH: $GOPATH"
}

p6df::prompt::go::line() {

  env_version "go"
}
