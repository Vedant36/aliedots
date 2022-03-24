#!/usr/bin/env python
# Documentation: qute://help/configuring.html qute://help/settings.html
import subprocess
import os
# Settings {{{1
# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103,W0127
config = config  # noqa: F821 pylint: disable=E0602,C0103,W0127
TERMCMD = ['kitty', '-1']
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
BASEDIR = os.getenv("XDG_CONFIG_HOME", os.path.join(os.getenv('HOME'), '.config'))
# TODO: darkmode and better-duckduckgo not working
c.content.user_stylesheets = [
    f'{BASEDIR}/qutebrowser/fix-tooltips.qss',
    # f'{BASEDIR}/qutebrowser/darkmode.qss',
    # f'{BASEDIR}/qutebrowser/better-duckduckgo.css'
]
c.content.webrtc_ip_handling_policy = 'disable-non-proxied-udp'
c.content.geolocation = False
c.downloads.location.suggestion = 'both'
c.downloads.remove_finished = 1
c.editor.command = [*TERMCMD, 'nvim', '-c', 'norm {line}G{column0}l', '{file}']
c.hints.border = '0'
c.hints.chars = 'asdfjkl;ghnmxcvbziowerutyqp'
c.hints.padding = {"bottom": 1, "left": 1, "right": 1, "top": 1}
c.input.insert_mode.auto_load = True
c.scrolling.bar = 'when-searching'
c.scrolling.smooth = True
c.session.lazy_restore = True
c.statusbar.padding = {"bottom": 0, "left": 0, "right": 0, "top": 0}
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
c.fileselect.single_file.command = [*TERMCMD, 'ranger', '--choosefile', '{}']
c.fileselect.multiple_files.command = [*TERMCMD, 'ranger', '--choosefiles', '{}']
c.fileselect.folder.command = [*TERMCMD, 'ranger', '--choosedir', '{}']
# Fonts {{{1
FONT_SIZE = '10pt'
FIXED = 'Iosevka Mayukai CodePro'
SANS_SERIF = 'Futura'
SERIF = 'Helvetica'
c.fonts.default_family = SANS_SERIF
# c.fonts.default_family = [ "Futura", "Unifont" ]
c.fonts.statusbar = f'{FONT_SIZE} {FIXED}'
c.fonts.completion.category = f'{FONT_SIZE} {FIXED}'
c.fonts.completion.entry = f'{FONT_SIZE} {FIXED}'
c.fonts.hints = f'{FONT_SIZE} {FIXED}'
# c.fonts.web.family.fixed = FIXED
c.fonts.web.family.sans_serif = SANS_SERIF
c.fonts.web.family.serif = SERIF
c.fonts.web.family.standard = SANS_SERIF
c.fonts.web.size.default = 14
c.fonts.web.size.default_fixed = 14
# Aliases {{{1
c.aliases["echo"] = "message-info"
c.aliases["sleep"] = "later"
# Search Engines {{{1
c.url.searchengines = {
    # actual search engines
    'DEFAULT': 'https://www.duckduckgo.com/?q={}',
    'd': 'https://html.duckduckgo.com/html?q={}',  # nojs version of duckduckgo
    '4': 'https://4chan.org/{}',
    'g': 'https://www.google.com/search?hl=en&q={}',
    'mw': 'https://www.merriam-webster.com/dictionary/{}',
    'l': 'https://lyrics.com/lyrics/{}',  # lyric finding engine
    'r': 'https://reddit.com/r/{}',
    's': 'https://open.spotify.com/search/{}',
    'su': 'https://steamunlocked.net/?s={}',
    'wiby': 'https://wiby.me/?q={}',
    'scp': 'https://scp-wiki.wikidot.com/scp-{}',
    'mc': 'https://minecraft.fandom.com/wiki/{}',
    'x': 'https://searx.xyz/search?q={}',
    'y': 'https://youtube.com/search?q={}',
    'yw': 'https://youtube.com/watch?v={}',
    'y2': 'https://yewtu.be/search?q={}',  # invidious
    # books
    'b': 'https://1lib.in/s/{}',
    'b2': 'https://www.pdfdrive.com/search?q={}',
    'b3': 'https://libgen.me/search?query={}',
    'b4': 'https://libgen.is/search.php?req={}',
    # math
    'o': 'http://oeis.org/search?q={}',
    'oa': 'http://oeis.org/A{}',
    'ob': 'http://oeis.org/b{}.txt',
    'wa': 'https://www.wolframalpha.com/input/?i={}',
    'wm': 'https://mathworld.wolfram.com/search/index.html?query={}',
    # linux
    'a': 'https://wiki.archlinux.org/index.php?search={}',
    'gw': 'https://wiki.gentoo.org/index.php?search={}',
    'm': 'https://linux.die.net/man/1/{}',  # man pages
    'm2': 'https://man.archlinux.org/{}',  # arch man pages
    'aur': 'https://aur.archlinux.org/packages/{}',
    'al': 'https://archlinux.org/packages/?q={}',
    'ala': 'https://archlinux.org/packages/core/x86_64/{}',
    'alc': 'https://archlinux.org/packages/community/x86_64/{}',
    'ale': 'https://archlinux.org/packages/extra/x86_64/{}',
    # programming
    'asm': 'https://www.felixcloutier.com/x86/{}',
    'c': 'https://duckduckgo.com/?sites=cppreference.com&q={}',
    'cl': 'https://en.cppreference.com/w/c/language/{}',
    'dd': 'https://devdocs.io/{}',
    'gh': 'https://github.com/{}',
    'gl': 'https://github.com/Vedant36/{}',
    'ide': 'https://glot.io/new/{}',  # online code editor without login
    'grep': 'https://grep.app/search?q={}',  # search for code examples
    'py': 'https://pypi.org/search/?q={}',
    'xy': 'https://learnxinyminutes.com/docs/{}',  # learning new prog.lang.
    # films and shows
    'ap': 'https://animixplay.to/?q={}',  # anime
    'manga': 'https://mangareader.to/search?keyword={}',
    'p': 'https://thepiratebay.org/search.php?q={}',
    'p2': 'https://tpb.one/search.php?q={}',
}
# Youtube/Ad Blocking {{{1
c.content.javascript.enabled = True
c.content.autoplay = False
c.content.blocking.adblock.lists = [
    "https://raw.githubusercontent.com/brave/adblock-lists/master/brave-unbreak.txt",
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://easylist.to/easylist/fanboy-annoyance.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
]
c.content.blocking.enabled = True
c.content.blocking.hosts.lists = [
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts",
    "https://blocklistproject.github.io/Lists/everything.txt",
]
c.content.blocking.method = 'adblock'

# Bindings {{{1
c.bindings.commands = {}
c.bindings.commands["normal"] = {
    "!":  "set-cmd-text :open !",
    "A":  "set-cmd-text :open {url:pretty}",
    "H":  "fake-key <left>",
    "J":  "back",
    "K":  "forward",
    "L":  "fake-key <right>",
    "ZA": "quit --save",
    "ZQ": "close",
    "ZZ": "save;; close",
    "<ctrl-r>": "save;; restart",
    "ce": "config-edit",
    "cs": "config-source",

    # pass fake key to qutebrowser
    **{f"e{i}": f"fake-key {i}"
        for i in "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"},
    "e<space>": "fake-key <esc>",

    # like gi but clears text too(on most sites)
    "gI": "hint inputs --first;; mode-enter insert;; fake-key <ctrl-a><backspace>",
    "gw": "open https://web.archive.org/web/*/{url:pretty}",
    "h":  "tab-prev",
    "l":  "tab-next",
    "ya": "yank inline '<a href={url}>{title}</a>'",
    "yw": "fake-key <ctrl-a>",
    ";n": "hint links spawn -d st nvim {hint-url}",
    ";s": "hint links spawn -d surf {hint-url}",
    "S": "spawn -d surf {url}",

    # Binds to open current url in mpv/upmpv
    ",m": "spawn -d mpv {url}",
    ",M": "hint links spawn -d mpv {hint-url}",
    "M":  "spawn -d umpv {url}",
    "2M": "spawn -d umpv -p 2 {url}",
    ";M": "hint --rapid links spawn umpv {hint-url}",
    ";m": "hint links spawn umpv {hint-url}",
    "2;m": "hint links spawn umpv -p 2 {hint-url}",

    # config-cycle
    ",b": "config-cycle content.blocking.enabled;; reload",
    ",p": "config-cycle content.proxy socks://localhost:9050/ system",
    ",s": "config-cycle -t statusbar.show never always",
    ",t": "config-cycle -t tabs.show multiple never",
    ",u": "config-cycle -t statusbar.show never always;; config-cycle tabs.show never multiple",

    # to change playback rate on youtube
    ",y": "set-cmd-text -s :jseval -q document.getElementsByTagName('video')[0].playbackRate =",
}
c.bindings.commands["insert"] = {
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
    "<Ctrl-j>": "fake-key <Enter>",
    "<Ctrl-k>": "fake-key <Shift-End><Delete>",
    "<Ctrl-m>": "fake-key <Enter>",
    "<Ctrl-n>": "fake-key <Down>",
    "<Ctrl-p>": "fake-key <Up>",
    "<Ctrl-u>": "fake-key <Shift-Home><Delete>",
    "<Ctrl-w>": "fake-key <Ctrl-Backspace>",
    "<Ctrl-x><Ctrl-e>": "edit-text",
}

# Darkmode/Colors from Xresources {{{1
c.colors.webpage.darkmode.enabled = False
c.colors.webpage.darkmode.policy.images = 'never'
c.colors.webpage.preferred_color_scheme = 'dark'
c.colors.webpage.darkmode.algorithm = 'lightness-hsl'
c.colors.webpage.darkmode.contrast = -.022  # the lower the darker
c.colors.webpage.darkmode.threshold.text = 150
c.colors.webpage.darkmode.threshold.background = 100

# taken from https://qutebrowser.org/doc/help/configuring.html
# 0:black, 1:red, 2:green,, 3:yellow, 4:blue, 5:magenta, 6:cyan, 7:white
# +8 are lighter variants in most color schemes
xresources = {}
x = subprocess.run(["xrdb", "-query"], stdout=subprocess.PIPE, check=False)
lines = x.stdout.decode().split("\n")
for line in filter(lambda l: l.startswith("*"), lines):
    prop, _, value = line.partition(":\t")
    xresources[prop] = value

BG = xresources["*.background"]
FG = xresources["*.foreground"]

c.colors.webpage.bg = '#ccc7bb'
c.colors.statusbar.normal.bg = BG
c.colors.statusbar.command.bg = BG
c.colors.statusbar.command.fg = FG
c.colors.statusbar.normal.fg = FG
c.colors.statusbar.url.success.https.fg = xresources["*.color2"]
c.colors.statusbar.url.hover.fg = xresources["*.color4"]

EVEN = xresources["*.background"]
ODD = "#15161e"
SELECTED = xresources["*.color8"]
c.colors.tabs.even.bg = EVEN
c.colors.tabs.odd.bg = ODD
c.colors.tabs.even.fg = FG
c.colors.tabs.odd.fg = FG
c.colors.tabs.selected.even.bg = SELECTED
c.colors.tabs.selected.odd.bg = SELECTED
c.colors.hints.bg = FG
c.colors.hints.fg = BG

c.colors.tabs.indicator.start = xresources["*.color4"]
c.colors.tabs.indicator.stop = xresources["*.color6"]
c.colors.tabs.indicator.error = xresources["*.color1"]
c.colors.completion.even.bg = EVEN
c.colors.completion.odd.bg = ODD
c.colors.completion.fg = FG
c.colors.completion.category.bg = BG
c.colors.completion.category.fg = FG
c.colors.completion.item.selected.bg = BG
c.colors.completion.item.selected.fg = FG

# Headers and javascript exceptions {{{1
c.content.webgl = False
c.content.canvas_reading = False
c.content.headers.accept_language = 'en-US,en;q=0.5'
c.content.headers.custom = {"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"}
c.content.headers.user_agent = 'Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0'
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
# }}}
