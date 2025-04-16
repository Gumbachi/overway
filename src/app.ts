import { App } from "astal/gtk3"
import style from "./style.scss"
import Overway from "./widget/Overway"

App.start({
  css: style,
  main: () => Overway()
})
