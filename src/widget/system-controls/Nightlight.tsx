import { Gtk } from "astal/gtk3";

export function NightlightButton() {
  return <button 
    onClicked="echo disabling/enable nightlight"
    valign={ Gtk.Align.CENTER }
    halign={ Gtk.Align.CENTER }
  >
    <icon icon="weather-clear-night-symbolic" />
  </button>
}
