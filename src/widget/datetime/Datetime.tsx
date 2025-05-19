import { Variable } from "astal";
import GLib from "gi://GLib?version=2.0";
import Gtk from "gi://Gtk?version=3.0";

function Time({ format = "%T" }) {
	const time = Variable("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(format)!
	)

	return <label
    className="Time"
    justify={Gtk.Justification.CENTER}
    hexpand
    onDestroy={() => time.drop()}
    label={time()}
  />
}

function Date({ format = "%B, %d, %Y" }) {
	const date = Variable("").poll(
		60000,
		() => GLib.DateTime.new_now_local().format(format)!
	)

	return <label 
    className="Date"
    justify={Gtk.Justification.CENTER}
    onDestroy={() => date.drop()}
    label={date()}
  />
}

export default function Datetime() {
	return (
		<box className="Datetime">
      <box vertical expand valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER}>
        <Time />
        <Date />
      </box>
		</box>
	);
}
