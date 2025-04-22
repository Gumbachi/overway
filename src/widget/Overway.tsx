import { Astal, App, Gdk } from "astal/gtk3";
import SystemControls from "./system-controls/SystemControls";
import Datetime from "./datetime/Datetime";
import MprisPlayers from "./media-player/MediaPlayer";
import VolumeControls from "./volume-controls/VolumeControls";
import Tray from "./tray/Tray";

export default function Overway() {
	return <window
    // visible
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
    
    <box vertical className="WindowContainer">

      <box className="WidgetRow">
        <VolumeControls />
        <MprisPlayers />
      </box>

      <box className="WidgetRow">
        <Datetime />  
        <SystemControls />
      </box>

      <box className="WidgetRow">
        <Tray />
      </box>


    </box>
  </window>
}

