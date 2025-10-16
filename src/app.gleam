import components/card
import components/resource
import components/theme_toggle
import lustre/attribute.{class, href, lang, rel}
import lustre/element.{type Element, text}
import lustre/element/html.{
  a, body, div, footer, h1, h2, h3, head, header, html, li, link, main, meta,
  nav, p, section, span, title, ul,
}
import types

const cosense_url = "https://scrapbox.io/gleam-jp/"

const zenn_url = "https://zenn.dev/p/gleam_jp"

const discord_url = "https://discord.gg/NPknY8pQzN"

const github_url = "https://github.com/gleam-jp"

const learn_resources = [
  #("https://tour.gleam.run/", "📚", "Gleamの構文の概要"),
  #("https://gleam.run/command-line-reference/", "📖", "コマンドラインリファレンス"),
  #("https://github.com/gleam-lang/cookbook", "💡", "Gleamクックブック"),
  #("https://packages.gleam.run/", "💯", "パッケージインデックス"),
  #("https://playground.gleam.run/", "🌟", "プレイグラウンド"),
]

const offcial_libraries = [
  #("https://hexdocs.pm/gleam_stdlib/", "🌟", "標準ライブラリ"),
  #("https://hexdocs.pm/gleam_http/", "🕸️", "HTTPの型と関数の定義"),
  #("https://hexdocs.pm/gleam_otp/", "⚙️", "OTPライブラリ"),
]

fn html_head() {
  head([], [
    title([], "gleam-jp"),
    meta([
      attribute.charset("UTF-8"),
    ]),
    meta([
      attribute.name("viewport"),
      attribute.content("width=device-width, initial-scale=1.0"),
    ]),
    meta([
      attribute.name("description"),
      attribute.content(
        "Gleam言語の日本コミュニティ。Gleamは型安全で関数型のプログラミング言語です。学習リソース、ライブラリ情報、コミュニティ参加方法を提供しています。",
      ),
    ]),
    meta([
      attribute.name("keywords"),
      attribute.content("Gleam,プログラミング言語,関数型,型安全,Erlang,JavaScript,日本,コミュニティ"),
    ]),
  ])
}

pub fn index(model: types.Model) {
  html([lang("ja")], [html_head(), html_body(model)])
}

fn html_body(model: types.Model) {
  body([class("scroll-smooth")], [
    div([class("min-h-screen bg-base-100 mx-2 md:mx-20")], [
      header(
        [
          class("bg-gleam-underwater-blue text-gleam-white py-6"),
          attribute.attribute("role", "banner"),
        ],
        [
          nav(
            [
              class("container mx-auto px-4"),
              attribute.attribute("role", "navigation"),
              attribute.attribute("aria-label", "メインナビゲーション"),
            ],
            [
              div([class("flex items-center justify-between")], [
                div([class("text-xl md:text-2xl font-bold text-faffPink")], [
                  text("gleam-jp"),
                ]),
                theme_toggle.theme_toggle(model.theme),
              ]),
            ],
          ),
        ],
      ),

      main(
        [
          class("container mx-auto px-2 md:px-4 py-8 md:py-12"),
          attribute.id("main-content"),
          attribute.attribute("role", "main"),
        ],
        [
          // Hero Section
          section(
            [
              class("text-center mb-12 md:mb-16"),
              attribute.attribute("aria-labelledby", "hero-title"),
            ],
            [
              h1(
                [
                  class("text-4xl md:text-6xl font-bold mb-4 text-faffPink"),
                  attribute.id("hero-title"),
                ],
                [
                  text("gleam-jp"),
                ],
              ),
              p([class("text-xl md:text-xl mb-6 md:mb-8 text-fabb-700")], [
                text("Gleam言語の日本コミュニティ"),
              ]),
              div(
                [
                  class(
                    "flex flex-col sm:flex-row justify-center items-center gap-4",
                  ),
                ],
                [
                  cta_button("#about", "Gleamとは？", True),
                  cta_button("#community", "コミュニティに参加", False),
                ],
              ),
            ],
          ),

          // About Section
          section_with_id("mb-12 md:mb-16", "about", "Gleamについて"),
          div(
            [
              class(
                "space-y-6 md:space-y-8 mx-20 md:mx-auto max-w-full md:max-w-sm px-1 md:px-0",
              ),
            ],
            [
              div([class("text-left")], [
                p([class("mb-4")], [
                  text("GleamはErlang/JavaScriptで動作する静的型付けな関数型言語です。"),
                ]),
                p([class("mb-4")], [
                  text("ifやforがなく、パターンマッチや再帰でフローを構築するなど、シンプルな構文が特徴です。"),
                ]),
              ]),
              div([class("p-8 rounded-lg")], [
                h3([class("text-lg md:text-xl font-bold mb-4")], [
                  text("主な特徴"),
                ]),
                ul([class("list-none space-y-2")], [
                  li([], [
                    span([attribute.attribute("aria-hidden", "true")], [
                      text("🛡️ "),
                    ]),
                    text("型安全性とパターンマッチング"),
                  ]),
                  li([], [
                    span([attribute.attribute("aria-hidden", "true")], [
                      text("💎 "),
                    ]),
                    text("不変データ構造"),
                  ]),
                  li([], [
                    span([attribute.attribute("aria-hidden", "true")], [
                      text("🌐 "),
                    ]),
                    text("Actor modelによる並行処理"),
                  ]),
                ]),
              ]),
            ],
          ),
        ],
      ),

      // Community Section
      section_with_id("mb-12 md:mb-16", "community", "コミュニティ"),
      div(
        [
          class(
            "grid grid-cols-1 md:grid-cols-2 gap-8 md:gap-6 mx-20 md:mx-auto max-w-full md:max-w-md px-1 md:px-0",
          ),
        ],
        [
          card.community_card("GitHub", github_url, model.theme),
          card.community_card("Zenn", zenn_url, model.theme),
          card.community_card("Cosense", cosense_url, model.theme),
          card.community_card("Discord", discord_url, model.theme),
        ],
      ),

      // Resources Section
      section_with_id(
        "mb-2 md:mb-16 mt-12 md:mt-16",
        "resources",
        "ドキュメントとライブラリ",
      ),
      section([class("mb-12 md:mb-16")], [
        div(
          [
            class(
              "grid grid-cols-1 gap-8 md:gap-12 mx-auto max-w-full md:max-w-sm px-1 md:px-0",
            ),
          ],
          [
            resource.resource_section(
              "公式サイトとリポジトリ",
              learn_resources,
              model.theme,
            ),
            resource.resource_section("公式ライブラリ", offcial_libraries, model.theme),
          ],
        ),
      ]),

      // Footer Section
      footer(
        [
          class("text-gleam-white py-8"),
          attribute.attribute("role", "contentinfo"),
        ],
        [
          div(
            [class("h-1 bg-black rounded-full w-60 md:w-80 mx-auto mb-4")],
            [],
          ),
          div([class("container mx-auto px-4 text-center")], [
            p([class("mb-4 text-base md:text-lg text-faffPink font-bold")], [
              text("gleam-jp"),
            ]),
            p([class("text-base md:text-sm text-black-300")], [
              text("© 2024 gleam-jp some rights reserved."),
            ]),
          ]),
        ],
      ),
    ]),
  ])
}

fn cta_button(url: String, title: String, is_primary: Bool) -> Element(msg) {
  let button_class = case is_primary {
    True ->
      "border-2 border-black px-5 md:px-6 py-3 md:py-3 text-base md:text-base rounded-lg font-semibold shadow-faffpink-mobile hover:bg-opacity-90 w-55 text-center"
    False ->
      "border-2 border-black px-5 md:px-6 py-3 md:py-3 text-base md:text-base rounded-lg font-semibold shadow-faffpink-mobile hover:bg-primary-700 w-55 text-center"
  }

  a([href(url), class(button_class)], [text(title)])
}

fn section_with_id(
  margin_class: String,
  id: String,
  title: String,
) -> Element(msg) {
  section([class(margin_class), attribute.id(id)], [
    h2([class("text-2xl md:text-4xl font-bold mb-8 text-center")], [text(title)]),
  ])
}
