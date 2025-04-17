import { App } from "astal/gtk3"
import style from "style.scss"
import Overway from "./widget/Overway"
import VolumeMixer from "./widget/volume-controls/VolumeMixer"

App.start({
  css: style,
  instanceName: "overway",
  main: () => {
    Overway()
    VolumeMixer()
  }
})
