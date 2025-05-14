import { bind } from "astal"
import AstalTray from "gi://AstalTray"

const tray = AstalTray.get_default()

function TrayItem(item: AstalTray.TrayItem) {

  return <menubutton
    className="item"
    tooltipMarkup={ bind(item, "tooltipMarkup") }
    usePopover={ true }
    actionGroup={ bind(item, "actionGroup").as(ag => ["dbusmenu", ag]) }
    menuModel={ bind(item, "menuModel") }
  >

    <icon gicon={ bind(item, "gicon") } />

  </menubutton>


}

export default function Tray() {
  return <box className="Tray" hexpand>
    { bind(tray, "items").as(items => items.map(TrayItem)) }
  </box>
}
