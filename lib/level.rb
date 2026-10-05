module TowerDefense
  class Level
    TILE_SIZE = 32
    HALF_TILE_SIZE = TILE_SIZE / 2

    # extract tile types from image colors
    TILE_TYPES = {
      ground: 0xff_ffffff,
      permanent_wall: 0xff_000000,
      spawner: 0xff_ff0000,
      town: 0xff_00ff00,
      wall: 0xff_ff00ff,
      turret: 0xff_0000ff,
      cannon: 0xff_00ffff
    }

    # presentation colors
    TILE_COLORS = {
      ground: 0xff_986a44,
      permanent_wall: 0xff_865e3c,
      spawner: 0xff_986a44,
      town: 0xff_26a269,
      wall: 0x5e5c64,
      turret: 0xff_a51d2d,
      cannon: 0xff_613583
    }

    attr_reader :width, :height, :entities, :max_city_health
    attr_accessor :city_health, :enemies_killed, :credits

    def initialize(map_image:)
      @entities = []
      @pathfinding_grid = CyberarmEngine::Pathfinding::Grid.new

      @credits = 0
      @enemies_killed = 0
      @city_health = 100

      @tiles = []
      @width = map_image.width
      @height = map_image.height

      x = 0
      y = 0
      bytes = map_image.to_blob.unpack("C*")
      bytes.each_slice(4) do |rgba|
        argb = rgba.rotate(-1)
        color = argb.pack("C4").unpack1("N")

        if x == @width
          x = 0
          y += 1
        end

        TILE_TYPES.each do |type, col|
          if color == col
            case type
            when :spawner
              @entities << Entities::Spawner.new(level: self, grid: @pathfinding_grid, x: x * TILE_SIZE, y: y * TILE_SIZE)
              @tiles << :ground
            when :turret
              @entities << Entities::Turret.new(level: self, x: x * TILE_SIZE, y: y * TILE_SIZE)
              @tiles << :permanent_wall
            else
              @tiles << type
            end
            @pathfinding_grid.add_node(x: x, y: y) if type == :ground || type == :spawner
            break
          end
        end

        x += 1
      end
    end

    def draw_map
      x = 0
      y = 0

      @tiles.each do |tile|
        if x == @width
          x = 0
          y += 1
        end

        Gosu.draw_rect(x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE, TILE_COLORS[tile])

        x += 1
      end

      @entities.each(&:draw)
    end

    def fixed_update(dt)
      @entities.each { |e| e.fixed_update(dt) }
    end

    def map_width
      TILE_SIZE * @width
    end

    def map_height
      TILE_SIZE * @height
    end

    def scale(window_width, window_height)
      window_width / map_width.to_f
    end

    def tile_type_at(x:, y:)
      index = y * width + x

      return nil if index.negative?
      return nil if index >= @tiles.size

      @tiles[index]
    end
  end
end
