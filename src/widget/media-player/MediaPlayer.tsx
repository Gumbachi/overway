import { Astal, Gtk } from "astal/gtk3"
import Mpris from "gi://AstalMpris"
import { bind, derive, Variable } from "astal"

function lengthStr(length: number) {
  const min = Math.floor(length / 60)
  const sec = Math.floor(length % 60)
  const sec0 = sec < 10 ? "0" : ""
  return `${min}:${sec0}${sec}`
}

function MediaPlayerSwitcher({ selected, playerCount, onSelected }: { selected: number, playerCount: number, onSelected: (i: number) => void }) {
  return <box className="switcher" vertical valign={ Gtk.Align.CENTER }>
    { [...Array(playerCount).keys()].map(i => (
      <button 
        className={ selected == i ? "selected" : "unselected" }
        onClicked={ () => onSelected(i) }
        halign={ Gtk.Align.CENTER }
        valign={ Gtk.Align.CENTER }
      />
    )) }
  </box>
}


function MediaPlayer({ player }: { player: Mpris.Player }) {

  const { START, END, CENTER } = Gtk.Align

  const title = bind(player, "title").as(t => t || "Unknown Track")

  const artist = bind(player, "artist").as(a => a || "Unknown Artist")

  const coverArt = bind(player, "coverArt").as(c => `background-image: url('${c}')`)

  const playerIcon = bind(player, "entry").as(e =>
    Astal.Icon.lookup_icon(e) ? e : "audio-x-generic-symbolic")

  const position = bind(player, "position").as(p => player.length > 0 
    ? p / player.length : 0)

  const playIcon = bind(player, "playbackStatus").as(s =>
    s === Mpris.PlaybackStatus.PLAYING
      ? "media-playback-pause-symbolic"
      : "media-playback-start-symbolic"
  )

    return <box className="MediaPlayer">

      <box className="cover-art" css={coverArt} valign={CENTER} />

      <box vertical>

        <box className="title">
          <label truncate hexpand halign={START} label={title} />
          <icon icon={playerIcon}/>
        </box>

        <label halign={START} valign={START} vexpand wrap label={artist} />
        <slider
          visible={bind(player, "length").as(l => l > 0)}
          onDragged={({ value }) => player.position = value * player.length}
          value={position}
        />

        <centerbox className="actions">

          <label
            className="position"
            halign={START}
            visible={bind(player, "length").as(l => l > 0)}
            label={bind(player, "position").as(lengthStr)}
          />

          <box>

            <button
              onClicked={() => player.previous()}
              visible={bind(player, "canGoPrevious")}
            >
              <icon icon="media-skip-backward-symbolic" />
            </button>

            <button
              onClicked={() => player.play_pause()}
              visible={bind(player, "canControl")}
            >
              <icon icon={playIcon} />
            </button>

            <button
              onClicked={() => player.next()}
              visible={bind(player, "canGoNext")}
            >
              <icon icon="media-skip-forward-symbolic" />
            </button>

          </box>

          <label
              className="length"
              halign={END}
              visible={bind(player, "length").as(l => l > 0)}
              label={bind(player, "length").as(l => l > 0 ? lengthStr(l) : "0:00")}
          />
        </centerbox>

      </box>
    </box>
}

type MprisValue = { selected: number, players: Mpris.Player[] }

export default function MprisPlayers() {
  const mpris = Mpris.get_default()
  const playerIndex = Variable(0)

  const values: Variable<MprisValue> = Variable.derive(
    [bind(playerIndex), bind(mpris, "players")],
    (selected, players) => ({ selected, players })
  )

  return <box className="MprisPlayers" valign={ Gtk.Align.END }>
    { 
      bind(values)
        .as(v => ({
          "selected": v.selected,
          "players": v.players.filter( player => !player.busName.endsWith("playerctld") )  
        }))
        .as(v => (
          <box>
            <MediaPlayerSwitcher
              selected={ v.selected }
              playerCount={ v.players.length }
              onSelected={ value => playerIndex.set(value) }
            />
            <MediaPlayer player={ v.players[v.selected] }/>
          </box>
        ))
    } 
  </box>
}

