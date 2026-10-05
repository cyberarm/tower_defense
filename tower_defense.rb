begin
  require_relative "../cyberarm_engine/lib/cyberarm_engine"
rescue LoadError
  require "cyberarm_engine"
end

require_relative "lib/version"
require_relative "lib/theme"
require_relative "lib/level"
require_relative "lib/window"
require_relative "lib/states/main_menu"
require_relative "lib/states/game"

require_relative "lib/entity"
require_relative "lib/entities/spawner"
require_relative "lib/entities/big_triangle"
require_relative "lib/entities/turret"
require_relative "lib/entities/bullet"

TowerDefense::Window.new(width: 1280, height: 800, resizable: true).show
