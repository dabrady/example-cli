.PHONY: noargs
noargs:
	@# Prevent default behavior when no make target is provided.

# A simple helper for gating other targets on the existence of a command.
.PHONY: %-exists %-doesnt-exist
%-exists: ; @[[ -n `command -v $*` ]]

.PHONY: install
install:
	@if [[ -z `command -v bashly` ]]; then\
	  echo 'Installing Bashly via Homebrew...';\
	  echo "\tNOTE: If this fails, install it yourself.\n\tSee https://bashly.dannyb.co/installation/#installation\n";\
	  brew install brew-gem && brew gem install bashly;\
	fi
	@echo "\nDone.\n";\

.PHONY: test
test:
	@./test/approve

.PHONY: clean
clean:
	@rm -f ./cli

cli: ENV ?= development
cli: bashly-exists
	@bashly generate --env ${ENV}
