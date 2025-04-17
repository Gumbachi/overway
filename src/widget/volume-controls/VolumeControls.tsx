import { bind, Variable } from "astal"
import Wp from "gi://AstalWp"
import { Gtk } from "astal/gtk3"
import { showVolumeMixer } from "../../data/config"

const audio = Wp.get_default()!.audio

const speaker = audio.defaultSpeaker
const mic = audio.defaultMicrophone

export default function VolumeControls() {

  const lastVolumes = {
    [mic.mediaClass]: bind(mic, "volume").get(),
    [speaker.mediaClass]: bind(speaker, "volume").get()
  }
 
  function toggleMute(device: Wp.Endpoint) {
    return () => {
      const vol = bind(device, "volume").get()
      if (vol === 0) {
        device.volume = lastVolumes[device.mediaClass]
      } else {
        lastVolumes[device.mediaClass] = vol
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


  return <box 
    className="VolumeControls"
    vertical
    homogeneous
    valign={ Gtk.Align.END }
  >    

    <button 
      valign={ Gtk.Align.CENTER }
      className="ShowMixerButton"
      onClick={() => showVolumeMixer.set(!showVolumeMixer.get()) }
    >
      <box>
        <icon icon="multimedia-equalizer-symbolic" />
        <label label="Volume Mixer" />
      </box>
    </button>


    <box>
      <button valign={ Gtk.Align.CENTER } onClick={ toggleMute(mic) }>
        <icon icon={ bind(getIcon(mic)) }  />
      </button>
      <label 
        justify={ Gtk.Justification.CENTER }
        label={ bind(mic, "volume").as(v => `${Math.ceil(v * 100)}`) } 
      />
      <slider 
        hexpand
        onDragged={ ({value}) => mic.volume = value }
        value={ bind(mic, "volume") }
      />

    </box>
    
    <box>
      <button valign={ Gtk.Align.CENTER } onClick={ toggleMute(speaker) }>
        <icon icon={ bind(getIcon(speaker)) } />
      </button>
      <label 
        justify={ Gtk.Justification.CENTER }
        label={ bind(speaker, "volume").as(v => `${Math.ceil(v * 100)}`) }
      />
      <slider
        hexpand
        onDragged={ ({value}) => speaker.volume = value }
        value={ bind(speaker, "volume") }
      />

    </box>


  </box>

}

  // return Widget.Box({
  //   class_name: "volume container",
  //   vertical: true,
  //   spacing: Constants.MAIN_BOX_SPACING,
  //   children: [
  //     Title(),
  //
  //     // Microphone Widget
  //     Widget.Box({
  //       spacing: BOX_SPACING,
  //       children: [
  //         VolumeIndicator(
  //           AudioDeviceType.MICROPHONE,
  //           "microphone-sensitivity",
  //           [
  //             [50, 'high'],
  //             [1, 'medium'],
  //             [0, 'muted']
  //           ]
  //         ),
  //         VolumeNumber(AudioDeviceType.MICROPHONE),
  //         VolumeSlider(AudioDeviceType.MICROPHONE)
  //       ]
  //     }),
  //
  //     // Speaker Widget
  //     Widget.Box({
  //       spacing: BOX_SPACING,
  //       children: [
  //         VolumeIndicator(
  //           AudioDeviceType.SPEAKER,
  //           "audio-volume",
  //           [
  //             [67, 'high'],
  //             [34, 'medium'],
  //             [1, 'low'],
  //             [0, 'muted']
  //           ]
  //         ),
  //         VolumeNumber(AudioDeviceType.SPEAKER),
  //         VolumeSlider(AudioDeviceType.SPEAKER)
  //       ]
  //     }),
  //   ]
  // })

// export function MuteIndicators(monitor = 0) {
//
//   function MuteIcon(type) {
//
//     var icon = "microphone-sensitivity-muted-symbolic"
//     if (type === AudioDeviceType.SPEAKER) {
//       icon = "audio-volume-muted-symbolic"
//     } else {
//       icon = "microphone-sensitivity-muted-symbolic"
//     }
//
//     return Widget.Revealer({
//       revealChild: audio[type].bind("is_muted"),
//       transitionDuration: 200,
//       transition: "crossfade",
//         child: Widget.Icon({
//         class_name: "icon",
//         size: 36,
//         icon: icon,
//         tooltip_text: "Muted"
//       })
//     })
//
//   } 
//
//   // const merged = Utils.merge(
//   //     [
//   //       audio[AudioDeviceType.MICROPHONE].bind("is_muted"),
//   //       audio[AudioDeviceType.SPEAKER].bind("is_muted")
//   //     ],
//   //     (micMuted, speakerMuted) => { 
//   //       var icons = []
//   //       if (micMuted) icons.push([MuteIcon(AudioDeviceType.MICROPHONE)])
//   //       if (speakerMuted) return icons.push([MuteIcon(AudioDeviceType.SPEAKER)])
//   //       return icons
//   //     }
//   //   )
//
//   const icons = Widget.Box({
//     css: "min-width: 2px; min-height: 2px;", // Needed to keep the window alive
//     class_name: "muteindicators",
//     vertical: false,
//     children: [ 
//       MuteIcon(AudioDeviceType.SPEAKER),
//       MuteIcon(AudioDeviceType.MICROPHONE),
//     ]
//   })
//
//   return Widget.Window({
//     monitor: monitor,
//     name: `muteindicators`,
//     class_name: "muteindicatorswindow",
//     layer: 'overlay',
//     clickThrough: true,
//     keymode: "none",
//     anchor: ["top", "right"],
//     child: icons 
//   })


