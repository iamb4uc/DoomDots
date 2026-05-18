SHELL := /bin/sh

REPO := $(CURDIR)
PREFIX ?= $(HOME)
BACKUP_DIR ?= $(PREFIX)/.dotfiles-backup/$(shell date +%Y%m%d%H%M%S)

CONFIG_LINKS := $(filter-out .config/README.md,$(patsubst .config/%,.config/%,$(wildcard .config/*)))
LOCAL_LINKS := $(patsubst .local/%,.local/%,$(wildcard .local/*))
LINKS := .zprofile $(CONFIG_LINKS) $(LOCAL_LINKS)
EXECUTABLES := $(wildcard .local/bin/*) .local/share/doomwm/autostart.sh .config/lf/cleaner .config/lf/icons .config/lf/lfrc .config/lf/preview .config/lf/scope .config/sxiv/exec/key-handler

.PHONY: all help install dirs link chmod uninstall clean lint status

all: install

help:
	@printf '%s\n' \
		'Targets:' \
		'  make install    Set up these dotfiles in $$HOME' \
		'  make uninstall  Remove symlinks that point back to this repo' \
		'  make clean      Remove generated logs, caches, and runtime state' \
		'  make lint       Syntax-check shell scripts' \
		'  make status     Show git status'

install: clean dirs link chmod
	@printf 'dotfiles installed into %s\n' "$(PREFIX)"

dirs:
	@mkdir -p \
		"$(PREFIX)/.config" \
		"$(PREFIX)/.cache" \
		"$(PREFIX)/.local" \
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

lint:
	@set -eu; \
	for file in .local/bin/* .local/share/doomwm/autostart.sh .config/lf/cleaner .config/lf/preview .config/lf/scope .config/sxiv/exec/key-handler; do \
		[ -f "$$file" ] || continue; \
		case "$$(head -n 1 "$$file")" in \
			*python*|*ruby*) continue ;; \
			*bash*) bash -n "$$file" ;; \
			*) sh -n "$$file" ;; \
		esac; \
	done
	@printf 'shell syntax checks passed\n'

status:
	@git status --short
