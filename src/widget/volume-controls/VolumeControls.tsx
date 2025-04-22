import { bind, Variable } from "astal"
import Wp from "gi://AstalWp"
import { Gtk } from "astal/gtk3"
import { showVolumeMixer } from "../../data/config"
import VolumeMixer from "./VolumeMixer"

const audio = Wp.get_default()!.audio

const speaker = audio.defaultSpeaker
const mic = audio.defaultMicrophone

function VolumeControlEntry(device: Wp.Endpoint) {

  let lastVolume = bind(mic, "volume").get()

  function toggleMute(device: Wp.Endpoint) {
    return () => {
      const vol = bind(device, "volume").get()
      if (vol === 0) {
        device.volume = lastVolume
      } else {
        lastVolume = vol
        device.volume = 0
      }
    }
  }

  function getIcon(device: Wp.Endpoint) {
    const prefix = device === speaker ? "audio-volume" : "microphone-sensitivity"
    return Variable.derive(
      [bind(device, "volume"), bind(device, "volumeIcon")],
      (vol, icon) => vol === 0 ? `${prefix}-muted-symbolic` : icon
    )
  }

  return <box className="VolumeControlEntry">
    <button valign={ Gtk.Align.CENTER } onClick={ toggleMute(device) }>
      <icon icon={ bind(getIcon(device)) }  />
    </button>
    <label 
      halign={ Gtk.Align.CENTER }
      label={ bind(device, "volume").as(v => `${Math.ceil(v * 100)}`) } 
    />
    <slider 
      hexpand
      onDragged={ ({value}) => device.volume = value }
      value={ bind(device, "volume") }
    />

  </box>
}

export default function VolumeControls() {

  return <box 
    className="VolumeControls WidgetContainer"
    vertical
    // valign={ Gtk.Align.END }
  >    

    <button 
      className="ShowMixerButton"
      onClick={() => showVolumeMixer.set(!showVolumeMixer.get()) }
    >
      <box halign={ Gtk.Align.CENTER } hexpand>
        <icon icon="multimedia-equalizer-symbolic" />
        <label label="Volume Mixer" />
      </box>
    </button>

    <box vertical vexpand homogeneous valign={Gtk.Align.FILL}> 
      {VolumeControlEntry(mic)}
      {VolumeControlEntry(speaker)}
    </box>

  </box>

}

