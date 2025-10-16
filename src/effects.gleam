import lustre/effect.{type Effect}
import plinth/javascript/storage
import types.{type Msg, type Theme, Dark, Light, ThemeLoaded}

const theme_key = "gleam-jp-theme"

@external(javascript, "./browser_ffi.mjs", "setThemeAttribute")
fn do_set_theme_attribute(theme: String) -> Nil

pub fn save_theme(theme: Theme) -> Effect(Msg) {
  let theme_string = case theme {
    Light -> "light"
    Dark -> "dark"
  }

  use _dispatch <- effect.from
  case storage.local() {
    Ok(local_storage) -> {
      let _ = storage.set_item(local_storage, theme_key, theme_string)
      Nil
    }
    Error(_) -> Nil
  }
}

pub fn load_theme() -> Effect(Msg) {
  use dispatch <- effect.from
  case storage.local() {
    Ok(local_storage) -> {
      case storage.get_item(local_storage, theme_key) {
        Ok(theme_string) -> dispatch(ThemeLoaded(Ok(theme_string)))
        Error(_) -> dispatch(ThemeLoaded(Error("No theme saved")))
      }
    }
    Error(_) -> dispatch(ThemeLoaded(Error("Failed to access localStorage")))
  }
}

pub fn apply_theme_to_dom(theme: Theme) -> Effect(Msg) {
  let theme_string = case theme {
    Light -> "light"
    Dark -> "dark"
  }

  use _dispatch <- effect.from
  do_set_theme_attribute(theme_string)
}

pub fn string_to_theme(theme_string: String) -> Theme {
  case theme_string {
    "light" -> Light
    "dark" -> Dark
    _ -> Light
    // Default to light theme if invalid
  }
}
