import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html.{input, label}
import lustre/element/svg
import lustre/event
import types.{type Msg, type Theme, Dark, Light, ToDarkMode, ToLightMode}

pub fn theme_toggle(current_theme: Theme) -> Element(Msg) {
  let next_msg = case current_theme {
    Light -> ToDarkMode
    Dark -> ToLightMode
  }

  let aria_label = case current_theme {
    Light -> "ダークモードに切り替え"
    Dark -> "ライトモードに切り替え"
  }

  let is_checked = case current_theme {
    Dark -> True
    Light -> False
  }

  label([class("toggle toggle-lg bg-faffPink")], [
    input([
      attribute.type_("checkbox"),
      attribute.checked(is_checked),
      event.on_click(next_msg),
      attribute.attribute("aria-label", aria_label),
    ]),
    // Sun icon (for light mode)
    svg.svg(
      [
        attribute.attribute("aria-label", "light mode"),
        attribute.attribute("xmlns", "http://www.w3.org/2000/svg"),
        attribute.attribute("viewBox", "0 0 24 24"),
        attribute.attribute("fill", "currentColor"),
      ],
      [
        svg.path([
          attribute.attribute(
            "d",
            "M12 2.25a.75.75 0 01.75.75v2.25a.75.75 0 01-1.5 0V3a.75.75 0 01.75-.75zM7.5 12a4.5 4.5 0 119 0 4.5 4.5 0 01-9 0zM18.894 6.166a.75.75 0 00-1.06-1.06l-1.591 1.59a.75.75 0 101.06 1.061l1.591-1.59zM21.75 12a.75.75 0 01-.75.75h-2.25a.75.75 0 010-1.5H21a.75.75 0 01.75.75zM17.834 18.894a.75.75 0 001.06-1.06l-1.59-1.591a.75.75 0 10-1.061 1.06l1.59 1.591zM12 18a.75.75 0 01.75.75V21a.75.75 0 01-1.5 0v-2.25A.75.75 0 0112 18zM7.758 17.303a.75.75 0 00-1.061-1.06l-1.591 1.59a.75.75 0 001.06 1.061l1.591-1.59zM6 12a.75.75 0 01-.75.75H3a.75.75 0 010-1.5h2.25A.75.75 0 016 12zM6.697 7.757a.75.75 0 001.06-1.06l-1.59-1.591a.75.75 0 00-1.061 1.06l1.59 1.591z",
          ),
        ]),
      ],
    ),
    // Moon icon (for dark mode)
    svg.svg(
      [
        attribute.attribute("aria-label", "dark mode"),
        attribute.attribute("xmlns", "http://www.w3.org/2000/svg"),
        attribute.attribute("viewBox", "0 0 24 24"),
        attribute.attribute("fill", "currentColor"),
      ],
      [
        svg.path([
          attribute.attribute(
            "d",
            "M9.528 1.718a.75.75 0 01.162.819A8.97 8.97 0 009 6a9 9 0 009 9 8.97 8.97 0 003.463-.69.75.75 0 01.981.98 10.503 10.503 0 01-9.694 6.46c-5.799 0-10.5-4.701-10.5-10.5 0-4.368 2.667-8.112 6.46-9.694a.75.75 0 01.818.162z",
          ),
        ]),
      ],
    ),
  ])
}
