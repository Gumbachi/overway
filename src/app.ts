import { App } from "astal/gtk3"
import style from "style.scss"
import Overway from "./widget/overway/Overway"
import VolumeMixer from "./widget/volume-controls/VolumeMixer"
import NotificationPopups from "./widget/notifications/NotificationPopups"

App.start({
  css: style,
  instanceName: "overway",
  main: () => {
    Overway()
    VolumeMixer()
    NotificationPopups(App.get_monitors()[0])
  }
})
