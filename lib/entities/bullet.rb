module TowerDefense
  module Entities
    class Bullet < Entity
      def setup
        @speed = 2
      end

      def draw
        Gosu.rotate(@position.w, @position.x, @position.y) do
          Gosu.draw_circle(@position.x, @position.y, 8, 5, @color, @position.z)
        end
      end

      def fixed_update(dt)
        # FIXME: snap to target
        # @position.w += 1.0
      end
    end
  end
end
