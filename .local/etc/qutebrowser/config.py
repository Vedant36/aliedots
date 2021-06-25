# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html
config.load_autoconfig(False)

c.backend = 'webengine'

c.auto_save.session = True

c.colors.webpage.bg = '#292d3e'
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = 'never'
c.colors.tabs.odd.bg = "#333333"
c.colors.tabs.even.bg = "#333333"
c.colors.webpage.preferred_color_scheme = 'dark'

c.completion.cmd_history_max_items = 1000

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://docs.google.com/*')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')
config.set('content.javascript.enabled', True, 'https://www.youtube.com/*')
config.set('content.javascript.enabled', True, 'https://duckduckgo.com/*')
c.content.javascript.enabled = True
c.content.blocking.method = 'both'
c.content.autoplay = False
c.content.private_browsing = False
c.content.user_stylesheets = ['~/.local/share/qutebrowser/fix-tooltips.qss']
c.content.cookies.accept = 'no-3rdparty'
c.content.notifications.enabled = False
c.content.fullscreen.window = False

c.downloads.location.suggestion = 'both'
c.downloads.remove_finished = 0

c.editor.command = [ 'kitty', '-1', 'nvim', '-c', 'norm {line}G{column0}l', '{file}' ]

c.fonts.web.size.default = 14
c.fonts.web.size.default_fixed = 14
c.fonts.default_family = 'Futura'
c.fonts.web.family.serif = 'Helvetica'
c.fonts.web.family.sans_serif = 'Futura'
c.fonts.web.family.standard = 'Futura'
# c.fonts.web.family.fixed = 'Iosevka Term'
c.fonts.default_family = [ "Futura", "Unifont" ]

c.hints.border = '0px'
c.hints.chars = 'abcdefghijklmnopqrstuvwxyz'
c.hints.padding = { "bottom": 0, "left": 1, "right": 1, "top": 0 }

c.input.mouse.rocker_gestures = True
c.input.insert_mode.auto_load = True
# c.input.mouse.rocker_gestures = True

c.scrolling.bar = 'when-searching'
c.scrolling.smooth = True

c.session.lazy_restore = True

c.tabs.background = True
c.tabs.show = 'multiple'
c.tabs.show_switching_delay = 500
c.tabs.mousewheel_switching = False
c.tabs.new_position.unrelated = 'next'
c.window.transparent = True
c.window.hide_decoration = True
c.url.open_base_url = True

c.aliases = {
	"q": "close",
	"qa": "quit",
	"w": "session-save",
	"wq": "quit --save",
	"wqa": "quit --save",
	"echo":"message-info"
}

c.url.searchengines = {
	'DEFAULT': 'https://www.duckduckgo.com/?q={}',
	'4': 'https://4chan.org/{}',
	'a': 'https://wiki.archlinux.org/index.php?title=Special%3ASearch&search={}',
	'd': 'https://html.duckduckgo.com/html?q={}', # nojs version of duckduckgo
	'g': 'https://www.google.com/search?hl=en&q={}',
	'h': 'https://github.com/{}',
	'm2': 'https://man.archlinux.org/{}', # arch man pages
	'm': 'https://linux.die.net/man/1/{}', # man pages
	'p': 'https://thepiratebay.org/search.php?q={}',
	'w': 'https://web.archive.org/web/*/{}',
	'y': 'https://www.youtube.com/results?search_query={}',
}

# # block youtube ads from playing. still have to skip them however.
# # Source: https://www.reddit.com/r/qutebrowser/comments/my7tbq/block_youtube_ads/
# def filter_yt(info: interceptor.Request):
# 	url = info.request_url
# 	if (url.host() == "www.youtube.com" 
# 		and url.path() == "/get_video_info"
# 		and "&adformat=" in url.query()
# 	):
# 		info.block()

# interceptor.register(filter_yt)

c.bindings.commands = {
	"normal": {
		"A" : "set-cmd-text :open {url:pretty}",
		"H" : "fake-key <left>",
		"J" : "back",
		"K" : "forward",
		"L" : "fake-key <right>",
		"ZQ": "close",
		"ZZ": "save;; close",
		"ZA": "quit --save",
		"ce": "config-edit",
		"ef": "fake-key f",
		"ei": "fake-key i",
		"e<space>": "fake-key <esc>",
		"h" : "tab-prev",
		"l" : "tab-next",
		"!" : "set-cmd-text :open !",
		",m": "spawn umpv {url}",
		",M": "spawn mpv {url}",
		",p": "config-cycle content.proxy socks://localhost:9050/ system",
		",s": "config-cycle statusbar.show always never",
		",t": "config-cycle tabs.show multiple never",
		",u": "config-cycle statusbar.show never always;; config-cycle tabs.show never multiple",
		",w": "open https://web.archive.org/*/{url}",
		",y": "set-cmd-text -s :jseval document.getElementsByTagName('video')[0].playbackRate =",
		";M": "hint --rapid links spawn umpv {hint-url}",
		";m": "hint links spawn umpv {hint-url}",
	},
	"insert": {
		"<ctrl-j>": "fake-key <enter>",
		"<ctrl-m>": "fake-key <enter>",
		"<ctrl-w>": "fake-key <ctrl-backspace>",
		"<ctrl-u>": "fake-key <shift-home><backspace>",
		"<ctrl-k>": "fake-key <shift-end><backspace>",
		"<ctrl-d>": "fake-key <ctrl-a><backspace>",
		# "<ctrl-f>": "fake-key <right>",
		# "<ctrl-b>": "fake-key <left>",
		"<alt-f>" : "fake-key <ctrl-right>",
		"<alt-b>" : "fake-key <ctrl-left>",
	}
}
