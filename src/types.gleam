pub type Theme {
  Light
  Dark
}

pub type Msg {
  ToLightMode
  ToDarkMode
  ThemeLoaded(Result(String, String))
  ToJapanese
  ToEnglish
}

pub type Model {
  Model(theme: Theme)
}
