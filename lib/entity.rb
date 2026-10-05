module TowerDefense
  class Entity
    TILE_SIZE = Level::TILE_SIZE
    HALF_TILE_SIZE = TILE_SIZE / 2

    attr_reader :position, :cost

    def initialize(options = {})
      @options = options
      @level = @options[:level]
      @grid = @options[:grid]
      @path = @options[:path] || []
      @position = CyberarmEngine::Vector.new(@options[:x] + HALF_TILE_SIZE, @options[:y] + HALF_TILE_SIZE, 0, 90)
      @color = @options[:color] || Gosu::Color::WHITE
      @body_color = @options[:body_color] || Gosu::Color::RED

      setup
    end

    def setup
    end

    def draw
    end

    def placable_draw
    end

    def fixed_update(dt)
    end

    def grid_cell
      CyberarmEngine::Vector.new(
        (@position.x / TILE_SIZE),
        (@position.y / TILE_SIZE)
      )
    end
  end
end
