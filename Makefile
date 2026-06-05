SHELL := /bin/sh

REPO := $(CURDIR)
PREFIX ?= $(HOME)
BACKUP_DIR ?= $(PREFIX)/.dotfiles-backup/$(shell date +%Y%m%d%H%M%S)

CONFIG_LINKS := $(filter-out .config/README.md,$(patsubst .config/%,.config/%,$(wildcard .config/*)))
LOCAL_LINKS := $(shell find .local/bin .local/share/doomwm .local/share/fonts -type f 2>/dev/null | sort)
LINKS := .zprofile $(CONFIG_LINKS) $(LOCAL_LINKS)
EXECUTABLES := $(wildcard .local/bin/*) .local/share/doomwm/autostart.sh .config/lf/cleaner .config/lf/icons .config/lf/lfrc .config/lf/preview .config/sxiv/exec/key-handler

.PHONY: all help install dirs link chmod uninstall clean lint lint-sh lint-zsh check-install doctor status

all: install

help:
	@printf '%s\n' \
		'Targets:' \
		'  make install    Set up these dotfiles in $$HOME' \
		'  make uninstall  Remove symlinks that point back to this repo' \
		'  make clean      Remove generated logs, caches, and runtime state' \
		'  make lint       Syntax-check shell scripts' \
		'  make lint-sh    Syntax-check sh/bash scripts' \
		'  make lint-zsh   Syntax-check zsh config' \
		'  make check-install  Test install into a temp HOME' \
		'  make doctor     Check desktop command dependencies' \
		'  make status     Show git status'

install: clean dirs link chmod
	@printf 'dotfiles installed into %s\n' "$(PREFIX)"

dirs:
	@mkdir -p \
		"$(PREFIX)/.config" \
		"$(PREFIX)/.cache" \
		"$(PREFIX)/.local" \
		"$(PREFIX)/.local/bin" \
		"$(PREFIX)/.local/share" \
		"$(PREFIX)/.local/state"

link:
	@set -eu; \
	for path in $(LINKS); do \
		src="$(REPO)/$$path"; \
		dst="$(PREFIX)/$$path"; \
		[ -e "$$src" ] || [ -L "$$src" ] || continue; \
		mkdir -p "$$(dirname "$$dst")"; \
		if [ -e "$$dst" ] || [ -L "$$dst" ]; then \
			if [ "$$(readlink "$$dst" 2>/dev/null || true)" = "$$src" ]; then \
				printf 'ok: %s\n' "$$dst"; \
				continue; \
			fi; \
			mkdir -p "$(BACKUP_DIR)/$$(dirname "$$path")"; \
			mv "$$dst" "$(BACKUP_DIR)/$$path"; \
			printf 'backup: %s -> %s\n' "$$dst" "$(BACKUP_DIR)/$$path"; \
		fi; \
		ln -s "$$src" "$$dst"; \
		printf 'link: %s -> %s\n' "$$dst" "$$src"; \
	done

chmod:
	@set -eu; \
	for file in $(EXECUTABLES); do \
		[ -f "$$file" ] || continue; \
		chmod +x "$$file"; \
	done
	@printf 'checked executable bits\n'

uninstall:
	@set -eu; \
	for path in $(LINKS); do \
		src="$(REPO)/$$path"; \
		dst="$(PREFIX)/$$path"; \
		if [ "$$(readlink "$$dst" 2>/dev/null || true)" = "$$src" ]; then \
			rm "$$dst"; \
			printf 'removed: %s\n' "$$dst"; \
		fi; \
	done

clean:
	@rm -rf \
		.config/mpv/watch_later \
		.config/mpv/playlists \
		.config/mpdnotify/log \
		.config/mpdnotify/pid \
		.config/ncmpcpp/error.log \
		.config/qutebrowser/autoconfig.yml \
		.config/qutebrowser/bookmarks \
		.config/qutebrowser/qsettings \
		.config/qutebrowser/quickmarks \
		.config/zsh/.zcompdump*
	@printf 'cleaned generated dotfile state\n'

lint: lint-sh lint-zsh
	@printf 'syntax checks passed\n'

lint-sh:
	@set -eu; \
	for file in .local/bin/* .local/share/doomwm/autostart.sh .config/lf/cleaner .config/lf/preview .config/sxiv/exec/key-handler; do \
		[ -f "$$file" ] || continue; \
		case "$$(head -n 1 "$$file")" in \
			*python*|*ruby*) continue ;; \
			*bash*) bash -n "$$file" ;; \
			*) sh -n "$$file" ;; \
		esac; \
	done
	@printf 'sh syntax checks passed\n'

lint-zsh:
	@zsh -n .zprofile .config/zsh/.zshenv .config/zsh/.zshrc .config/zsh/lib/*.zsh .config/zsh/env/*.zsh .config/zsh/options/*.zsh .config/zsh/functions/*.zsh .config/zsh/aliases/*.zsh .config/zsh/plugins/*.zsh
	@printf 'zsh syntax checks passed\n'

check-install:
	@set -eu; \
	tmp="$$(mktemp -d)"; \
	$(MAKE) PREFIX="$$tmp" install >/dev/null; \
	test "$$(readlink "$$tmp/.zprofile")" = "$(REPO)/.zprofile"; \
	test "$$(readlink "$$tmp/.config/zsh")" = "$(REPO)/.config/zsh"; \
	test -d "$$tmp/.local/bin"; \
	test "$$(readlink "$$tmp/.local/bin/lfub")" = "$(REPO)/.local/bin/lfub"; \
	test "$$(readlink "$$tmp/.local/share/doomwm/autostart.sh")" = "$(REPO)/.local/share/doomwm/autostart.sh"; \
	test "$$(readlink "$$tmp/.local/share/fonts/NerdFonts/SymbolsNerdFontMono-Regular.ttf")" = "$(REPO)/.local/share/fonts/NerdFonts/SymbolsNerdFontMono-Regular.ttf"; \
	printf 'install check passed: %s\n' "$$tmp"

doctor:
	@.local/bin/doomdots-doctor

status:
	@git status --short
