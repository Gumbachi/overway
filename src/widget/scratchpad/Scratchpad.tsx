import { bind, Gio, Variable } from "astal"
import { Gdk, Gtk } from "astal/gtk3"
import { TextView } from "../../custom/TextView"

function SimpleCounter(label: string = "Counter"): JSX.Element { 
  const counter = Variable(0)
  const showActions = Variable(false)

  function IncrementButton(value: number) {
    return <button onClicked={ () => counter.set(counter.get() + value) }>
      <label 
        label={ value >= 0 ? `+${value}` : `${value}`}
        halign={Gtk.Align.CENTER}
        valign={Gtk.Align.CENTER}
        justify={Gtk.Justification.CENTER}
      />
    </button> 
  }

  return <eventbox 
    onHover={ () => showActions.set(true) }
    onHoverLost={ () => showActions.set(false) }
  >
    <box className="simple-counter" vertical>
      { Header(
        label,
        (
          <button visible={ showActions() } onClicked={ () => counter.set(0) }>
            <icon icon="view-refresh-symbolic"/>
          </button>
        )
      ) }
      <box className="counter">
        { IncrementButton(-20) }
        { IncrementButton(-5) }
        { IncrementButton(-1) } 
        <label className="value" label={bind(counter).as(String)} />
        { IncrementButton(1) }
        { IncrementButton(5) }
        { IncrementButton(20) } 
      </box>
    </box>
  </eventbox>
}


function SimpleNote(label: string = "Quick Note") { 
  const showActions = Variable(false)
  const buffer = Variable(new Gtk.TextBuffer())

  return <eventbox 
    onHover={ () => showActions.set(true) }
    onHoverLost={ () => showActions.set(false) }
  >
    <box className="simple-note" vertical vexpand>
      { Header(
        label, 
        (
          <box visible={ showActions() }>
            <button onClicked={ () => print("save") }>
              <icon icon="document-save-symbolic"/>
            </button>
            
            <button onClicked={ () => buffer.set(new Gtk.TextBuffer()) }>
              <icon icon="view-refresh-symbolic"/>
            </button>
          </box>
        )
      )}
      <centerbox className="note-container" vexpand >
        <TextView 
          className="note"
          hexpand
          wrapMode={Gtk.WrapMode.WORD_CHAR}
          buffer={ buffer() }
        />
      </centerbox>
    </box>
  </eventbox>
}



function Header(title: string, actions: JSX.Element) {
  return <box className="header" halign={Gtk.Align.FILL}>
    <label label={title} hexpand halign={Gtk.Align.START} />
    { actions }
  </box>
}

export default function Scratchpad() {
  return <box className="scratchpad" vertical>
    <box vertical>
      { SimpleCounter("Counter") }
      { SimpleNote("Notes") }
    </box>
  </box>
}
