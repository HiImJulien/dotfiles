# dotfiles

This repository contains my preferred system and home configuration.

## TODO
- [ ] Finalize nVim configuration
  - [ ] Properly setup autocompletion and snippets support.
  - [ ] Properly setup nvim-tmux-navigator.
  - [ ] (Optional) Setup plugins using home-manager for better compatibility with nixOS.
- [X] Create script `amaterasu`, which provides a global short-hand for syncing system and home config.
- [ ] Finalize eww configuration
- [ ] Update GDM to use other monitor as primary


## Known Issues

- Chromium-based browsers such as Brave do not retain any sessions, after restarting the browser.
  This issue is likely happening due to two reasons:
  - The browser isn't using they keyring. Alter the startup settings to use `--password-store=detect` or
    `--password-store=gnome`.
  - The browser detects the keyring software but not default keyring has been setup. Use `seahorse` to setup a default
    keyring.
