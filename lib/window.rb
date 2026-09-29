module TowerDefense
  class Window < CyberarmEngine::Window
    def setup
      self.show_cursor = true
      self.caption = TowerDefense::TITLE

      push_state(States::MainMenu)
    end
  end
end
