import { Gtk } from "astal/gtk3";

export function LockButton() {
	return <button
    onClicked="hyprlock"
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER}
  >
    <icon icon="system-lock-screen-symbolic" />
  </button>
}

export function RestartButton() {
	return <button
    onClicked="systemctl reboot"
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER}
  >
    <icon icon="system-reboot-symbolic" />
  </button>
}

export function ShutdownButton() {
	return <button
    onClicked="systemctl poweroff"
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER}
  >
    <icon icon="system-shutdown-symbolic" />
  </button>
}
