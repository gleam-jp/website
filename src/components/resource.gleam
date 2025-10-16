import gleam/list
import lustre/attribute.{class, href, target}
import lustre/element.{type Element, text}
import lustre/element/html.{a, div, h3, li, span, ul}
import types.{type Theme}

pub fn resource_link(
  url: String,
  emoji: String,
  link_text: String,
  _theme: Theme,
) -> Element(msg) {
  case url {
    "" -> div([], [])
    _ ->
      a(
        [
          href(url),
          target("_blank"),
          class("flex items-center gap-2"),
          attribute.attribute("aria-label", link_text <> " (外部リンク)"),
        ],
        [
          span(
            [class("flex-shrink-0"), attribute.attribute("aria-hidden", "true")],
            [element.text(emoji)],
          ),
          div(
            [
              class(
                "relative overflow-hidden px-1 py-0.5 hover:bg-faffPink transition-colors duration-300 text-base-content",
              ),
            ],
            [element.text(link_text)],
          ),
        ],
      )
  }
}

pub fn resource_section(
  title: String,
  links: List(#(String, String, String)),
  theme: Theme,
) -> Element(msg) {
  div([], [
    h3([class("text-xl md:text-2xl text-center font-bold text-base-content")], [
      text(title),
    ]),
    ul(
      [class("list-none mx-auto w-fit mt-2")],
      links
        |> list.map(fn(link_data) {
          let #(url, emoji, label) = link_data
          li([class("text-xl")], [resource_link(url, emoji, label, theme)])
        }),
    ),
  ])
}
