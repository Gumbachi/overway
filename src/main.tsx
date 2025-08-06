import app from "ags/gtk4/app"
import style from "./style.scss"
import Dashboard from "./widgets/dashboard/Dashboard"

app.start({
  css: style,
  instanceName: "overway",
  main() {
    Dashboard()
  },
})
