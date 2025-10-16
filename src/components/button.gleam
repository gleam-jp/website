import lustre/attribute.{class, href, target}
import lustre/element.{type Element, text}
import lustre/element/html.{a}

pub fn cta_button(url: String, title: String, is_primary: Bool) -> Element(msg) {
  let button_class = case is_primary {
    True ->
      "border-2 border-black px-5 md:px-6 py-3 md:py-3 text-base md:text-base rounded-lg font-semibold shadow-faffpink-mobile hover:bg-opacity-90 w-55 text-center"
    False ->
      "border-2 border-black px-5 md:px-6 py-3 md:py-3 text-base md:text-base rounded-lg font-semibold shadow-faffpink-mobile hover:bg-primary-700 w-55 text-center"
  }

  a(
    [
      href(url),
      case is_primary {
        True -> target("_blank")
        False -> class("")
      },
      class(button_class),
      case is_primary {
        True -> attribute.attribute("aria-describedby", "external-link-desc")
        False -> class("")
      },
    ],
    [text(title)],
  )
}
