import { Astal, App, Gdk } from "astal/gtk4";
import SystemControls from "./system-controls/system-controls";

export function Overway() {
  return (
    <window
      // visible
      name="overway"
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      layer={Astal.Layer.OVERLAY}
      keymode={Astal.Keymode.ON_DEMAND}
      application={App}
      onKeyPressed={(self, keyval) => {
        if (keyval == Gdk.KEY_Escape) self.hide();
      }}
    >
      <box>
        <SystemControls />
      </box>
    </window>
  );
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
