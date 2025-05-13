import InhibitIdleButton from "./IdleInhibitor";
import { NightlightButton } from "./Nightlight";
import { LockButton, RestartButton, ShutdownButton } from "./Power";
import RotateWallpaperButton from "./RotateWallpaper";

export default function SystemControls() {
	return <box className="SystemControls WidgetContainer" homogeneous>
    <NightlightButton />
    <InhibitIdleButton />
    <LockButton />
    <RestartButton />
    <ShutdownButton />
  </box>
}
