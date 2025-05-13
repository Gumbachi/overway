import { bind, monitorFile, Variable } from "astal"
import { Gtk } from "astal/gtk3"
import { TextView } from "../../custom/TextView"

const widgets: Variable<Array<Gtk.Widget>> = Variable([])

function SimpleCounter(label: string = "Counter"): JSX.Element { 
  const counter = Variable(0)

  function AddButton(value: number) {
    return <button onClick={ () => counter.set(counter.get() + value) }>
      <label 
        label={ value >= 0 ? `+${value}` : `${value}`}
        halign={Gtk.Align.CENTER}
        valign={Gtk.Align.CENTER}
        justify={Gtk.Justification.CENTER}
      />
    </button> 
  }

  const widget = <box className="simple-counter" vertical>
    { Header(label, () => counter.set(0), () => widget.destroy()) }
    <box className="counter">
      { AddButton(-20) }
      { AddButton(-5) }
      { AddButton(-1) } 
      <label className="value" label={bind(counter).as(String)} />
      { AddButton(1) }
      { AddButton(5) }
      { AddButton(20) } 
    </box>
  </box>

  return widget
}


function SimpleNote(label: string = "Quick Note") { 

  const widget = <box className="simple-note" vertical vexpand>
      { Header(label, () => print("reset textbox to nothing"), () => widget.destroy()) }
      <centerbox className="note-container" vexpand >
        <TextView 
          className="note"
          hexpand
          wrapMode={Gtk.WrapMode.WORD_CHAR}
        />
      </centerbox>
    </box>

  return widget
}



function Header(title: string, reset: () => void, destroy: () => void) {
  const showControls = Variable(true)

  const ebox = <eventbox
    onHover={ () => showControls.set(true) }
    onHoverLost={ () => showControls.set(true) }
  >
    <box className="header" halign={Gtk.Align.FILL}>
      <label label={title} hexpand halign={Gtk.Align.START} />
      <button onClick={ reset } halign={Gtk.Align.END} visible={ bind(showControls) }>
        <icon icon="edit-clear-all-symbolic"/>
      </button>
      <button onClick={ () => destroy } halign={Gtk.Align.END} visible={ bind(showControls) }>
        <icon icon="edit-delete-symbolic"/>
      </button>
    </box>
  </eventbox>
  return ebox
}

function AddActions() {
  
  return <box 
    className="add-actions"
    homogeneous
    valign={Gtk.Align.END}
  >

    <button onClick={ () => widgets.set(widgets.get().concat([SimpleNote()])) }>
      <icon icon="edit-symbolic" />
    </button>

    <button onClick={ () => widgets.set(widgets.get().concat([SimpleCounter()]))  }>
      <icon icon="numlock-enabled-symbolic" />
    </button>

    <button onClick={ () => print(widgets.get())  }>
      <icon icon="numlock-enabled-symbolic" />
    </button>

  </box>
}

export default function Scratchpad() {
  return <box className="scratchpad" vertical>
    <box vertical>
      { SimpleCounter("Counter") }
      { SimpleNote("Notes") }
      { bind(widgets) }
    </box>
  </box>
}
