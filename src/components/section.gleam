import lustre/attribute.{class, id}
import lustre/element.{type Element, text}
import lustre/element/html.{h2, section}

pub fn section_with_id(
  margin_class: String,
  section_id: String,
  title: String,
) -> Element(msg) {
  section([class(margin_class), id(section_id)], [
    h2([class("text-2xl md:text-4xl font-bold mb-8 text-center")], [text(title)]),
  ])
}
