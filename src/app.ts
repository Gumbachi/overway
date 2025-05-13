import { App } from "astal/gtk3"
import style from "style.scss"
import Overway from "./widget/overway/Overway"
import VolumeMixer from "./widget/volume-controls/VolumeMixer"
import NotificationPopups from "./widget/notifications/NotificationPopups"
import QuickActions from "./widget/quick-actions/QuickActions"
import { readFile, writeFile } from "astal"
import { configPath, defaultConfig } from "./data/config"

App.start({
  css: style,
  instanceName: "overway",
  main: () => {

    // Create Init file if needed
    if (!readFile(configPath)) {
      print("Config file not found, creating default...")
      writeFile(configPath, JSON.stringify(defaultConfig, null, 2))
    }

    // Windows
    QuickActions()
    Overway()
    VolumeMixer()
    NotificationPopups(App.get_monitors()[0])
  }
})
