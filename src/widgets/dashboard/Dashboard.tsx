import { Astal, Gdk, Gtk } from "ags/gtk4"
import app from "ags/gtk4/app"
import Datetime from "../datetime/Datetime"
import SystemControls from "../system-controls/SystemControls"
import VolumeControls from "../volume-controls/VolumeControls"
import Tray from "../tray/Tray"
import MprisPlayers from "../media-player/MediaPlayer"


export default function Dashboard() {

  let win: Astal.Window

  const onEscClicked = (_e: Gtk.EventControllerKey, keyval: number, _: number, _m: number) => {
    if (keyval === Gdk.KEY_Escape) win.visible = false
  }

	return <window
    $={(ref) => (win = ref)}
    visible
    class="dashboard"
    name="overway" // Name must be before application
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    layer={Astal.Layer.OVERLAY}
    keymode={Astal.Keymode.ON_DEMAND}
    application={app}
  >
    <Gtk.EventControllerKey onKeyPressed={onEscClicked} />


    <box class="main-window">

      <box class="scratchpad"/>

      <box orientation={Gtk.Orientation.VERTICAL}>

        <box class="quickactions" />

        <box class="widget-row">
          <Datetime />  
          <MprisPlayers />
        </box>

        <box class="widget-row">
          <VolumeControls />
          <SystemControls />
        </box>

        <Tray />

      </box>

    </box>
     
  </window>
}

