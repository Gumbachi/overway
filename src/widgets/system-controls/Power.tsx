import { Gtk } from "ags/gtk4"
import { exec } from "ags/process"

export function LockButton() {
	return <button
    onClicked={() => exec("loginctl lock-session")}
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER}
  >
    <image iconName="system-lock-screen-symbolic" />
  </button>
}

export function RestartButton() {
	return <button
    onClicked={() => exec("systemctl reboot")}
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER}
  >
    <image iconName="system-reboot-symbolic" />
  </button>
}

export function ShutdownButton() {
	return <button
    onClicked={() => exec("systemctl poweroff")}
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER}
  >
    <image iconName="system-shutdown-symbolic" />
  </button>
}
