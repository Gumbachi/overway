import { Accessor, createBinding, createComputed, createState, For } from "ags"
import { Gtk } from "ags/gtk4"
import Astal30 from "gi://Astal"
import Astal from "gi://Astal?version=4.0"
import AstalMpris from "gi://AstalMpris?version=0.1"

function lengthStr(length: number) {
  const min = Math.floor(length / 60)
  const sec = Math.floor(length % 60)
  const sec0 = sec < 10 ? "0" : ""
  return `${min}:${sec0}${sec}`
}

function NothingPlaying() {
  return <label
    class="nothing-playing"
    vexpand hexpand label="Nothing Playing"
    wrap
    halign={Gtk.Align.CENTER}
    valign={Gtk.Align.CENTER}
    justify={Gtk.Justification.CENTER}
  />
}

function MediaPlayerSwitcher({ selected, playerCount, onSelected }: { selected: number, playerCount: number, onSelected: (i: number) => void }) {
  return <box class="switcher" orientation={Gtk.Orientation.VERTICAL} valign={ Gtk.Align.CENTER }>
    { [...Array(playerCount).keys()].map(i => (
      <button 
        class={ selected == i ? "selected" : "unselected" }
        onClicked={ () => onSelected(i) }
        halign={ Gtk.Align.CENTER }
        valign={ Gtk.Align.CENTER }
      />
    )) }
  </box>
}

function MediaPlayer({ player }: { player: AstalMpris.Player }) {

  const { START, END, CENTER } = Gtk.Align

  const title = createBinding(player, "title").as(t => t || "Unknown Track")

  const artist = createBinding(player, "artist").as(a => a || "Unknown Artist")

  const coverArt = createBinding(player, "coverArt").as(c => `background-image: url('${c}')`)

  const playerIcon = createBinding(player, "entry").as(e => "audio-x-generic-symbolic")

  const position = createBinding(player, "position").as(p => player.length > 0 
    ? p / player.length : 0)

  const playIcon = createBinding(player, "playbackStatus").as(s =>
    s === AstalMpris.PlaybackStatus.PLAYING
      ? "media-playback-pause-symbolic"
      : "media-playback-start-symbolic"
  )

    return <box class="MediaPlayer">

      <box class="cover-art" css={coverArt} valign={CENTER} />

      <box orientation={Gtk.Orientation.VERTICAL}>

        <box class="title">
          <label hexpand halign={START} label={title} />
          <image iconName={playerIcon}/>
        </box>

        <label halign={START} valign={START} vexpand wrap label={artist} />
        <slider
          visible={createBinding(player, "length").as(l => l > 0)}
          onMoveSlider={({ value }) => player.position = value * player.length}
          value={position}
        />

        <centerbox class="actions">

          <label
            class="position"
            halign={START}
            visible={createBinding(player, "length").as(l => l > 0)}
            label={createBinding(player, "position").as(lengthStr)}
          />

          <box>

            <button
              onClicked={() => player.previous()}
              visible={createBinding(player, "canGoPrevious")}
            >
              <image iconName="media-skip-backward-symbolic" />
            </button>

            <button
              onClicked={() => player.play_pause()}
              visible={createBinding(player, "canControl")}
            >
              <image iconName={playIcon} />
            </button>

            <button
              onClicked={() => player.next()}
              visible={createBinding(player, "canGoNext")}
            >
              <image iconName="media-skip-forward-symbolic" />
            </button>

          </box>

          <label
              class="length"
              halign={END}
              visible={createBinding(player, "length").as(l => l > 0)}
              label={createBinding(player, "length").as(l => l > 0 ? lengthStr(l) : "0:00")}
          />
        </centerbox>

      </box>
    </box>
}

type MprisValue = { selected: number, players: AstalMpris.Player[] }

export default function MprisPlayers() {
  const mpris = AstalMpris.get_default()
  const [playerIndex, _] = createState(0)

  return <NothingPlaying />

  const values: Accessor<MprisValue> = createComputed(
    [playerIndex, createBinding(mpris, "players")],
    (selected, players) => ({ selected, players })
  )

  // return <box class="MprisPlayers" valign={ Gtk.Align.END }>
  //   { 
  //     createBinding(values).as(v => ({
  //       "selected": v.selected,
  //       "players": v.players.filter( player => !player.busName.endsWith("playerctld") )  
  //     })).as(v => {
  //       if (v.players.length > 0)
  //         return <box>
  //           <MediaPlayerSwitcher
  //             selected={ v.selected }
  //             playerCount={ v.players.length }
  //             onSelected={ value => playerIndex.set(value) }
  //           /> 
  //           <MediaPlayer player={ v.players[v.selected] }/>
  //         </box>  
  //       return (<NothingPlaying />)
  //     }) 
  //   } 
  // </box>

  // return <box class="MprisPlayers" valign={ Gtk.Align.END }>
  //   { 
  //     createBinding(values).as(v => ({
  //       "selected": v.selected,
  //       "players": v.players.filter( player => !player.busName.endsWith("playerctld") )  
  //     })).as(v => {
  //       if (v.players.length > 0)
  //         return <box>
  //           <MediaPlayerSwitcher
  //             selected={ v.selected }
  //             playerCount={ v.players.length }
  //             onSelected={ value => playerIndex.set(value) }
  //           /> 
  //           <MediaPlayer player={ v.players[v.selected] }/>
  //         </box>  
  //       return (<NothingPlaying />)
  //     }) 
  //   } 
  // </box>
}

