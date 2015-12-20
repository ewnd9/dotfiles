run_once("wmname", "wmname", "LG3D") -- java fix
run_once("unity-settings-daemon")
run_once("google-chrome", "chrome")

run_once("telegram")
run_once("guake", "--exec='/home/ewnd9/dotfiles/scripts/twitter.tmux'")
run_once("nm-applet") -- networkingos.execute("/usr/bin/run_once indicator-cpufreq")
run_once("indicator-cpufreq", "indicator-cpufr")

run_once("setxkbmap", "setxkbmap", "-layout 'us,ru' -option '' -option 'grp:alt_shift_toggle' -option 'caps:none'")
run_once("dropbox", "dropbox", "start")

run_once("xmodmap", "~/.Xmodmap") -- caps lock to delete
run_once("synclient", "TapButton3=2") -- middle mouse button on triple touch pad

run_once("xavier", "Xavier")
run_once("/home/ewnd9/soft/copy/x86_64/CopyAgent", "CopyAgent")

run_once("somebar")
run_once("/home/ewnd9/.npm-packages/bin/workout --test", "workout")

run_once("rescuetime")
run_once("gnome-terminal", "gnome-terminal", "-e '/home/ewnd9/dotfiles/scripts/weechat.tmux'")
run_once("albert")
