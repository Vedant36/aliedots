/* See LICENSE file for copyright and license details. */
// appearance {{{1
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int gappx     = 0;        /* gaps between windows */
static const unsigned int snap      = 4;       /* snap pixel */
static const int showbar            = 0;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const char *fonts[]          = { "Iosevka Term:size=10" };
static const char dmenufont[]       = "Iosevka Term:size=10";
/* static const char col_gray3[]       = "#545c7e"; */
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

// tagging {{{1
static const char *tags[] = { "", "", "", "", "", "ﭮ", "", "﫸" };

// Rules {{{1
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class          instance     title       tags mask   isfloating  monitor */
	{ NULL,           NULL,   "TLauncher 2.8", 1 << 0,     0,          -1 },
	{ NULL,           NULL,   "TLauncher",     1 << 0,     0,          -1 },
	{ "Popcorn-Time", NULL,        NULL,       1 << 0,     0,          -1 },
	{ "Zathura",      NULL,        NULL,       1 << 1,     0,          -1 },
	{ "qutebrowser",  NULL,        NULL,       1 << 2,     0,          -1 },
	{ NULL,      "ncmpcpp",        NULL,       1 << 3,     0,          -1 },
	{ "mpv",          NULL,        NULL,       1 << 4,     0,          -1 },
	{ "discord",      NULL,        NULL,       1 << 5,     0,          -1 },
	{ "Minecraft* 1.16.5", NULL,   NULL,       1 << 6,     0,          -1 },
	{ "Minecraft* 1.17.1", NULL,   NULL,       1 << 6,     0,          -1 },
	{ "transmission", NULL,        NULL,       1 << 7,     0,          -1 },
};
// layout(s) {{{1
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};
// key definitions {{{1
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
// helper for spawning shell commands in the pre dwm-5.0 fashion {{{1
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#include <X11/XF86keysym.h>
// commands {{{1
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1,
	"-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, "-l", "20", "-p", "$", NULL };
static const char *desktop_dmenucmd[] = { "dmenu_drun", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1,
	"-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, "-l", "20", "-p", "$", NULL };
static const char *termcmd[] = { "kitty", "-1", NULL };
static const char *fmcmd[] = { "kitty", "-1", "ranger", NULL };
static const char *upvol[]   = { "/usr/bin/pactl", "set-sink-volume", "0", "+2%",     NULL };
static const char *downvol[] = { "/usr/bin/pactl", "set-sink-volume", "0", "-2%",     NULL };
static const char *mutevol[] = { "/usr/bin/pactl", "set-sink-mute",   "0", "toggle",  NULL };

static Key keys[] = {
	/* modifier                     key               function        argument */
	{ MODKEY,                       XK_p,             spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_p,             spawn,          {.v = desktop_dmenucmd } },
	{ MODKEY|ControlMask,           XK_q,             spawn,          SHCMD("echo -e 'poweroff\nreboot' | dmenu -l 20 | sh") },
	{ MODKEY,                       XK_q,             spawn,          {.v = termcmd} },
	{ MODKEY,                       XK_r,             spawn,          SHCMD("st -n ncmpcpp ncmpcpp") },
	{ MODKEY|ShiftMask,             XK_r,             spawn,          SHCMD("notify-send -u low \"$(mpc|head -n1)\" \"$(mpc |awk 'NR==2')\"") },

	{ MODKEY,                       XK_a,             spawn,          {.v = fmcmd} },
	{ MODKEY,                       XK_s,             spawn,          SHCMD("cd $HOME/dox/textfiles && kitty -1 nvim todo.md data.md sites.md") },
	{ MODKEY|ShiftMask,             XK_s,             spawn,          SHCMD("state") },
	{ MODKEY|ShiftMask,             XK_m,             spawn,          SHCMD("dmenu_mount") },
	{ MODKEY,                       XK_v,             spawn,          SHCMD("kitty -1 nvim") },
	{ MODKEY|ShiftMask,             XK_p,             spawn,          SHCMD("kitty -1 pulseaudio") },
	{ MODKEY|ControlMask,           XK_b,             spawn,          SHCMD("kitty -1 bc -l") },

	{ MODKEY,                       XK_b,             togglebar,      {0} },
	{ MODKEY|ShiftMask,             XK_b,             spawn,          SHCMD("pkill sleep") },

	{ MODKEY,                       XK_d,             spawn,          SHCMD("discord") },
	{ MODKEY|ShiftMask,             XK_e,             spawn,          SHCMD("lock") },
	{ MODKEY,                       XK_e,             spawn,          SHCMD("systemctl suspend") },
	{ MODKEY,                       XK_w,             spawn,          SHCMD("qutebrowser") },
	{ MODKEY|ShiftMask,             XK_w,             spawn,          SHCMD("/usr/bin/qutebrowser --temp-basedir --set content.private_browsing true --config-py $XDG_CONFIG_HOME/qutebrowser/config.py") },
	{ MODKEY|ControlMask,           XK_w,             spawn,          SHCMD("torb") },
	{ MODKEY,                       XK_j,             focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,             focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,             incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,             incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,             setmfact,       {.f = -0.01} },
	{ MODKEY,                       XK_l,             setmfact,       {.f = +0.01} },
	{ MODKEY,                       XK_Return,        zoom,           {0} },
	{ MODKEY,                       XK_Tab,           view,           {0} },

	{ MODKEY,                       XK_x,             killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_x,             spawn,          SHCMD("xdotool getwindowfocus windowkill") },
	{ MODKEY|ControlMask,           XK_x,             spawn,          SHCMD("pkill -x Xorg") },
	{ MODKEY|ShiftMask|ControlMask, XK_x,             spawn,          SHCMD("xkill") },

	{ MODKEY,                       XK_t,             setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,             setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,             setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,         setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,         togglefloating, {0} },

	{ MODKEY,                       XK_minus,         setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_equal,         setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_equal,         setgaps,        {.i = 0  } },

	{ MODKEY,                       XK_bracketleft,   spawn,          {.v = downvol } },
	{ MODKEY,                       XK_bracketright,  spawn,          {.v = upvol   } },
	{ MODKEY,                       XK_backslash,     spawn,          {.v = mutevol } },
	{ MODKEY|ShiftMask,             XK_bracketleft,   spawn,          SHCMD("mpc volume -2") },
	{ MODKEY|ShiftMask,             XK_bracketright,  spawn,          SHCMD("mpc volume +2") },
	{ MODKEY|ShiftMask,             XK_backslash,     spawn,          SHCMD("mpc toggle") },
	{ MODKEY|ShiftMask,             XK_comma,         spawn,          SHCMD("mpc prev") },
	{ MODKEY|ShiftMask,             XK_period,        spawn,          SHCMD("mpc next") },
	{ MODKEY,                       XK_comma,         spawn,          SHCMD("mpc seek -1") },
	{ MODKEY,                       XK_period,        spawn,          SHCMD("mpc seek +1") },

	{ MODKEY,                       XK_F1,            spawn,          SHCMD("kitty -1 nvim ~/.local/opt/dwm/config.h") },
	{ MODKEY,                       XK_F2,            spawn,          SHCMD("bright -i -5") },
	{ MODKEY,                       XK_F3,            spawn,          SHCMD("bright -i 5") },

	{ MODKEY,                       XK_0,             view,           {.ui = ~0 } },
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
	{ MODKEY|ShiftMask,             XK_q,             quit,           {0} },
	{ 0,                            XK_Print,         spawn,          SHCMD("scrot \"$HOME/pix/screenshots/ss_%F_%H-%M-%S.png\"") },
	{ ShiftMask,                    XK_Print,         spawn,          SHCMD("scrot -s -f \"$HOME/pix/screenshots/ss_%F_%H-%M-%S.png\"") },
	{ ControlMask,                  XK_Print,         spawn,          SHCMD("scrot '/tmp/scrot.png' -e 'xclip -selection clipboard -t image/png -i $f && rm $f'") },
	{ ControlMask|ShiftMask,        XK_Print,         spawn,          SHCMD("scrot '/tmp/scrot.png' -s -f -e 'xclip -selection clipboard -t image/png -i $f && rm $f'") },
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

