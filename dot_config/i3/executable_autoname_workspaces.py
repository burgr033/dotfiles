# -*- coding: utf-8 -*-

# This script listens for i3 events and updates workspace names to show icons
# for running programs.  It contains icons for a few programs, but more can
# easily be added by inserting them into WINDOW_ICONS below.
#
# Dependencies
# * xorg-xprop - install through system package manager
# * i3ipc - install with pip


import i3ipc
import subprocess as proc
import re
import signal
import sys


# Add icons here for common programs you use.  The keys are the X window class
# (WM_CLASS) names and the icons can be any text you want to display. However
# most of these are character codes for font awesome:
#   http://fortawesome.github.io/Font-Awesome/icons/
MDI_TERMINAL = 	'󰆍 '
MDI_CHROME = 	'󰊯 '
MDI_FIREFOX = 	'󰈹 '
MDI_CODE = 	'󰨞 '
MDI_EDITOR = 	'󱞂 '
MDI_SPOTIFY = 	'󰓇 '
MDI_PICTURE = 	'󰋩 '
MDI_PDF = 	'󰂾 '
MDI_FILES = 	'󰷏 '
MDI_PACK = 	'󰀼 '
MDI_VIM = 	'󰘦 '
MDI_BROWSER = '󰖟 '
MDI_SECURE = 	'󰌿 '
MDI_VOLUME = 	'󰕾 '
MDI_VIDEO = 	'󰕼 '
MDI_EMAIL = 	'󰻤 '
MDI_REMOTE = 	'󰢹 '
MDI_STEAM = 	'󰓓 '
MDI_CALENDAR = 	'󰃭 '
MDI_GO       =  ' '
MDI_SLACK = 	'󰒱 '
MDI_CHAT = 	'󰻞 '
MDI_TOOLBOX = '󰦬 '
MDI_SIGNAL = 	'󰻞 '
MDI_LISTEN = 	'󰋋 '
MDI_PODCAST = 	'󰦔 '
MDI_PAINT = 	'󰽉 '
MDI_TEAMS = 	'󰊻 '
MDI_MANJARO = 	' '
MDI_NORMAL = 	'󰘔 '
 
WINDOW_ICONS = {
    'jetbrains-toolbox': MDI_TOOLBOX,
    'urxvt': MDI_TERMINAL,
    'firefox': MDI_FIREFOX,
    'Alacritty': MDI_TERMINAL,
    'steam': MDI_STEAM,
    'qutebrowser': MDI_BROWSER,
    'ncspot': MDI_SPOTIFY,
    'obsidian': MDI_EDITOR,
    'khal': MDI_CALENDAR,
    'pocket-casts': MDI_PODCAST,
    'feh': MDI_PICTURE,
    'zathura': MDI_PDF,
    'ranger': MDI_FILES,
    'vim': MDI_VIM,
    'jetbrains-goland': MDI_GO,
    'subl': MDI_EDITOR,
    'gvim': MDI_VIM,
    'nvim': MDI_VIM,
    'signal': MDI_SIGNAL,
    'pamac-manager': MDI_MANJARO,
    'neovim': MDI_VIM,
    'lxappearance': MDI_PAINT,
    'Enpass' : MDI_SECURE,
    'Bitwarden' : MDI_SECURE,
    'Microsoft Teams' : MDI_TEAMS,
    'Pavucontrol' : MDI_VOLUME,
    'vlc' : MDI_VIDEO,
    'mpv' : MDI_VIDEO,
    'feh' : MDI_PICTURE,
    'microsoft teams - preview': MDI_TEAMS,
    'geary' : MDI_EMAIL,
    'aerc' : MDI_EMAIL,
    'slack' : MDI_SLACK
}

i3 = i3ipc.Connection()

# Returns an array of the values for the given property from xprop.  This
# requires xorg-xprop to be installed.
def xprop(win_id, property):
    try:
        prop = proc.check_output(['xprop', '-id', str(win_id), property], stderr=proc.DEVNULL)
        prop = prop.decode('utf-8')
        return re.findall('"([^"]+)"', prop)
    except proc.CalledProcessError:
        print("Unable to get property for window '%s'" % str(win_id))
        return None

def icon_for_window(window):
    classes = xprop(window.window, 'WM_CLASS')
    if classes != None and len(classes) > 0:
        for cls in classes:
            if cls in WINDOW_ICONS:
                return WINDOW_ICONS[cls]
    print('No icon available for window with classes: %s' % str(classes))
    return MDI_NORMAL

# renames all workspaces based on the windows present
def rename():
    for workspace in i3.get_tree().workspaces():
        icons = [icon_for_window(w) for w in workspace.leaves()]
        icon_str = ' ' + ''.join(icons) if len(icons) else ''
        new_name = str(workspace.num) + icon_str
        i3.command('rename workspace "%s" to "%s"' % (workspace.name, new_name))

rename()

# exit gracefully when ctrl+c is pressed
def signal_handler(signal, frame):
    # rename workspaces to just numbers on exit to indicate that this script is
    # no longer running
    for workspace in i3.get_tree().workspaces():
        i3.command('rename workspace "%s" to "%d"' % (workspace.name, workspace.num))
    i3.main_quit()
    sys.exit(0)
signal.signal(signal.SIGINT, signal_handler)

# call rename() for relevant window events
def on_change(i3, e):
    if e.change in ['new', 'close', 'move']:
        rename()
i3.on('window', on_change)
i3.main()
