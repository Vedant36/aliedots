/* See LICENSE file for copyright and license details. */
// [How to maintain dwm configuration and customization in git](https://dwm.suckless.org/customisation/patches_in_git/)
// appearance {{{1
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 0;        /* gaps between windows */
static const unsigned int snap      = 4;       /* snap pixel */
static const int showbar            = 0;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const char *fonts[]          = { "Iosevka Mayukai CodePro:size=10" };
static const char dmenufont[]       = "Iosevka Mayukai CodePro:size=10";
static const char col_gray1[]       = "#1a1b26";
static const char col_gray2[]       = "#1f2335";
static const char col_gray3[]       = "#a9b1d6";
static const char col_gray4[]       = "#c0caf5";
static const char col_cyan[]        = "#33467c";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

static const char *tags[] = { "", "", "爵", "", "", "ﭮ", "", "﫸", "8", "9" };

// Rules {{{1
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class               instance   title        tags mask  isfloating  monitor */
	{ NULL,                NULL,      "textfiles", 1 << 3,    0,          -1 },
	/* { "Emacs",             NULL,      NULL,        1 << 4,    0,          -1 }, */
	{ "Lutris",            NULL,      NULL,        1 << 0,    0,          -1 },
	{ "Popcorn-Time",      NULL,      NULL,        1 << 0,    0,          -1 },
	{ "Zathura",           NULL,      NULL,        1 << 1,    0,          -1 },
	{ "qutebrowser",       NULL,      NULL,        1 << 2,    0,          -1 },
	{ "YouTube to MP3",    NULL,      NULL,        1 << 0,    0,          -1 },
	{ "Surf",              NULL,      NULL,        1 << 2,    0,          -1 },
	{ NULL,                "ncmpcpp", NULL,        1 << 3,    0,          -1 },
	{ "mpv",               NULL,      NULL,        1 << 4,    0,          -1 },
	{ "discord",           NULL,      NULL,        1 << 5,    0,          -1 },
	{ "Minecraft",         NULL,      NULL,        1 << 6,    0,          -1 },
	{ NULL,                NULL,      "Factorio",  1 << 6,    0,          -1 },
	{ "stardew valley.exe",NULL,      NULL,        1 << 6,    0,          -1 },
	{ "transmission",      NULL,      NULL,        1 << 7,    0,          -1 },
};
// layout(s) {{{1
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 0; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[M]",      monocle },    /* first entry is default */
	{ "[]=",      tile },
	{ "><>",      NULL },    /* no layout function means floating behavior */
};
// key definitions {{{1
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
// commands {{{1
// helper for spawning shell commands in the pre dwm-5.0 fashion
#define TERM "kitty"
#define TERMARG "-1"
#define TERMLIGHT "st"
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#include <X11/XF86keysym.h>
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1,
	"-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, "-l", "20", "-p", "$", NULL };
static const char *desktop_dmenucmd[] = { "dmenu_drun", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1,
	"-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, "-l", "20", "-p", "$", NULL };
static const char scratchpadname[] = "scratchpad";
/* static const char *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "120x34", NULL }; */
static const char *scratchpadcmd[] = { "kitty",
		"--title", scratchpadname,
		"-o", "initial_window_width=960",
		"-o", "initial_window_height=540",
		"-o", "remember_window_size=no",
		NULL };
static const char *termcmd[] = { TERM, TERMARG, NULL };

static Key keys[] = {
	/* modifier                     key               function        argument */
	{ MODKEY,                       XK_p,             spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_p,             spawn,          {.v = desktop_dmenucmd } },
	{ MODKEY,                       XK_q,             spawn,          {.v = termcmd} },
	{ MODKEY,                       XK_Escape,        togglescratch,  {.v = scratchpadcmd } },
    /* Terminal {{{2 */
	{ MODKEY,                       XK_r,             spawn,          SHCMD(TERMLIGHT " -n ncmpcpp ncmpcpp") },
	{ MODKEY,                       XK_a,             spawn,          SHCMD(TERM " " TERMARG " ranger") },
	{ MODKEY,                       XK_v,             spawn,          SHCMD(TERM " " TERMARG " nvim") },
	{ MODKEY|ControlMask,           XK_p,             spawn,          SHCMD(TERMLIGHT " pulsemixer") },
	{ MODKEY|ControlMask,           XK_b,             spawn,          SHCMD(TERMLIGHT " bc -l") },
	{ MODKEY|ShiftMask|ControlMask, XK_b,             spawn,          SHCMD("books.sh") },
	{ MODKEY,                       XK_F1,            spawn,          SHCMD(TERMLIGHT " nvim ~/.local/opt/dwm/config.h") },
	{ MODKEY,                       XK_s,             spawn,          SHCMD("cd $HOME/dox/textfiles && " TERM " -T textfiles nvim todo.md data.md sites.md autocmd.md math.md") },
    /* Custom Scripts {{{2 */
	{ MODKEY|ShiftMask,             XK_r,             spawn,          SHCMD("notify-send -u low \"$(mpc|head -n1)\" \"$(mpc |awk 'NR==2')\"") },
	{ MODKEY,                       XK_g,             spawn,          SHCMD("xdotool type \"$(grep -v '^#' ~/.local/lib/dotfiles/shortcuts | dmenu -i -l 50 | cut -d';' -f2-)\"") },
	{ MODKEY|ShiftMask,             XK_s,             spawn,          SHCMD("state") },
	{ MODKEY|ShiftMask,             XK_m,             spawn,          SHCMD("dmenu_mount") },
	{ MODKEY,                       XK_z,             spawn,          SHCMD("boomer") },
	/* Brightness {{{2 */
	{ MODKEY,                       XK_F2,            spawn,          SHCMD("bright -ri -1") },
	{ MODKEY,                       XK_F3,            spawn,          SHCMD("bright -ri 1") },
	{ MODKEY|ControlMask,           XK_F2,            spawn,          SHCMD("bright -i -1") },
	{ MODKEY|ControlMask,           XK_F3,            spawn,          SHCMD("bright -i 1") },
    /* Dwmblocks {{{2 */
	{ MODKEY,                       XK_b,             togglebar,      {0} },
	{ MODKEY|ShiftMask,             XK_b,             spawn,          SHCMD("pkill sleep") },
    /* Browsers {{{2 */
	{ MODKEY,                       XK_w,             spawn,          SHCMD("qutebrowser") },
	{ MODKEY|ShiftMask,             XK_w,             spawn,          SHCMD("/usr/bin/qutebrowser --temp-basedir --set content.private_browsing true --config-py $XDG_CONFIG_HOME/qutebrowser/config.py") },
	{ MODKEY|ControlMask,           XK_w,             spawn,          SHCMD("tor-browser") },
	{ MODKEY|ShiftMask|ControlMask, XK_w,             spawn,          SHCMD("surf \"$(cat $XDG_CONFIG_HOME/qutebrowser/quickmarks | cut -d\" \" -f2- | dmenu -p 'surf:')\"") },
    /* Other Apps {{{2 */
	{ MODKEY,                       XK_d,             spawn,          SHCMD("discord") },
	{ MODKEY,                       XK_e,             spawn,          SHCMD("emacsclient --create-frame --alternate-editor=") },
	{ MODKEY|ShiftMask,             XK_e,             spawn,          SHCMD("lock") },
	{ MODKEY|ControlMask,           XK_e,             spawn,          SHCMD("event") },
    /* Stack/Layout {{{2 */
	{ MODKEY,                       XK_j,             focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,             focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,             incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,             incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,             setmfact,       {.f = -0.01} },
	{ MODKEY,                       XK_l,             setmfact,       {.f = +0.01} },
	{ MODKEY,                       XK_Return,        zoom,           {0} },
	{ MODKEY,                       XK_Tab,           view,           {0} },

	{ MODKEY,                       XK_m,             setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_t,             setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_f,             setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,         setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,         togglefloating, {0} },
    /* Gaps(smh) {{{2 */
	{ MODKEY,                       XK_minus,         setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_equal,         setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_equal,         setgaps,        {.i = 0  } },
    /* Audio/Music {{{2 */
	{ MODKEY,                       XK_bracketleft,   spawn,          SHCMD("pactl set-sink-volume @DEFAULT_SINK@ -1% ; restart-bar") },
	{ MODKEY,                       XK_bracketright,  spawn,          SHCMD("pactl set-sink-volume @DEFAULT_SINK@ +1% ; restart-bar") },
	{ MODKEY,                       XK_backslash,     spawn,          SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle; restart-bar") },
	{ MODKEY|ControlMask,           XK_bracketleft,   spawn,          SHCMD("pactl set-source-volume @DEFAULT_SOURCE@ -1% ; restart-bar") },
	{ MODKEY|ControlMask,           XK_bracketright,  spawn,          SHCMD("pactl set-source-volume @DEFAULT_SOURCE@ +1% ; restart-bar") },
	{ MODKEY|ControlMask,           XK_backslash,     spawn,          SHCMD("pactl set-source-mute @DEFAULT_SOURCE@ toggle; restart-bar") },
	{ MODKEY|ShiftMask,             XK_bracketleft,   spawn,          SHCMD("mpc -q volume -1") },
	{ MODKEY|ShiftMask,             XK_bracketright,  spawn,          SHCMD("mpc -q volume +1") },
	{ MODKEY|ShiftMask,             XK_backslash,     spawn,          SHCMD("mpc -q toggle") },
	{ MODKEY|ShiftMask,             XK_comma,         spawn,          SHCMD("mpc -q prev") },
	{ MODKEY|ShiftMask,             XK_period,        spawn,          SHCMD("mpc -q next") },
	{ MODKEY,                       XK_comma,         spawn,          SHCMD("mpc -q seek -1") },
	{ MODKEY,                       XK_period,        spawn,          SHCMD("mpc -q seek +1") },
	{ MODKEY,                       XK_BackSpace,     spawn,          SHCMD("mpc -q seek 0") },
    /* Switching between tags {{{2 */
    // toggles with the last layout
	{ MODKEY,                       XK_0,             view,           {.ui = ~0 } },
    // Views all tags
	{ MODKEY|ShiftMask,             XK_0,             tag,            {.ui = ~0 } },
	TAGKEYS(                        XK_grave,                  0)
	TAGKEYS(                        XK_1,                      1)
	TAGKEYS(                        XK_2,                      2)
	TAGKEYS(                        XK_3,                      3)
	TAGKEYS(                        XK_4,                      4)
	TAGKEYS(                        XK_5,                      5)
	TAGKEYS(                        XK_6,                      6)
	TAGKEYS(                        XK_7,                      7)
	TAGKEYS(                        XK_8,                      8)
	TAGKEYS(                        XK_9,                      9)
    /* Closing and quiting {{{2 */
	{ MODKEY,                       XK_F4,             killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_F4,             spawn,          SHCMD("xdotool getwindowfocus windowkill") },
	{ MODKEY|ControlMask,           XK_F4,             spawn,          SHCMD("pkill -x Xorg") },
	{ MODKEY|ShiftMask|ControlMask, XK_F4,             spawn,          SHCMD("xkill") },
	{ MODKEY|ControlMask,           XK_q,             spawn,          SHCMD("echo -e 'poweroff\nreboot\nsuspend' | dmenu -l 20 | sh") },
	{ MODKEY|ShiftMask,             XK_q,             quit,           {0} },
    /* Screenshotting {{{2 */
	{ 0,                            XK_Print,         spawn,          SHCMD("scrot \"$HOME/pix/screenshots/ss_%F_%H-%M-%S.png\"") },
	{ ShiftMask,                    XK_Print,         spawn,          SHCMD("scrot '/tmp/scrot.png' -e 'xclip -selection clipboard -t image/png -i $f && rm $f'") },
	{ ControlMask,                  XK_Print,         spawn,          SHCMD("scrot -s -f \"$HOME/pix/screenshots/ss_%F_%H-%M-%S.png\"") },
	{ ControlMask|ShiftMask,        XK_Print,         spawn,          SHCMD("scrot '/tmp/scrot.png' -s -f -e 'xclip -selection clipboard -t image/png -i $f && rm $f'") },
    /* }}}2 */
};

// button definitions {{{1
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
// }}}1
// vim: fdm=marker ts=4
