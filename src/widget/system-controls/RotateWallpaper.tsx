import { Gtk } from "astal/gtk3";

export default function RotateWallpaperButton(): JSX.Element {
  // return <button onClicked={ exec('bash -c "waypaper --random > /dev/null"') }>
  return <button 
    onClicked='bash -c "waypaper --random > /dev/null"'
    valign={ Gtk.Align.CENTER }
    halign={ Gtk.Align.CENTER }
  >
    <icon icon="preferences-desktop-wallpaper-symbolic" />
  </ button>
}
