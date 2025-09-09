local wezterm = require 'wezterm'
local config = {}

-- Thème
config.color_scheme = 'Tokyo Night Storm'

-- Configuration fenêtre (version corrigée)
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

-- Souris 
-- config.enable_mouse = true

-- Thème principal
config.color_scheme = 'Tokyo Night Storm'

-- Pas d'image de fond

-- Pas de transparence, seulement l'image de fond
config.window_background_opacity = 1.0
config.text_background_opacity = 1.0

-- Police et apparence
config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })
config.font_size = 12
config.line_height = 1.2

-- Onglets stylisés
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false

-- Performances
config.front_end = "WebGpu"
config.animation_fps = 60
config.max_fps = 120

-- Configuration pour améliorer la copie avec tmux
config.mouse_bindings = {
  -- Clic droit pour coller
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
}

-- Raccourcis clavier pour la copie/colle
config.keys = {
  -- Copie sélection avec Cmd+C (macOS)
  {
    key = 'c',
    mods = 'CMD',
    action = wezterm.action.CopyTo 'Clipboard',
  },
  -- Colle avec Cmd+V (macOS)
  {
    key = 'v',
    mods = 'CMD',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
}

-- Mode de sélection amélioré
config.selection_word_boundary = ' \t\n{}[]()"\'`'

return config


