import app
import arctic/build
import arctic/config
import gleam/io
import snag

pub fn main() {
  let config =
    config.new()
    |> config.home_renderer(app.index)
  let res = build.build(config)
  case res {
    Ok(Nil) -> io.println("Build success!")
    Error(err) -> io.println(snag.pretty_print(err))
  }
}
