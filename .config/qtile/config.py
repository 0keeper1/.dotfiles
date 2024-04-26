from libqtile import bar, layout, qtile, widget, hook, extension
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal, send_notification

from pathlib import Path

# COLORS
class Colors():
    BLACK = "#000000"  # BLACK
    CBlack = "#111111" # ^
    OSpace = "#444444" # ^
    GGray = "#666666"  # v
    SGray = "#999999"  # v
    WHITE = "#ffffff"  # WHITE

# DEFAULT
TERMINAL = "alacritty"
MOD = "mod4"
WALLPAPER_PATH = "/home/mahan/Pictures/dark/"
HOME = str(Path.home())
EDITOR = "emacs"
BROWSER = "firefox"

# SETTINGS
follow_mouse_focus = True
focus_on_window_activation = "smart"
wmname = "LG3D"
cursor_warp = True
auto_fullscreen = True
reconfigure_screens = False

# LAYOUTS
LAYOUTS_CFG = {
    "border_focus": Colors.SGray,
    "border_normal": Colors.GGray,
    "border_width": 2,
    "margin": 4,
}

layouts = [
    layout.Max(**LAYOUTS_CFG),
    layout.Stack(**LAYOUTS_CFG, fair=True),
    layout.MonadTall(**LAYOUTS_CFG)
]


_float_rules = [
    Match(wm_class="confirmreset"),  # gitk
    Match(wm_class='dialog'),  # Dialogs stuff
    Match(wm_class="makebranch"),  # gitk
    Match(wm_class="maketag"),  # gitk
    Match(wm_class="error"),
    Match(wm_class="ssh-askpass"),  # ssh-askpass
    Match(title="branchdialog"),  # gitk
    Match(title="pinentry"),  # GPG key password entry
].extend(layout.Floating.default_float_rules)


# SCREENS
SCREENS_CFG = {
    "wallpaper": "/home/mahan/Pictures/dark/1066490.jpg",
    "wallpaper_mode": "fill",
}

screens = [
    Screen(wallpaper=SCREENS_CFG["wallpaper"], wallpaper_mode=SCREENS_CFG["wallpaper_mode"],),
    Screen(
        wallpaper=SCREENS_CFG["wallpaper"],
        wallpaper_mode=SCREENS_CFG["wallpaper_mode"],
        bottom=bar.Bar(
            [
                widget.Clock(format='%d/%m/%y %H:%M', foreground=Colors.WHITE),
                widget.Spacer(),
                widget.CPUGraph(type="box", frequency=60, graph_color=Colors.WHITE, border_width=1, border_color=Colors.GGray),
                widget.MemoryGraph(type="box", frequency=60, graph_color=Colors.WHITE, border_width=1, border_color=Colors.GGray),
            ],
            margin=[6, 6, 0, 6],
            size=20,
            background=Colors.BLACK,
            opacity=0.75,
        )
    ),
]

# GROUPS

groups = [
    Group("1", label="EDITOR", matches=[Match(wm_class="emacs")], layout="max", spawn=qtile.spawn(EDITOR), screen_affinity=1),
    Group("2", label="BROWSER", matches=[Match(wm_class="firefox")], layout="max", spawn=qtile.spawn(BROWSER), screen_affinity=1),
    Group("3", label="BOOK", layout="max", screen_affinity=0),
    Group("4", label="SOCIAL", screen_affinity=0)
]

# KEYS
keys = [
    Key([MOD, "shift"], "r", lazy.reload_config(), desc="reload the config"),
    Key([MOD, "shift"], "e", lazy.next_screen(), desc="to loptop screen"),
    Key([MOD, "shift"], "q", lazy.next_layout(), desc="to  layout"),

    # Layout
    Key([MOD, "shift"], "left", lazy.layout.left(), desc="move focus on left window"),
    Key([MOD, "shift"], "right", lazy.layout.right(), desc="move focus on right window"),
    Key([MOD, "shift"], "down", lazy.layout.down(), desc="move focus on down window"),
    Key([MOD, "shift"], "up", lazy.layout.up(), desc="move focus on up window"),

    # CMD
    Key([MOD], 'm', lazy.run_extension(extension.DmenuRun(
        dmenu_lines=4,
        dmenu_prompt="~>",
        background=Colors.BLACK,
        dmenu_bottom=True,
        dmenu_ignorecase=True,
        selected_background=Colors.OSpace,
        foreground=Colors.GGray,
        selected_foreground=Colors.WHITE,
    ))),
    Key([MOD], "t", lazy.spawn(TERMINAL), desc="launch terminal")
]


for i in groups:
    keys.extend(
        [
            Key(
                [MOD],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [MOD, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )


# HOOKS
@hook.subscribe.startup
def _() -> None:
    from subprocess import call as sh_run
    sh_run(HOME + "/.config/qtile/autostart.sh")


@hook.subscribe.layout_change
def _(layout, group) -> None:
    send_notification("Qtile", f"{group.label}: Layout changed to {layout.name}")
