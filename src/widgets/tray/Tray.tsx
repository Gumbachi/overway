import { createBinding, For } from "ags"
import { Gtk } from "ags/gtk4"
import AstalTray from "gi://AstalTray"

export default function Tray() {
  const tray = AstalTray.get_default()
  const items = createBinding(tray, "items")

  const init = (btn: Gtk.MenuButton, item: AstalTray.TrayItem) => {
    btn.menuModel = item.menuModel
    btn.insert_action_group("dbusmenu", item.actionGroup)
    item.connect("notify::action-group", () => {
      btn.insert_action_group("dbusmenu", item.actionGroup)
    })
  }

  return <box class="tray" hexpand>
    <For each={items}> 
      {(item) => (
        <menubutton class="item" $={(self) => init(self, item)}>
          <image gicon={createBinding(item, "gicon")} />
        </menubutton>
      )}
    </For>
  </box>
}
