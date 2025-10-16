import gleam/list
import lustre/attribute.{class, href, target}
import lustre/element.{type Element, text}
import lustre/element/html.{a, div, h3}
import types.{type Theme, Dark, Light}

pub type CardContent {
  ResourceLinks(links: List(#(String, String)))
  CommunityInfo(description: String, link: String)
}

pub fn card(
  title: String,
  content: CardContent,
  _color_class: String,
  theme: Theme,
) -> Element(msg) {
  let base_classes = "border-2 p-6 rounded-lg"

  let shadow_class = case theme {
    Light ->
      "shadow-[8px_8px_0px_0px_rgba(255,255,255,1)] hover:shadow-[12px_12px_0px_0px_#ffaff3] transition-all duration-300 transform hover:-translate-x-1 hover:-translate-y-1"
    Dark ->
      "shadow-[8px_8px_0px_0px_rgba(41,45,62,1)] hover:shadow-[12px_12px_0px_0px_#ffaff3] transition-all duration-300 transform hover:-translate-x-1 hover:-translate-y-1"
  }

  let card_classes = case content {
    ResourceLinks(_) -> base_classes <> "p-8 " <> shadow_class
    CommunityInfo(_, _) ->
      base_classes <> " border-base-content " <> shadow_class
  }

  let content_elements = case content {
    ResourceLinks(links) -> [
      div(
        [class("space-y-2")],
        links
          |> list.map(fn(link_data) {
            let #(url, label) = link_data
            a(
              [
                href(url),
                target("_blank"),
                class("block"),
              ],
              [text(label)],
            )
          }),
      ),
    ]
    CommunityInfo(_description, link) -> [
      a(
        [
          href(link),
          target("_blank"),
          class(
            "block text-center border-2 border-base-content px-4 py-2 rounded-lg max-w-40 mx-auto hover:bg-faffPink transition-colors duration-500",
          ),
          attribute.attribute("aria-label", "コミュニティに参加"),
        ],
        [text("参加する")],
      ),
    ]
  }

  div([class(card_classes)], [
    h3([class("text-lg md:text-xl font-bold mb-4")], [text(title)]),
    ..content_elements
  ])
}

pub fn community_card(title: String, link: String, theme: Theme) {
  card(title, CommunityInfo("", link), "", theme)
}
