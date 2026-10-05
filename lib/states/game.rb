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
              @turret_button = button "Turret", margin_left: PADDING, tip: "$100 • Cut down big triangles" do
                @placable = Entities::Turret.new(level: @level, x: window.mouse_x, y: window.mouse_y)
              end
              # button "Cannon", margin_left: PADDING, enabled: false, tip: "$10 000 • Mow down enemies"
              # button "Sell", margin_left: MASSIVE_PADDING, tip: "Sell item for 100% of its original value"
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

        @level_scale = @level.scale(window.width, window.height)
        Gosu.translate(0, window.height - (@level.map_height * @level_scale)) do
          Gosu.scale(@level_scale, @level_scale) do
            @level.draw_map
            @placable&.draw
            @placable&.placable_draw

            if @placable && !turret_placable?
              Gosu.draw_rect(
                @placable.position.x - Level::HALF_TILE_SIZE,
                @placable.position.y - Level::HALF_TILE_SIZE,
                Level::TILE_SIZE,
                Level::TILE_SIZE,
                0x44_ff0000,
                @placable.position.z
              )
            end
          end
        end

        Gosu.flush

        super
      end

      def fixed_update(dt)
        super

        # 11th hour math is fun! xD
        @placable&.position&.x = ((window.mouse_x / @level_scale) / Level::TILE_SIZE).floor * Level::TILE_SIZE + Level::HALF_TILE_SIZE
        @placable&.position&.y = (((window.mouse_y / @level_scale) - (window.height / @level_scale - (@level.map_height))) / Level::TILE_SIZE).floor * Level::TILE_SIZE + Level::HALF_TILE_SIZE

        @level.fixed_update(dt)

        pop_state if @level.city_health <= 0

        # @turret_button.enabled = @level.credits >= 100
        @credits_label.value = format("Credits: $%i", @level.credits)
        @enemies_label.value = format("Enemies: %03i", @level.enemies_remaining)
        @city_health_label.value = format("City Health: %03i%%", @level.city_health)
      end

      def turret_placable?
        return false unless @placable

        grid_cell = @placable.grid_cell
        pp [@placable.grid_cell, @level.tile_type_at(x: grid_cell.x, y: grid_cell.y)]
      end
    end
  end
end
