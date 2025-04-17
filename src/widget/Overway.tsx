import { Astal, App, Gdk } from "astal/gtk3";
import SystemControls from "./system-controls/SystemControls";
import Datetime from "./datetime/Datetime";
import MprisPlayers from "./media-player/MediaPlayer";
import VolumeControls from "./volume-controls/VolumeControls";
import VolumeMixer from "./volume-controls/VolumeMixer";

export default function Overway() {
	return <window
    // visible
    className="Overway"
    name="overway"
    exclusivity={Astal.Exclusivity.IGNORE}
    layer={Astal.Layer.TOP}
    keymode={Astal.Keymode.ON_DEMAND}
    application={App}
    onKeyPressEvent={(self, event: Gdk.Event) => {
      if (event.get_keyval()[1] === Gdk.KEY_Escape) { self.hide() }
    }}
  >
    
    <box vertical className="container">
      <centerbox>
        <VolumeControls />
        <MprisPlayers />
      </centerbox>

      <centerbox>
        <Datetime />
        <SystemControls />
      </centerbox>

    </box>
  </window>
}

