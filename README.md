# aliedots
=============

## Home Directory structure
```
$HOME
	.local/
		bin/
			custom/
			wrappers/
		etc/
		opt/
		share/
		tmp/
			desktop/
			public/
			templates/
		var/
			cache/
			lib/
			log/
	dl/
	dox/
	melum/
	pix/
	vids/
	.pam_environment
	.zshenv
```
## Notes
- Using the xdg variable structure inspired from [ayekat's dotfiles](https://github.com/ayekat/dotfiles)
- all directories whether empty or full which i do not want to version control have a .gitignore with the contents:
```git
*
!.gitignore
```
- etc/root contains files that should be hard linked to /etc with the same folder structure. crontab will have to be seperately written using `sudo crontab -e`
- the user has a crontab too, available in lib/dotfiles/crontab
## todo for setup
minecraft files settings, server.dat
## setup outside of the repository contents
/var/lib/vnstat/vnstat.db
