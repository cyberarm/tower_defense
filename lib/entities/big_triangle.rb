module TowerDefense
  module Entities
    class BigTriangle < Entity
      def setup
        @size = TowerDefense::Level::TILE_SIZE * 0.75
        @half_size = @size / 2
        @speed = 0.5
      end

      def draw
        # @path.each do |node|
          # Gosu.draw_rect(node.x * TILE_SIZE, node.y * TILE_SIZE, TILE_SIZE, TILE_SIZE, 0x22_ffffff, @position.z)
        # end

        Gosu.rotate(@position.w, @position.x, @position.y) do
          Gosu.draw_triangle(
            @position.x, @position.y - @half_size, @color,
            @position.x + @half_size, @position.y + @half_size, @body_color,
            @position.x - @half_size, @position.y + @half_size, @body_color,
            @position.z
          )

          Gosu.draw_rect(@position.x - 1, @position.y - 1, 2, 2, Gosu::Color::WHITE, @position.z)
        end
      end

      def fixed_update(dt)
        target_node = @path.first
        unless target_node
          # TODO: Explode and damage city
          @level.city_health -= 10
          @level.entities.delete(self)
          return
        end

        the_grid_cell = grid_cell
        cell_position = CyberarmEngine::Vector.new(target_node.x + 0.5, target_node.y + 0.5)
        if the_grid_cell.distance(cell_position) < 0.05
          @path.shift
          return
        end

        target_normal = (cell_position - the_grid_cell).normalized
        @position.w = Gosu.angle(the_grid_cell.x, the_grid_cell.y, cell_position.x, cell_position.y)

        @position.x += target_normal.x * @speed
        @position.y += target_normal.y * @speed
      end

      def spawner_path
        nodes = []

        target_node = @goal_nodes.rotate!.first
        nodes << target_node
        while (node = @flow_field[target_node.key])
          target_node = node
          nodes << node

          break if target_node == @start_node
        end

        nodes.reverse
      end
    end
  end
end
