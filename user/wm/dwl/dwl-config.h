/* dwl - dwm for Wayland
 * Configuration file template based on your Hyprland setup
 * Adapt this to your needs
 */

/* appearance */
static const int sloppyfocus = 1;  /* focus follows mouse */
static const int bypass_surface_visibility = 0;  /* 1 means no input is sent to windows behind fullscreen window */
static const unsigned int borderpx = 1;  /* border pixel of windows */
static const float rootcolor[] = {0.3, 0.3, 0.3, 1.0};  /* background color */
static const float bordercolor[] = {0.5, 0.5, 0.5, 1.0};  /* unfocused window border */
static const float focuscolor[] = {1.0, 1.0, 1.0, 1.0};  /* focused window border */
static const float urgentcolor[] = {1.0, 0.0, 0.0, 1.0};  /* urgent window border */

/* Autostart */
static const char *const autostart[] = {
	"swaybg", "-i", "/home/user/.config/wallpaper.png", NULL,
	"swaynotificationcenter", NULL,
	"fcitx5", "-d", "--replace", NULL,
	NULL /* terminate */
};

/* tagging - workspace names */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* app_id             title       tags mask   isfloating   monitor */
	/* examples:
	{ "Gimp",            NULL,       0,          1,           -1 },
	{ "firefox",         NULL,       1 << 8,     0,           -1 },
	*/
	/* Transparency rules (similar to your Hyprland windowrulev2) */
	{ "foot",            NULL,       0,          0,           -1 },
	{ "kitty",           NULL,       0,          0,           -1 },
};

/* layout(s) */
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

static const Layout *const layouts_end = layouts + LENGTH(layouts);

/* monitors
 * The order in which monitors *appear* here is the default order of tags assignment to monitors.
 */
static const MonitorRule monrules[] = {
	/* name       mfact nmaster scale layout  rotate/reflect */
	/* example of a HiDPI laptop monitor:
	{ "eDP-1",   0.55,  1,      2,     &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL },
	*/
	/* Adapt to your monitor setup */
	{ NULL,       0.55,  1,      1,     &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL },
};

/* keyboard */
static const struct xkb_rule_names xkb_rules = {
	/* can specify fields: rules, model, layout, variant, options */
	.options = "ctrl:nocaps",  /* remaps Caps Lock to Ctrl */
};

static const int repeat_rate = 50;
static const int repeat_delay = 300;

/* Cursor */
static const char *cursor_theme = "default";
static const int cursor_size = 24;

/* IMPORTANT: You need to define keys and buttons below */
#define MODKEY WLR_MODIFIER_SUPER
#define TAGKEYS(KEY,SKEY,TAG) \
	{ MODKEY,                    KEY,  view,            {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_SHIFT, SKEY, tag,             {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL,  KEY,  toggletag,       {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL|WLR_MODIFIER_SHIFT, SKEY, toggleview, {.ui = 1 << TAG} }

/* key definitions can be used as arguments to TAGKEYS */
#define TAGKEYS_1 XKB_KEY_1
#define TAGKEYS_2 XKB_KEY_2
#define TAGKEYS_3 XKB_KEY_3
#define TAGKEYS_4 XKB_KEY_4
#define TAGKEYS_5 XKB_KEY_5
#define TAGKEYS_6 XKB_KEY_6
#define TAGKEYS_7 XKB_KEY_7
#define TAGKEYS_8 XKB_KEY_8
#define TAGKEYS_9 XKB_KEY_9

static const Key keys[] = {
	/* modifier                  key                 function        argument */
	
	/* Applications */
	{ MODKEY,                    XKB_KEY_Return,     spawn,          {.v = (const char*[]){ "foot", NULL } } },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Return,     spawn,          {.v = (const char*[]){ "kitty", NULL } } },
	{ MODKEY,                    XKB_KEY_d,          spawn,          {.v = (const char*[]){ "wmenu", NULL } } },
	{ MODKEY,                    XKB_KEY_w,          spawn,          {.v = (const char*[]){ "firefox", NULL } } },
	{ MODKEY,                    XKB_KEY_y,          spawn,          {.v = (const char*[]){ "foot", "yazi", NULL } } },
	
	/* Window management */
	{ MODKEY,                    XKB_KEY_q,          killclient,     {0} },
	{ MODKEY,                    XKB_KEY_f,          fullscreen,     {0} },
	{ MODKEY,                    XKB_KEY_v,          togglefloating, {0} },
	
	/* Focus movement (hjkl) */
	{ MODKEY,                    XKB_KEY_h,          focusmon,       {.i = WLR_DIRECTION_LEFT} },
	{ MODKEY,                    XKB_KEY_l,          focusmon,       {.i = WLR_DIRECTION_RIGHT} },
	{ MODKEY,                    XKB_KEY_k,          focusmon,       {.i = WLR_DIRECTION_UP} },
	{ MODKEY,                    XKB_KEY_j,          focusmon,       {.i = WLR_DIRECTION_DOWN} },
	
	/* Focus windows in tiled layout */
	/* You may want to use focusstack instead - check dwl docs */
	
	/* Layout switching */
	{ MODKEY,                    XKB_KEY_t,          setlayout,      {.v = &layouts[0]} },  /* tile */
	{ MODKEY,                    XKB_KEY_f,          setlayout,      {.v = &layouts[1]} },  /* floating */
	{ MODKEY,                    XKB_KEY_m,          setlayout,      {.v = &layouts[2]} },  /* monocle */
	
	/* Tag/Workspace switching */
	TAGKEYS(XKB_KEY_1, XKB_KEY_exclam, 0),
	TAGKEYS(XKB_KEY_2, XKB_KEY_at, 1),
	TAGKEYS(XKB_KEY_3, XKB_KEY_numbersign, 2),
	TAGKEYS(XKB_KEY_4, XKB_KEY_dollar, 3),
	TAGKEYS(XKB_KEY_5, XKB_KEY_percent, 4),
	TAGKEYS(XKB_KEY_6, XKB_KEY_asciicircum, 5),
	TAGKEYS(XKB_KEY_7, XKB_KEY_ampersand, 6),
	TAGKEYS(XKB_KEY_8, XKB_KEY_asterisk, 7),
	TAGKEYS(XKB_KEY_9, XKB_KEY_parenleft, 8),
	
	/* Screenshots (using grim/slurp) */
	{ 0,                         XKB_KEY_Print,      spawn,          {.v = (const char*[]){ "grim", "-g", "$(slurp)", "/tmp/screenshot.png", NULL } } },
	{ WLR_MODIFIER_SHIFT,        XKB_KEY_Print,      spawn,          {.v = (const char*[]){ "grim", "/tmp/screenshot.png", NULL } } },
	
	/* System/Media keys */
	{ 0,                         XKB_KEY_XF86AudioRaiseVolume, spawn, {.v = (const char*[]){ "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+", NULL } } },
	{ 0,                         XKB_KEY_XF86AudioLowerVolume, spawn, {.v = (const char*[]){ "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-", NULL } } },
	{ 0,                         XKB_KEY_XF86AudioMute,        spawn, {.v = (const char*[]){ "wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle", NULL } } },
	{ 0,                         XKB_KEY_XF86AudioMicMute,     spawn, {.v = (const char*[]){ "wpctl", "set-mute", "@DEFAULT_AUDIO_SOURCE@", "toggle", NULL } } },
	
	{ 0,                         XKB_KEY_XF86MonBrightnessUp,   spawn, {.v = (const char*[]){ "brightnessctl", "set", "5%+", NULL } } },
	{ 0,                         XKB_KEY_XF86MonBrightnessDown, spawn, {.v = (const char*[]){ "brightnessctl", "set", "5%-", NULL } } },
	
	{ 0,                         XKB_KEY_XF86AudioPlay,  spawn, {.v = (const char*[]){ "playerctl", "play-pause", NULL } } },
	{ 0,                         XKB_KEY_XF86AudioPause, spawn, {.v = (const char*[]){ "playerctl", "play-pause", NULL } } },
	{ 0,                         XKB_KEY_XF86AudioNext,  spawn, {.v = (const char*[]){ "playerctl", "next", NULL } } },
	{ 0,                         XKB_KEY_XF86AudioPrev,  spawn, {.v = (const char*[]){ "playerctl", "previous", NULL } } },
	
	/* Lock screen */
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_l,          spawn,          {.v = (const char*[]){ "swaylock", NULL } } },
	
	/* Quit dwl cleanly */
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_e,          quit,           {0} },
};

static const Button buttons[] = {
	{ MODKEY, BTN_LEFT,   moveresize,     {.i = CurMove} },
	{ MODKEY, BTN_RIGHT,  moveresize,     {.i = CurResize} },
};
