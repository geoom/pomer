.PHONY: build run install clean

PREFIX ?= /usr/local/bin

build:
	stack --system-ghc build --copy-bins --local-bin-path .

run:
	stack --system-ghc run pomer -- $(ARGS)

install: build
	install -m 755 pomer $(PREFIX)/pomer

clean:
	rm -f pomer
	stack clean
