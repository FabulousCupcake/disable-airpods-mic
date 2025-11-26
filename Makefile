.SILENT: help load unload
.PHONY: help load unload

PLIST_NAME = com.user.disable-airpods-mic.plist
PLIST_SRC  = $(PWD)/$(PLIST_NAME)
PLIST_DEST = $(HOME)/Library/LaunchAgents/$(PLIST_NAME)

help:
	echo "Available commands:"
	echo "  make           # Print this help"
	echo "  make load      # Copy plist into ~/Library/LaunchAgents and load it via launchctl"
	echo "  make unload    # Unload plist via launchctl and remove it from ~/Library/LaunchAgents"

# Default target
all: help

load:
	echo "Copying plist to ~/Library/LaunchAgents..."
	cp "$(PLIST_SRC)" "$(PLIST_DEST)"
	echo "Loading plist..."
	launchctl unload -w "$(PLIST_DEST)" >/dev/null 2>&1 || true
	launchctl load -w "$(PLIST_DEST)"
	echo "Done!"

unload:
	echo "Unloading plist..."
	launchctl unload -w "$(PLIST_DEST)" >/dev/null 2>&1 || true
	echo "Removing plist from ~/Library/LaunchAgents..."
	rm -f "$(PLIST_DEST)"
	echo "Done!"


