p6df::modules::go::version() { echo "0.0.1" }
p6df::modules::go::deps()    { 
	ModuleDeps=()
}

p6df::modules::go::external::() {

  brew install go
}

p6df::modules::go::init() {

}

p6df::modules::go::init
