module TowerDefense
  class Level
    TILE_SIZE = 32
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

    attr_reader :width, :height

    def initialize(map_image:)
      @tiles = []
      @width = map_image.width
      @height = map_image.height

      bytes = map_image.to_blob.unpack("C*")
      bytes.each_slice(4) do |rgba|
        argb = rgba.rotate(-1)
        color = argb.pack("C4").unpack1("N")

        TILE_TYPES.each do |type, col|
          if color == col
            @tiles << type
            break
          end
        end
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
  end
end
