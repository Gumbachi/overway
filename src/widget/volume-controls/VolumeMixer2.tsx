import { Astal, Gdk, Gtk, App } from "astal/gtk3"
import { showVolumeMixer } from "../../data/config"
import Wp from "gi://AstalWp"
import { bind, Variable } from "astal"
import { Box } from "astal/gtk4/widget"
import Pango from "gi://Pango?version=1.0"

const audio = Wp.get_default()!.audio

export function VolumeMixerButton() {
  return <button
    className="quick-action-button"
    onClick={ () => print("clicked") }
  >
    <label label="Volume Mixer"> 
  </button>
}

export default function VolumeMixer() {
  return <window
    visible={showVolumeMixer()}
    // className="VolumeMixer"
    application={App}
    layer={Astal.Layer.OVERLAY}
    exclusivity={Astal.Exclusivity.IGNORE}
    keymode={Astal.Keymode.EXCLUSIVE}
    onKeyPressEvent={(self, event: Gdk.Event) => {
      if (event.get_keyval()[1] === Gdk.KEY_Escape) { 
        showVolumeMixer.set(false) 
      }
    }}
  >
    <box className="VolumeMixer2" vertical homogeneous>
      { bind(audio, "streams").as(streams => streams.map((stream, index) => (
        <box 
          className="entry"
          hexpand
          vertical
          valign={ Gtk.Align.CENTER }
        >
          <box>
            <label 
              className="source"
              justify={ Gtk.Justification.LEFT }
              label={ bind(stream, "description") } 
            />
            <label 
              className="name"
              ellipsize={Pango.EllipsizeMode.END}
              justify={ Gtk.Justification.LEFT }
              label={ bind(stream, "name") } 
            />
          </box>
          <slider 
            hexpand
            onDragged={ ({value}) => stream.volume = value }
            value={ bind(stream, "volume") }
          />
        </box>

      ))) }
 
    </box>
  </window>
}
