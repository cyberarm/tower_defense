module TowerDefense
  module States
    class GameOver < CyberarmEngine::GuiState
      def setup
        @level = @options[:level]
        theme(THEME)

        background 0xff_986a44

        flow(width: 1.0, height: 1.0) do
          stack(width: 0.333, height: 1.0, max_width: 300, padding: MASSIVE_PADDING) do
            background 0xff_63452c

            button "Play Again", width: 1.0 do
              push_state(States::Game)
            end

            flow(fill: true)

            button "Quit", width: 1.0 do
              window.close
            end
          end

          stack(fill: true, height: 1.0, margin: LARGE_PADDING, margin_left: MASSIVE_PADDING, margin_bottom: MASSIVE_PADDING) do
            # background 0xff_cdab8f
            banner "Game Over"
            tagline "Enemies Killed: #{@level.enemies_killed}"
            tagline "Turrets Built: #{@level.entities.select { |e| e.is_a?(Entities::Turret) }.count - 2}"

            flow(fill: true)

            para NAME
            para "cyberarm's entry for the 10th Gosu Game Jam."
          end
        end
      end
    end
  end
end
