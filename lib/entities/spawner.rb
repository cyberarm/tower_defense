module TowerDefense
  module Entities
    class Spawner < Entity
      def setup
        @late_inited = false
      end

      def late_init
        @grid.update_edge_nodes

        @start_node = @grid.node_at(0, 9)
        @goal_nodes = [@grid.node_at(38, 7), @grid.node_at(38, 11)]
        @flow_field = CyberarmEngine::Pathfinding::BreadthFirstSearch.search(graph: @grid, start: @start_node)

        @spawn_interval = 1_000
        @last_spawn_interval = 0

        @late_inited = true
      end

      def draw
        Gosu.rotate(@position.w, @position.x, @position.y) do
          Gosu.draw_circle(@position.x, @position.y, 8, 5, @color, @position.z)
        end
      end

      def fixed_update(dt)
        late_init unless @late_inited

        @position.w += 1.0

        if @level.enemies_remaining.positive? && Gosu.milliseconds - @last_spawn_interval >= @spawn_interval
          @last_spawn_interval = Gosu.milliseconds

          @level.entities << BigTriangle.new(
                                              x: @position.x - HALF_TILE_SIZE,
                                              y: @position.y - HALF_TILE_SIZE,
                                              path: spawner_path,
                                              level: @level
                                            )

          @level.enemies_remaining -= 1
        end
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
