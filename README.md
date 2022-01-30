# aliedots
=============

To use the dots, on a fresh installation of Arch linux(not tested on other distros but might work) execute
`git clone https://github.com/Vedant36/aliedots .local`
in the home folder. Then link .local/lib/dotfiles/{.zshenv,.pam_environment} to home and the wallpaper of your choice to pix/current.*(this location can be changes in .local/etc/X11/xinitrc in the line starting with feh).

execute the xinit wrapper `x` on the shell to start the x server

## Home Directory structure
$HOME
	.local/
		bin/                <!-- added to PATH -->
			experimental/
			scripts/        <!-- added to PATH -->
			wrappers/       <!-- added to PATH -->
		etc/                <!-- XDG_CONFIG_HOME -->
		opt/                <!-- contains all my local repos like dwm, dmenu, etc -->
		share/              <!-- XDG_DATA_HOME -->
		tmp/
			desktop/
			public/
			templates/
		var/
			cache/          <!-- XDG_CACHE_HOME -->
			lib/            <!-- XDG_STATE_HOME -->
			log/            <!-- logging files -->
	dl/
	dox/
	melum/
	pix/
	vids/
	.pam_environment
	.zshenv

## Notes
- Using the xdg variable structure inspired from [ayekat's dotfiles](https://github.com/ayekat/dotfiles)
- the set-up script(still in developement) is lib/dotfiles/setup.sh, although that is not necessary to get the aliedots experience
- {packages,foreign packages} i use are in lib/dotfiles/{pkglist,foreignpkglist}.txt
- all directories whether empty or full which i do not want to version control have a .gitignore with the contents:
```git
*
!.gitignore
```
- etc/root contains files that should be hard linked to /etc with the same folder structure
- the user and the(currently non-existent) root crontab will be available in lib/dotfiles/crontab
- if a different XDG_CONFIG_HOME is used, the variable at the line matching `^set preview_script ` in $XDG_CONFIG_HOME/ranger/rc.conf needs to be changed

## problematic files
share/ranger/bookmarks: only first line changes pretty quickly(mark ' is saved there)
share/zsh/.zsh_history: very long and has unneccesarily long diffs when commiting
etc/MediaHuman/YouTube to MP3.conf: same as above except this file is much less useful
etc/environment.d/*: don't know a way to transfer them to shell variables
