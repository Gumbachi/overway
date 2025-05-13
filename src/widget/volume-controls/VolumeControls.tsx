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

    return Variable.derive(
      [bind(device, "volume"), bind(device, "volumeIcon"), bind(device, "mediaClass")],
      (vol, icon, mediaClass) => {
        let prefix = mediaClass == Wp.MediaClass.AUDIO_SPEAKER ? "audio-volume" : "microphone-sensitivity"
        return vol === 0 ? `${prefix}-muted-symbolic` : icon 
      }
    )
  }

  return <box className="VolumeControlEntry">
    <button valign={ Gtk.Align.CENTER } onClicked={ toggleMute(device) }>
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


    // <button 
    //   className="ShowMixerButton"
    //   onClick={() => showVolumeMixer.set(!showVolumeMixer.get()) }
    // >
    //   <box halign={ Gtk.Align.CENTER } hexpand>
    //     <icon icon="multimedia-equalizer-symbolic" />
    //     <label label="Volume Mixer" />
    //   </box>
    // </button>

export default function VolumeControls() {

  return <box 
    className="VolumeControls WidgetContainer"
    vertical
    homogeneous
    // valign={ Gtk.Align.END }
  >    

    { VolumeControlEntry(mic) }
    { VolumeControlEntry(speaker) }

  </box>

}

