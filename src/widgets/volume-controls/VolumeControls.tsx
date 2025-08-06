import { createBinding, createComputed } from "ags"
import { Gtk } from "ags/gtk4"
import AstalWp from "gi://AstalWp?version=0.1"

const audio = AstalWp.get_default()!.audio

const speaker = audio.defaultSpeaker
const mic = audio.defaultMicrophone

function VolumeControlEntry(device: AstalWp.Endpoint) {

  let lastVolume = createBinding(mic, "volume").get()

  function toggleMute(device: AstalWp.Endpoint) {
    return () => {
      const vol = createBinding(device, "volume").get()
      if (vol === 0) {
        device.volume = lastVolume
      } else {
        lastVolume = vol
        device.volume = 0
      }
    }
  }

  function getIcon(device: AstalWp.Endpoint) {

    return createComputed(
      [createBinding(device, "volume"), createBinding(device, "volumeIcon"), createBinding(device, "mediaClass")],
      (vol, icon, mediaClass) => {
        let prefix = mediaClass == AstalWp.MediaClass.AUDIO_SOURCE ? "audio-volume" : "microphone-sensitivity"
        return vol === 0 ? `${prefix}-muted-symbolic` : icon 
      }
    )
  }

  return <box class="VolumeControlEntry">
    <button valign={ Gtk.Align.CENTER } onClicked={ toggleMute(device) }>
      <image iconName={ getIcon(device) }  />
    </button>
    <label 
      halign={ Gtk.Align.CENTER }
      label={ createBinding(device, "volume").as(v => `${Math.ceil(v * 100)}`) } 
    />
    <slider 
      hexpand
      onMoveSlider={ ({value}) => device.volume = value }
      value={ createBinding(device, "volume") }
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
    class="VolumeControls"
    orientation={Gtk.Orientation.VERTICAL}
    homogeneous
  >    
    { VolumeControlEntry(mic) }
    { VolumeControlEntry(speaker) }
  </box>

}

