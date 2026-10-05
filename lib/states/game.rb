module TowerDefense
  module States
    class Game < CyberarmEngine::GuiState
      def setup
        theme(THEME)

        stack(width: 1.0, height: 1.0) do
          stack(width: 1.0, margin: LARGE_PADDING, padding: LARGE_PADDING, style_class: [:rounded_box], background_nine_slice_color: 0xff_63452c) do
            # info bar
            flow(width: 0.5, h_align: :center, style_class: [:rounded_box], background_nine_slice_color: 0x11_cdab8f, padding: PADDING) do
              @credits_label = tagline "Credits: ?"
              flow(fill: true)
              @enemies_label = tagline "Enemies: ?"
              flow(fill: true)
              @city_health_label = tagline "City Health: ?"
            end

            # tool bar
            flow(width: 0.5, h_align: :center, margin_top: LARGE_PADDING) do
              flow(fill: true)
              # button "Wall", margin_left: PADDING, enabled: false, tip: "$100 • Block enemy path"
              button "Turret", margin_left: PADDING, enabled: false, tip: "$1 000 • Cut down enemies"
              # button "Cannon", margin_left: PADDING, enabled: false, tip: "$10 000 • Mow down enemies"
              button "Sell", margin_left: MASSIVE_PADDING, tip: "Sell item for 100% of its original value"
              flow(fill: true)
            end
          end

          flow(fill: true)
        end

        @tile_size = 32
        @level = Level.new(map_image: get_image("data/level.png"))
      end

      def draw
        # base background, sandy
        Gosu.draw_rect(0, 0, window.width, window.height, 0xfa_865e3c)

        # (window.height / @tile_size).times do |y|
        #   (window.width / @tile_size).times do |x|
        #     Gosu.draw_rect(x * @tile_size, y * @tile_size, @tile_size, @tile_size, (x + y).even? ? 0xff_986a11 : 0xff_8ff0a4)
        #   end
        # end

        level_scale = @level.scale(window.width, window.height)
        Gosu.translate(0, window.height - (@level.map_height * level_scale)) do
          Gosu.scale(level_scale, level_scale) do
            @level.draw_map
          end
        end

        Gosu.flush

        super
      end

      def fixed_update(dt)
        super

        @level.fixed_update(dt)

        pop_state if @level.city_health <= 0

        @credits_label.value = format("Credits: $%i", @level.credits)
        @enemies_label.value = format("Enemies: %03i", @level.enemies_remaining)
        @city_health_label.value = format("City Health: %03i%%", @level.city_health)
      end
    end
  end
end
