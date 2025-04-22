import { Variable } from "astal"
import GLib from "gi://GLib?version=2.0"

function Time({ format = "%T" }) {
  const time = Variable("")
    .poll(1000, () => GLib.DateTime.new_now_local().format(format)!)

  return <label
    className = "Time"
    onDestroy = { () => time.drop() }
    label = { time() }
  />
}

function Date({ format = "%B, %e, %Y" }) {
  const date = Variable("")
    .poll(60000, () => GLib.DateTime.new_now_local().format(format)!)

  return <label
    className = "Date"
    onDestroy = { () => date.drop() }
    label = { date() }
  />
}


export default function Datetime() {
  return <box
    className = "Datetime WidgetContainer"
    vertical
    hexpand
  >
    <Time />
    <Date />
  </box>
}
