import { Gtk } from "ags/gtk4";
import InhibitIdleButton from "./IdleInhibitor";
import { NightlightButton } from "./Nightlight";
import { LockButton, RestartButton, ShutdownButton } from "./Power";

export default function SystemControls() {
	return <box class="system-controls">
    <NightlightButton />
    <InhibitIdleButton />
    <Gtk.Separator
      visible
      margin_top={15}
      margin_bottom={15}
      margin_start={5}
      margin_end={5}
      width_request={2}
    />
    <LockButton />
    <RestartButton />
    <ShutdownButton />
  </box>
}
