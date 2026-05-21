.PHONY: build run install clean

PREFIX ?= /usr/local/bin

build:
	stack --system-ghc ghc -- Main.hs -o pomer

run:
	stack --system-ghc runghc -- Main.hs

install: build
	install -m 755 pomer $(PREFIX)/pomer

clean:
	rm -f pomer
	stack clean
