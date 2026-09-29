module TowerDefense
  FONT_PRIMARY = "media/fonts/LXGWWenKaiMonoTC/LXGWWenKaiMonoTC-Regular.ttf"
  FONT_SECONDARY = "media/fonts/NovaMono/NovaMono-Regular.ttf"

  PADDING = 8
  LARGE_PADDING = PADDING * 2
  MASSIVE_PADDING = LARGE_PADDING * 2

  NINE_SLICE_EDGE = 8
  NINE_SLICE_EDGE_SMALL = 4
  NINE_SLICE_EDGE_TINY = 2
  NINE_SLICE_ROUNDED = "#{CYBERARM_ENGINE_ROOT_PATH}/assets/textures/ui/rounded.png"
  NINE_SLICE_ROUNDED_SMALL = "#{CYBERARM_ENGINE_ROOT_PATH}/assets/textures/ui/rounded_small.png"
  NINE_SLICE_ROUNDED_TINY = "#{CYBERARM_ENGINE_ROOT_PATH}/assets/textures/ui/rounded_small.png"
  NINE_SLICE_ROUNDED_LEFT = "#{CYBERARM_ENGINE_ROOT_PATH}/assets/textures/ui/rounded_left.png"
  NINE_SLICE_ROUNDED_RIGHT = "#{CYBERARM_ENGINE_ROOT_PATH}/assets/textures/ui/rounded_right.png"
  NINE_SLICE_ROUNDED_TOP = "#{CYBERARM_ENGINE_ROOT_PATH}/assets/textures/ui/rounded_top.png"
  NINE_SLICE_ROUNDED_BOTTOM = "#{CYBERARM_ENGINE_ROOT_PATH}/assets/textures/ui/rounded_bottom.png"
  NINE_SLICE_SQUARE = "#{CYBERARM_ENGINE_ROOT_PATH}/assets/textures/ui/square.png"

  THEME = {
    TextBlock: {
      text_static: true,
      text_shadow: true,
      text_shadow_size: 1,
      text_shadow_color: 0x44_000000,
      font: FONT_PRIMARY
    },
    Banner: {
      text_shadow: true,
      text_shadow_size: 2,
      text_shadow_color: 0x44_000000,
      font: FONT_SECONDARY
    },
    Title: {
      font: FONT_SECONDARY
    },
    Subtitle: {
      font: FONT_SECONDARY
    },
    Button: {
      font: FONT_SECONDARY,
      background: 0,
      background_nine_slice: NINE_SLICE_ROUNDED,
      background_nine_slice_from_edge: NINE_SLICE_EDGE,
      background_nine_slice_mode: :stretched,
      background_nine_slice_color: 0xff_1a5fb4,
      border_thickness: 0,
      hover: {
        background: 0,
        background_nine_slice_color: 0xff_1c71d8,
      },
      active: {
        background: 0
      },
      disabled: {
        background: 0
      }
    },
    EditLine: {
      font: FONT_PRIMARY
    },
    ToolTip: {
      font: FONT_PRIMARY,
      text_size: 20,
      background: 0,
      background_nine_slice: NINE_SLICE_ROUNDED,
      background_nine_slice_from_edge: NINE_SLICE_EDGE,
      background_nine_slice_mode: :stretched,
      background_nine_slice_color: 0xcc_000000,
      border_thickness: 0
    },
    rounded_box: {
      background: 0,
      background_nine_slice: NINE_SLICE_ROUNDED,
      background_nine_slice_from_edge: NINE_SLICE_EDGE,
      background_nine_slice_mode: :stretched,
      border_thickness: 0
    }
  }
end
