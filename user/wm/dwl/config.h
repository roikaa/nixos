/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

/* appearance */
static const int sloppyfocus               = 1;  /* focus follows mouse */
static const int bypass_surface_visibility = 0;
static const unsigned int borderpx         = 3;
static const float rootcolor[]             = COLOR(0x1d2021ff);
static const float bordercolor[]           = COLOR(0x3c3836aa);
static const float focuscolor[]            = COLOR(0xd65d0eff);
static const float urgentcolor[]           = COLOR(0xfb4934ff);
static const float fullscreen_bg[]         = {0.0f, 0.0f, 0.0f, 1.0f};

/* tagging - TAGCOUNT must be no greater than 31 */
#define TAGCOUNT (9)

/* logging */
static int log_level = WLR_ERROR;

static const Rule rules[] = {
	/* app_id             title       tags mask     isfloating   monitor */
	{ "Gimp_EXAMPLE",     NULL,       0,            1,           -1 },
	{ "firefox_EXAMPLE",  NULL,       1 << 8,       0,           -1 },
    /* default/example rule: can be changed but cannot be eliminated */
};

/* layout(s) */
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },
	{ "><>",      NULL },    /* floating */
	{ "[M]",      monocle },
};

/* monitors */
static const MonitorRule monrules[] = {
	/* name       mfact  nmaster scale layout                       rotate/reflect                x    y  */
	/* Your external monitor — adjust name to match `wlr-randr` output */
	{ "HDMI-A-2", 0.55f, 1,      1,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 },
	/* Your laptop screen */
	{ "eDP-1",    0.55f, 1,      1,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 },
	/* fallback for any other monitor */
	{ NULL,       0.55f, 1,      1,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 },
};

/* keyboard — matches your Hyprland input config */
static const struct xkb_rule_names xkb_rules = {
	.options = "ctrl:nocaps",  /* CapsLock → Ctrl, same as before */
};

static const int repeat_rate  = 50;   /* matches repeat_rate = "50" */
static const int repeat_delay = 300;  /* matches repeat_delay = "300" */

/* Trackpad */
static const int tap_to_click          = 1;
static const int tap_and_drag          = 1;
static const int drag_lock             = 1;
static const int natural_scrolling     = 0;
static const int disable_while_typing  = 1;
static const int left_handed           = 0;
static const int middle_button_emulation = 0;
static const enum libinput_config_scroll_method scroll_method = LIBINPUT_CONFIG_SCROLL_2FG;
static const enum libinput_config_click_method click_method   = LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS;
static const uint32_t send_events_mode  = LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;
static const enum libinput_config_accel_profile accel_profile = LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE;
static const double accel_speed = 0.0;
static const enum libinput_config_tap_button_map button_map = LIBINPUT_CONFIG_TAP_MAP_LRM;

/* MODKEY = Super (matches $mod = "SUPER" in Hyprland) */
#define MODKEY WLR_MODIFIER_LOGO

#define TAGKEYS(KEY,SKEY,TAG) \
	{ MODKEY,                    KEY,            view,            {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL,  KEY,            toggleview,      {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_SHIFT, SKEY,           tag,             {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL|WLR_MODIFIER_SHIFT,SKEY,toggletag, {.ui = 1 << TAG} }

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *termcmd[]    = { "foot", NULL };
static const char *menucmd[]    = { "wmenu-run", NULL };         /* was rofi -show drun */
static const char *browsercmd[] = { "librewolf", NULL };         /* $mod W */
static const char *lockcmd[]    = { "swaylock", NULL };          /* $mod SHIFT L */

/* media / brightness / screenshot helpers — using SHCMD for shell pipes */
static const char *vol_up[]    = { "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+", NULL };
static const char *vol_down[]  = { "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-", NULL };
static const char *vol_mute[]  = { "wpctl", "set-mute",   "@DEFAULT_AUDIO_SINK@",  "toggle", NULL };
static const char *mic_mute[]  = { "wpctl", "set-mute",   "@DEFAULT_AUDIO_SOURCE@", "toggle", NULL };
static const char *br_up[]     = { "brightnessctl", "set", "5%+", NULL };
static const char *br_down[]   = { "brightnessctl", "set", "5%-", NULL };
static const char *media_pp[]  = { "playerctl", "play-pause", NULL };
static const char *media_next[]= { "playerctl", "next", NULL };
static const char *media_prev[]= { "playerctl", "previous", NULL };

static const Key keys[] = {
	/* modifier                  key                         function        argument */

	/* ── Launchers ─────────────────────────────────────────────────────────── */
	{ MODKEY,                    XKB_KEY_p,                  spawn,          {.v = menucmd} },
	{ MODKEY,                    XKB_KEY_Return,             spawn,          {.v = termcmd} },
	{ MODKEY,                    XKB_KEY_w,                  spawn,          {.v = browsercmd} },
	/* yazi: $mod Y → foot -e yazi */
	{ MODKEY,                    XKB_KEY_y,                  spawn,          SHCMD("foot -e yazi") },

	/* ── Focus / Stack ──────────────────────────────────────────────────────── */
	{ MODKEY,                    XKB_KEY_j,                  focusstack,     {.i = +1} },
	{ MODKEY,                    XKB_KEY_k,                  focusstack,     {.i = -1} },
	{ MODKEY,                    XKB_KEY_i,                  incnmaster,     {.i = +1} },
	{ MODKEY,                    XKB_KEY_d,                  incnmaster,     {.i = -1} },
	{ MODKEY,                    XKB_KEY_h,                  setmfact,       {.f = -0.05f} },
	{ MODKEY,                    XKB_KEY_l,                  setmfact,       {.f = +0.05f} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Return,             zoom,           {0} },
	{ MODKEY,                    XKB_KEY_Tab,                view,           {0} },

	/* ── Window management ──────────────────────────────────────────────────── */
	{ MODKEY,                    XKB_KEY_q,                  killclient,     {0} },   /* $mod Q */
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_V,                  togglefloating, {0} },   /* $mod SHIFT V → was $mod V */
	{ MODKEY,                    XKB_KEY_e,                  togglefullscreen, {0} }, /* matches your $mod F */
	/* NOTE: $mod F is now setlayout floating; use $mod E for fullscreen (as above) */

	/* ── Layouts ────────────────────────────────────────────────────────────── */
	{ MODKEY,                    XKB_KEY_t,                  setlayout,      {.v = &layouts[0]} }, /* tile */
	{ MODKEY,                    XKB_KEY_f,                  setlayout,      {.v = &layouts[1]} }, /* float */
	{ MODKEY,                    XKB_KEY_m,                  setlayout,      {.v = &layouts[2]} }, /* monocle */
	{ MODKEY,                    XKB_KEY_space,              setlayout,      {0} },                /* toggle last two */
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_space,              togglefloating, {0} },

	/* ── Show all tags / move to all ────────────────────────────────────────── */
	{ MODKEY,                    XKB_KEY_0,                  view,           {.ui = ~0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_parenright,         tag,            {.ui = ~0} },

	/* ── Monitor focus / tag to monitor ─────────────────────────────────────── */
	{ MODKEY,                    XKB_KEY_comma,              focusmon,       {.i = WLR_DIRECTION_LEFT} },
	{ MODKEY,                    XKB_KEY_period,             focusmon,       {.i = WLR_DIRECTION_RIGHT} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_less,               tagmon,         {.i = WLR_DIRECTION_LEFT} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_greater,            tagmon,         {.i = WLR_DIRECTION_RIGHT} },

	/* ── Tags 1–9 ───────────────────────────────────────────────────────────── */
	TAGKEYS(          XKB_KEY_1, XKB_KEY_exclam,       0),
	TAGKEYS(          XKB_KEY_2, XKB_KEY_at,           1),
	TAGKEYS(          XKB_KEY_3, XKB_KEY_numbersign,   2),
	TAGKEYS(          XKB_KEY_4, XKB_KEY_dollar,       3),
	TAGKEYS(          XKB_KEY_5, XKB_KEY_percent,      4),
	TAGKEYS(          XKB_KEY_6, XKB_KEY_asciicircum,  5),
	TAGKEYS(          XKB_KEY_7, XKB_KEY_ampersand,    6),
	TAGKEYS(          XKB_KEY_8, XKB_KEY_asterisk,     7),
	TAGKEYS(          XKB_KEY_9, XKB_KEY_parenleft,    8),

	/* ── Session ────────────────────────────────────────────────────────────── */
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Q,                  quit,           {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_L,                  spawn,          {.v = lockcmd} }, /* $mod SHIFT L → swaylock */
	{ WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT, XKB_KEY_Terminate_Server, quit,    {0} },

	/* ── Screenshot ($mod SHIFT Print → save; Print → area) ─────────────────── */
	{ 0,                         XKB_KEY_Print,              spawn,          SHCMD("grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png") },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Print,              spawn,          SHCMD("grim ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png") },

	/* ── Volume (XF86 keys) ──────────────────────────────────────────────────── */
	{ 0, XKB_KEY_XF86AudioRaiseVolume,  spawn, {.v = vol_up} },
	{ 0, XKB_KEY_XF86AudioLowerVolume,  spawn, {.v = vol_down} },
	{ 0, XKB_KEY_XF86AudioMute,         spawn, {.v = vol_mute} },
	{ 0, XKB_KEY_XF86AudioMicMute,      spawn, {.v = mic_mute} },

	/* ── Brightness ──────────────────────────────────────────────────────────── */
	{ 0, XKB_KEY_XF86MonBrightnessUp,   spawn, {.v = br_up} },
	{ 0, XKB_KEY_XF86MonBrightnessDown, spawn, {.v = br_down} },

	/* ── Media ───────────────────────────────────────────────────────────────── */
	{ 0, XKB_KEY_XF86AudioPlay,         spawn, {.v = media_pp} },
	{ 0, XKB_KEY_XF86AudioPause,        spawn, {.v = media_pp} },
	{ 0, XKB_KEY_XF86AudioNext,         spawn, {.v = media_next} },
	{ 0, XKB_KEY_XF86AudioPrev,         spawn, {.v = media_prev} },

	/* ── VT switching (don't remove!) ───────────────────────────────────────── */
#define CHVT(n) { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_XF86Switch_VT_##n, chvt, {.ui = (n)} }
	CHVT(1), CHVT(2), CHVT(3), CHVT(4), CHVT(5), CHVT(6),
	CHVT(7), CHVT(8), CHVT(9), CHVT(10), CHVT(11), CHVT(12),
};

static const Button buttons[] = {
	{ MODKEY, BTN_LEFT,   moveresize,     {.ui = CurMove} },   /* $mod mouse:272 */
	{ MODKEY, BTN_MIDDLE, togglefloating, {0} },
	{ MODKEY, BTN_RIGHT,  moveresize,     {.ui = CurResize} }, /* $mod mouse:273 */
};
