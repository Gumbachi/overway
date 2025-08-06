import { Gtk } from "ags/gtk4"
import { createPoll } from "ags/time"
import GLib from "gi://GLib?version=2.0"

function Time({ format = "%T" }) {
	const time = createPoll("", 1000, () => GLib.DateTime.new_now_local().format(format)!)

	return <label
    class="time"
    justify={Gtk.Justification.CENTER}
    hexpand
    label={time}
  />
}

function Date({ format = "%B, %d, %Y" }) {
	const date = createPoll("", 60000, () => GLib.DateTime.new_now_local().format(format)!)

	return <label 
    class="date"
    justify={Gtk.Justification.CENTER}
    label={date}
  />
}

export default function Datetime() {
	return <box class="datetime">
    <box hexpand vexpand orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER}>
      <Time />
      <Date />
    </box>
  </box>
}
