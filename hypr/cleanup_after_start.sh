#!/bin/sh
# Hyprland 0.48+: anonymous windowrule uses match:class (old "workspace unset,class:foo" removed)
hyprctl keyword windowrule "workspace unset, match:class librewolf" 2>/dev/null
hyprctl keyword windowrule "workspace unset, match:class com.mitchellh.ghostty" 2>/dev/null
hyprctl keyword windowrule "workspace unset, match:class ghostty" 2>/dev/null
hyprctl keyword windowrule "workspace unset, match:class discord" 2>/dev/null
