import app
import effects
import lustre
import lustre/effect.{type Effect}
import types.{
  type Model, type Msg, Dark, Light, Model, ThemeLoaded, ToDarkMode, ToEnglish,
  ToJapanese, ToLightMode,
}

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

fn init(_flags) -> #(Model, Effect(Msg)) {
  #(Model(theme: Light), effects.load_theme())
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    ToLightMode -> {
      let new_model = Model(theme: Light)
      #(
        new_model,
        effect.batch([
          effects.save_theme(Light),
          effects.apply_theme_to_dom(Light),
        ]),
      )
    }
    ToDarkMode -> {
      let new_model = Model(theme: Dark)
      #(
        new_model,
        effect.batch([
          effects.save_theme(Dark),
          effects.apply_theme_to_dom(Dark),
        ]),
      )
    }
    ThemeLoaded(Ok(theme_string)) -> {
      let theme = effects.string_to_theme(theme_string)
      #(Model(theme: theme), effects.apply_theme_to_dom(theme))
    }
    ThemeLoaded(Error(_)) -> {
      // Failed to load theme, keep current theme and apply it to DOM
      #(model, effects.apply_theme_to_dom(model.theme))
    }
    ToJapanese -> {
      // Language switching not yet implemented
      #(model, effect.none())
    }
    ToEnglish -> {
      // Language switching not yet implemented
      #(model, effect.none())
    }
  }
}

fn view(model: Model) {
  app.index(model)
}
