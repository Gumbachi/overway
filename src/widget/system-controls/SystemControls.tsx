import { Gtk } from "astal/gtk3";
import InhibitIdleButton from "./IdleInhibitor";
import { NightlightButton } from "./Nightlight";
import { RestartButton, ShutdownButton } from "./Power";
import RotateWallpaperButton from "./RotateWallpaper";

export default function SystemControls() {
	return <box className="SystemControls WidgetContainer" homogeneous> 
    <RotateWallpaperButton />
    <NightlightButton />
    <InhibitIdleButton />
    <RestartButton />
    <ShutdownButton />
  </box>
}
