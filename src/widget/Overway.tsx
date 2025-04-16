import { Astal, App, Gdk } from "astal/gtk3";
import SystemControls from "./system-controls/SystemControls";

export default function Overway() {
	return <window
    visible
    className="Overway"
    name="overway"
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    layer={Astal.Layer.OVERLAY}
    keymode={Astal.Keymode.ON_DEMAND}
    application={App}
    onKeyPressEvent={(self, event: Gdk.Event) => {
      if (event.get_keyval()[1] === Gdk.KEY_Escape) { self.hide() }
    }}
  >
    <SystemControls />
  </window>
}

// return <window
//     visible
//     cssClasses={["Bar"]}
//     gdkmonitor={gdkmonitor}
//     exclusivity={Astal.Exclusivity.EXCLUSIVE}
//     anchor={TOP | LEFT | RIGHT}
//     application={App}>
//     <centerbox cssName="centerbox">
//         <button
//             onClicked="echo hello"
//             hexpand
//             halign={Gtk.Align.CENTER}
//         >
//         Welcome to AGS
//         </button>
//         <box />
//         <menubutton
//             hexpand
//             halign={Gtk.Align.CENTER}
//         >
//             <label label={time()} />
//             <popover>
//                 <Gtk.Calendar />
//             </popover>
//         </menubutton>
//     </centerbox>
// </window>
