import InhibitIdleButton from "./IdleInhibitor";
import { NightlightButton } from "./Nightlight";
import { LockButton, RestartButton, ShutdownButton } from "./Power";
import RotateWallpaperButton from "./RotateWallpaper";

export default function SystemControls() {
	return <box className="SystemControls WidgetContainer" homogeneous>
    <RotateWallpaperButton />
    <NightlightButton />
    <InhibitIdleButton />
    <LockButton />
    <RestartButton />
    <ShutdownButton />
  </box>
}
