######################################################################
#<
#
# Function: p6df::modules::go::version()
#
#>
######################################################################
p6df::modules::go::version() { echo "0.0.1" }
######################################################################
#<
#
# Function: p6df::modules::go::deps()
#
#>
######################################################################
p6df::modules::go::deps()    { ModuleDeps=(syndbg/goenv) }

######################################################################
#<
#
# Function: p6df::modules::go::home::symlink()
#
#>
######################################################################
p6df::modules::go::home::symlink() {

  if [ -n "$GOPATH" ]; then
    ln -fs $P6_DFZ_SRC_DIR $GOPATH/src 
  fi
}

######################################################################
#<
#
# Function: p6df::modules::go::langs()
#
#>
######################################################################
p6df::modules::go::langs() {

  (cd $P6_DFZ_SRC_DIR/syndbg/goenv ; git pull)

  # nuke the old one
  local previous=$(goenv install -l | tail -2 | head -1 | sed -e 's, *,,g')
  pyenv uninstall -f $previous

  # get the shiny one
  local latest=$(goenv install -l | tail -1 | sed -e 's, *,,g')
  goenv install $latest
  goenv global $latest
  goenv rehash

  go get -u golang.org/x/tools/cmd/oracle
  go get -u golang.org/x/tools/cmd/goimports
  go get -u golang.org/x/tools/cmd/godoc

  go get -u github.com/stretchr/testify
  go get -u github.com/golang/lint/golint

  go get -u gopkg.in/check.v1

  go get -u github.com/golangci/golangci-lint/cmd/golangci-lint
  goenv rehash
  (
    cd $P6_DFZ_SRC_DIR/github.com/golangci/golangci-lint/cmd/golangci-lint ;
    go install -ldflags "-X 'main.version=$(git describe --tags)' -X 'main.commit=$(git rev-parse --short HEAD)' -X 'main.date=$(date)'"
  )
  goenv rehash
}

######################################################################
#<
#
# Function: p6df::modules::go::init()
#
#>
######################################################################
p6df::modules::go::init() {

  p6df::modules::go::goenv::init "$P6_DFZ_SRC_DIR"
}

######################################################################
#<
#
# Function: p6df::modules::go::goenv::init(dir)
#
#  Args:
#	dir - 
#
#>
######################################################################
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

######################################################################
#<
#
# Function: p6df::prompt::gopath::line()
#
#>
######################################################################
p6df::prompt::gopath::line() {

  p6_go_path_prompt_info
}

######################################################################
#<
#
# Function: p6df::prompt::go::line()
#
#>
######################################################################
p6df::prompt::go::line() {

  p6_go_prompt_info
}

######################################################################
#<
#
# Function: str str = p6_go_path_prompt_info()
#
#  Returns:
#	str - str
#
#>
######################################################################
p6_go_path_prompt_info() {

  local str=
  if ! p6_string_blank "$GOPATH"; then
    str="go:     GOPATH:[$GOPATH]  GOROOT:[$GOROOT]"
  fi

  p6_return_str "$str"
}

######################################################################
#<
#
# Function: p6_go_prompt_info()
#
#>
######################################################################
p6_go_prompt_info() {

  p6_lang_version "go"
}