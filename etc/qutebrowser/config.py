#!/usr/bin/env python
# Documentation: qute://help/configuring.html qute://help/settings.html
import subprocess
import os
# Settings {{{1
config.load_autoconfig(False)
c.auto_save.session = True
c.backend = 'webengine'
c.completion.cmd_history_max_items = 1000
c.completion.shrink = True
c.completion.use_best_match = True
c.content.cookies.accept = 'no-3rdparty'
c.content.fullscreen.window = False
c.content.notifications.enabled = False
c.content.pdfjs = True
c.content.private_browsing = False
XDG_CONFIG_HOME = os.getenv("XDG_CONFIG_HOME", os.path.join(os.getenv('HOME'), '.config'))
# TODO: darkmode and better-duckduckgo not working
c.content.user_stylesheets = [f'{XDG_CONFIG_HOME}/qutebrowser/fix-tooltips.qss']
# , f'{XDG_CONFIG_HOME}/qutebrowser/darkmode.qss',
# f'{XDG_CONFIG_HOME}/qutebrowser/better-duckduckgo.css']
c.content.webrtc_ip_handling_policy = 'disable-non-proxied-udp'
c.content.geolocation = False
c.downloads.location.suggestion = 'both'
c.downloads.remove_finished = 1
c.editor.command = [ 'kitty', '-1', 'nvim', '-c', 'norm {line}G{column0}l', '{file}' ]
c.hints.border = '0'
c.hints.chars = 'asdfjkl;ghnmxcvbziowerutyqp'
c.hints.padding = { "bottom": 1, "left": 1, "right": 1, "top": 1 }
c.input.insert_mode.auto_load = True
c.scrolling.bar = 'when-searching'
c.scrolling.smooth = True
c.session.lazy_restore = True
c.statusbar.padding = { "bottom": 0, "left": 0, "right": 0, "top": 0 }
c.statusbar.show = "always"
c.tabs.background = True
c.tabs.last_close = 'close'
c.tabs.mousewheel_switching = False
c.tabs.new_position.unrelated = 'next'
c.tabs.select_on_remove = 'last-used'
c.tabs.show = "multiple"
c.tabs.show_switching_delay = 400
c.tabs.title.format = "{audio}{current_title}"
c.url.open_base_url = True
c.window.hide_decoration = True
c.window.transparent = True

c.fileselect.handler = "external"
c.fileselect.single_file.command = ['kitty', '-e', 'ranger', '--choosefile', '{}']
c.fileselect.multiple_files.command = ['kitty', '-e', 'ranger', '--choosefiles', '{}']
c.fileselect.folder.command = ['kitty', '-e', 'ranger', '--choosedir', '{}']

# fonts {{{1
font_size = '10pt'
fixed = f'{font_size} Iosevka Term'
c.fonts.default_family = 'Futura'
# c.fonts.default_family = [ "Futura", "Unifont" ]
c.fonts.statusbar = fixed
c.fonts.completion.category = fixed
c.fonts.completion.entry = fixed
c.fonts.hints = f'{font_size} Iosevka Term'
# c.fonts.web.family.fixed = 'Iosevka Term'
c.fonts.web.family.sans_serif = 'Futura'
c.fonts.web.family.serif = 'Helvetica'
c.fonts.web.family.standard = 'Futura'
c.fonts.web.size.default = 14
c.fonts.web.size.default_fixed = 14

# Aliases {{{1
c.aliases = {
	"q": "close",
	"qa": "quit",
	"w": "session-save",
	"wq": "quit --save",
	"wqa": "quit --save",
	"echo": "message-info",
	"sleep": "later",
}

# Search Engines {{{1
c.url.searchengines = {
    'DEFAULT': 'https://www.duckduckgo.com/?q={}',
	'4': 'https://4chan.org/{}',
	'a': 'https://wiki.archlinux.org/index.php?title=Special%3ASearch&search={}',
    'ap': 'https://animixplay.to/?q={}', # anime
    'b': 'https://1lib.in/s/{}',
    'b2': 'https://www.pdfdrive.com/search?q={}',
    'b3': 'https://libgen.me/search?query={}',
	'd': 'https://html.duckduckgo.com/html?q={}', # nojs version of duckduckgo
	'g': 'https://www.google.com/search?hl=en&q={}',
	'gh': 'https://github.com/{}',
	'm2': 'https://man.archlinux.org/{}', # arch man pages
	'm': 'https://linux.die.net/man/1/{}', # man pages
	'mw': 'https://www.merriam-webster.com/dictionary/{}',
	'l': 'https://lyrics.com/lyrics/{}', # lyric finding engine
	'o': 'http://oeis.org/search?q={}',
	'oa': 'http://oeis.org/A{}',
	'ob': 'http://oeis.org/b{}.txt',
	'p': 'https://tpb.one/search.php?q={}',
    'py': 'https://pypi.org/search/?q={}',
	'r': 'https://reddit.com/r/{}',
	's': 'https://open.spotify.com/search/{}',
    'su': 'https://steamunlocked.net/?s={}',
    'wiby': 'https://wiby.me/?q={}',
    'wa': 'https://www.wolframalpha.com/input/?i={}',
	'wm': 'https://mathworld.wolfram.com/search/index.html?query={}',
	'x': 'https://searx.xyz/search?q={}',
    'y': 'https://youtube.com/search?q={}',
    'yw': 'https://tube.cadence.moe/watch?v={}',
	'scp': 'https://scp-wiki.wikidot.com/scp-{}',
	'mc': 'https://minecraft.fandom.com/wiki/{}',
}

# Youtube/Ad Blocking {{{1
c.content.javascript.enabled = True
c.content.autoplay = False
c.content.blocking.adblock.lists = [ \
	"https://raw.githubusercontent.com/brave/adblock-lists/master/brave-unbreak.txt", \
	"https://easylist.to/easylist/easylist.txt", \
	"https://easylist.to/easylist/easyprivacy.txt", \
	"https://secure.fanboy.co.nz/fanboy-cookiemonster.txt", \
	"https://easylist.to/easylist/fanboy-annoyance.txt", \
	"https://secure.fanboy.co.nz/fanboy-annoyance.txt", \
	"https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt", \
	"https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt", \
	"https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt", \
	"https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt", \
	"https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt", \
	"https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt", \
	]
c.content.blocking.enabled = True
c.content.blocking.hosts.lists = [
	'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts'
	]
c.content.blocking.method = 'adblock'
from qutebrowser.api import interceptor
def filter_yt(info: interceptor.Request):
	"""Block the given request if necessary."""
	url = info.request_url
	if ( url.host() == "www.youtube.com"
		and url.path() == "/get_video_info"
		and "&adformat=" in url.query()):
		info.block()
interceptor.register(filter_yt)

# Bindings {{{1
c.bindings.commands = {
	"normal": {
		"A" : "set-cmd-text :open {url:pretty}",
		"H" : "fake-key <left>",
		"J" : "back",
		"K" : "forward",
		"L" : "fake-key <right>",
		"M" : "spawn -d umpv {url}",
		"ZA": "quit --save",
		"ZQ": "close",
		"ZZ": "save;; close",
		"ce": "config-edit",
		"cs": "config-source",
		**{f"e{i}": f"fake-key {i}" for i in "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"},
		"e<space>": "fake-key <esc>",
		"gw": "open w {url}",
		"gI": "hint inputs --first;; mode-enter insert;; fake-key /<ctrl-a><backspace>",
        "gw": "open https://web.archive.org/web/*/{url:pretty}",
		"h" : "tab-prev",
		"l" : "tab-next",
		"yw": "fake-key <ctrl-a>",
		"yk": "jseval -q document.getElementsByTagName('video')[0].playbackRate = 16", # speed up youtube ad
		"z" : "open -t -r  ;; tab-move",
		"!" : "set-cmd-text :open !",
		",M": "hint links spawn -d mpv {hint-url}",
		",m": "spawn -d mpv {url}",
        ",a": "config-cycle content.blocking.enabled;; reload",
		",p": "config-cycle content.proxy socks://localhost:9050/ system",
		",s": "config-cycle statusbar.show never always",
		",t": "config-cycle tabs.show multiple never",
		",u": "config-cycle statusbar.show never always;; config-cycle tabs.show never multiple",
		",w": "open https://web.archive.org/*/{url}",
		",y": "set-cmd-text -s :jseval -q document.getElementsByTagName('video')[0].playbackRate =",
		";M": "hint --rapid links spawn umpv {hint-url}",
		";m": "hint links spawn umpv {hint-url}",
		"<ctrl-r>": "save;; restart",
	},
	"insert": {
		"<Ctrl-a>": "fake-key <Home>",
		"<Alt-b>": "fake-key <Ctrl-Left>",
		"<Ctrl-b>": "fake-key <Left>",
		"<Ctrl-c>": "fake-key <Ctrl-a><Backspace>",
		"<Alt-d>": "fake-key <Ctrl-Delete>",
		"<Ctrl-d>": "fake-key <Delete>",
		"<Ctrl-e>": "fake-key <End>",
		"<Alt-f>": "fake-key <Ctrl-Right>",
		"<Ctrl-f>": "fake-key <Right>",
		"<Ctrl-h>": "fake-key <Backspace>",
		"<Ctrl-h>": "fake-key <Backspace>",
		"<Ctrl-j>": "fake-key <Enter>",
		"<Ctrl-k>": "fake-key <Shift-End><Delete>",
		"<Ctrl-m>": "fake-key <Enter>",
		"<Ctrl-n>": "fake-key <Down>",
		"<Ctrl-p>": "fake-key <Up>",
		"<Ctrl-u>": "fake-key <Shift-Home><Delete>",
		"<Ctrl-w>": "fake-key <Ctrl-Backspace>",
		"<Ctrl-x><Ctrl-e>": "edit-text",
	}
}

# Colors from Xresources {{{1
# taken from https://qutebrowser.org/doc/help/configuring.html
def read_xresources(prefix):
	"""
	read settings from xresources
	"""
	props = {}
	x = subprocess.run(["xrdb", "-query"], stdout=subprocess.PIPE)
	lines = x.stdout.decode().split("\n")
	for line in filter(lambda l: l.startswith(prefix), lines):
		prop, _, value = line.partition(":\t")
		props[prop] = value
	return props

xresources = read_xresources("*")
even = "#15161e"
odd = xresources["*.background"]

# c.colors.webpage.bg = '#292d3e'
c.colors.webpage.darkmode.enabled = False
c.colors.webpage.darkmode.policy.images = 'never'
c.colors.webpage.preferred_color_scheme = 'dark'
c.colors.webpage.darkmode.algorithm = 'lightness-hsl'
c.colors.webpage.darkmode.contrast = -.022 # the lower the darker
c.colors.webpage.darkmode.threshold.text = 150
c.colors.webpage.darkmode.threshold.background = 100

c.colors.statusbar.normal.bg = xresources["*.background"]
c.colors.statusbar.command.bg = xresources["*.background"]
c.colors.statusbar.command.fg = xresources["*.foreground"]
c.colors.statusbar.normal.fg = xresources["*.foreground"]
c.colors.statusbar.url.success.https.fg = xresources["*.color2"]
c.colors.statusbar.url.hover.fg = xresources["*.color4"]

c.colors.tabs.even.bg = even
c.colors.tabs.odd.bg = odd
c.colors.tabs.even.fg = xresources["*.foreground"]
c.colors.tabs.odd.fg = xresources["*.foreground"]
c.colors.tabs.selected.even.bg = xresources["*.color8"]
c.colors.tabs.selected.odd.bg = xresources["*.color8"]
c.colors.hints.bg = xresources["*.foreground"]
c.colors.hints.fg = xresources["*.background"]

c.colors.tabs.indicator.stop = xresources["*.color14"]
c.colors.tabs.indicator.error = xresources["*.color9"]
c.colors.completion.even.bg = even
c.colors.completion.odd.bg = odd
c.colors.completion.fg = xresources["*.foreground"]
c.colors.completion.category.bg = xresources["*.background"]
c.colors.completion.category.fg = xresources["*.foreground"]
c.colors.completion.item.selected.bg = xresources["*.background"]
c.colors.completion.item.selected.fg = xresources["*.foreground"]

# Headers and javascript exceptions {{{1
# [Most comman user agents](https://techblog.willshouse.com/2012/01/03/most-common-user-agents/)
c.content.webgl = False
c.content.canvas_reading = False
c.content.headers.accept_language = 'en-US,en;q=0.5'
c.content.headers.custom = {"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"}
c.content.headers.user_agent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36'
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://docs.google.com/*')
config.set('content.register_protocol_handler', False, 'https://mail.google.com')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')
config.set('content.javascript.enabled', True, 'https://www.youtube.com/*')
config.set('content.javascript.enabled', True, 'https://duckduckgo.com/*')
config.set('content.geolocation', False, 'https://www.google.com')
config.set('content.geolocation', False, 'https://www.embibe.com')
