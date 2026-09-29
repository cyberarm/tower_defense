require_relative "../cyberarm_engine/lib/cyberarm_engine"

require_relative "lib/version"
require_relative "lib/theme"
require_relative "lib/level"
require_relative "lib/window"
require_relative "lib/states/main_menu"
require_relative "lib/states/game"

TowerDefense::Window.new(width: 1280, height: 800, resizable: true).show
