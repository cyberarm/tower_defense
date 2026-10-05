module TowerDefense
  module Entities
    class Turret < Entity
      def setup
        @color = 0xff_26a269
        @gun_color = 0xff_9a9996
        @laser_color = 0x88_8ff0a4
        @body_color = 0xff_77767b

        # Lazy way to ensure the lazer is drawn on top of Big Triangle
        @position.z = 10

        @range = TILE_SIZE * 4
        @target = nil
        @damage = 22

        @overheat_time = 3
        @cooldown_time = @overheat_time + 1.5

        @temp = 0
        @max_temp = 1.0
        @overheating = false
      end

      def draw
        # base
        Gosu.draw_circle(@position.x, @position.y, HALF_TILE_SIZE * 0.8, 36, @color, @position.z)

        Gosu.rotate(@position.w, @position.x, @position.y) do
          # laser
          if @target && !@overheating
            Gosu.draw_rect(@position.x - 1, @position.y, 2, @target.position.distance(@position), @laser_color, @position.z)
          end
          # gun
          Gosu.draw_rect(@position.x - 3, @position.y, 6, HALF_TILE_SIZE * 1.25, @gun_color, @position.z)
          # hatch
          Gosu.draw_circle(@position.x, @position.y, HALF_TILE_SIZE / 2, 36, @body_color, @position.z)
          Gosu.draw_circle(@position.x, @position.y, HALF_TILE_SIZE * 0.25, 6, @gun_color, @position.z)
        end
      end

      def placable_draw
        Gosu.draw_arc(@position.x, @position.y, @range, 1.0, 128, 1, Gosu::Color::RED, @position.z)
      end

      def fixed_update(dt)
        # FIXME: snap to target
        unless target_valid?
          @target = find_target
        end

        return unless @target

        target_normal = (@target.position - @position).normalized
        @position.w = Gosu.angle(@target.position.x, @target.position.y, @position.x, @position.y)

        # Don't look at me, I'm tired 🥱
        if @overheating
          @temp -= @cooldown_time * dt
          @overheating = false if @temp <= 0
          @temp = 0 if @temp.negative?
        else
          @temp += @overheat_time * dt
          @target.health -= @damage * dt
          @overheating = true if @temp >= @max_temp
        end

        @temp = @temp.clamp(0, @max_temp)
      end

      def find_target
        @level.entities.select { |e| e.is_a?(BigTriangle) }.select { |e| target_valid?(e) }.sample
      end

      def target_valid?(target = @target)
        return false unless target

        target.health.positive? && target.position.distance(@position) <= @range
      end
    end
  end
end
