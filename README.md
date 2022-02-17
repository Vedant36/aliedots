# aliedots

To use the dots, on a fresh installation of Arch linux(not tested on other distros but might work) execute
```
cd ~
git clone https://github.com/Vedant36/aliedots .local
```
link .local/lib/dotfiles/pam_environment to home
```
ln -s ~/.local/lib/dotfiles/pam_environment ~/.pam_environment
```
to get a wallpaper, link an image to `~/pix/current*` (check ~/.local/etc/X11/xinitrc to change this)

execute the xinit wrapper `x` on the shell to start the x server

## Home Directory structure

```
$HOME
|---.local/
|   |---bin/                <!-- added to PATH -->
|   |   |---experimental/   <!-- for unused and experiemental scripts -->
|   |   |---scripts/        <!-- added to PATH -->
|   |   |---wrappers/       <!-- added to PATH -->
|   |---etc/                <!-- XDG_CONFIG_HOME -->
|   |---lib/                <!-- XDG_LIB_HOME(non-standard) -->
|   |   |---dotfiles/       <!-- archived files or for the install script -->
|   |   |---python/         <!-- contains startup.py -->
|   |   |---root/           <!-- root files -->
|   |---mnt/                <!-- directory for mtp(android mounting) -->
|   |---opt/                <!-- contains local repos like dwm, dmenu, etc -->
|   |---share/              <!-- XDG_DATA_HOME -->
|   |---tmp/                <!-- for temporary files and unused xdg-user-dirs(etc/user-dirs.dirs) -->
|   |   |---desktop/
|   |   |---public/
|   |   |---templates/
|   |---var/
|   |   |---cache/          <!-- XDG_CACHE_HOME -->
|   |   |---lib/            <!-- XDG_STATE_HOME(non-standard) -->
|   |   |---log/            <!-- XDG_LOG_HOME(non-standard) -->
|---dl/
|---dox/
|---melum/
|---pix/
|---vids/
|---.pam_environment
```

## Notes
- Using the xdg variable structure inspired from [ayekat's dotfiles](https://github.com/ayekat/dotfiles)
- the set-up script(still in developement) is lib/dotfiles/setup.sh, although that is not necessary to get the aliedots experience
- {packages,foreign packages} i use are in lib/dotfiles/{pkglist,foreignpkglist}.txt
- lib/root contains files that should be hard linked to / with the same folder structure
    * symbolic links might be better
    * a PKGBUILD is a possibility will not be cross distro compatible
- the user and the(currently non-existent) root crontab will be available in lib/dotfiles/crontab
- if a different XDG_CONFIG_HOME is used, the variable at the line matching `^set preview_script` in $XDG_CONFIG_HOME/ranger/rc.conf needs to be changed

## Tags that can be found in comments throughout the scripts and config
- `TODO` for procrastinating
- `REWRITE` if the script/other file needs rewriting later
- `Source` indicating the original source of a part of the script
- `IDEA` or `IDEAS`
- `SYSTEM_DEPENDENT` for code that might not work on other systems
- `Dependencies`
- `Temporary` for changes that might be reverted later

## problematic files
- share/ranger/bookmarks: only first line changes pretty quickly(mark ' is saved there)
- share/zsh/.zsh_history: very long and has unneccesarily long diffs when commiting
- etc/MediaHuman/YouTube to MP3.conf: same as above except this file is much less useful

## TODO
- etc/environment.d/*: don't know a way to transfer them to shell variables
- complete setup.sh
- find better way to profile shell scripts than adding the snippet from .zshrc and passind the resulting file to sort-timings.zsh

