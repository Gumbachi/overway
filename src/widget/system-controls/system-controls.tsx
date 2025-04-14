import InhibitIdleButton from "./idle-inhibitor";
import { NightlightButton } from "./nightlight";
import { RestartButton, ShutdownButton } from "./power";
import RotateWallpaperButton from "./wallpaper";

export default function SystemControls(): JSX.Element {
  return (
    <box cssClasses={["SystemControls"]}>
      <RotateWallpaperButton />
      <NightlightButton />
      <InhibitIdleButton />
      <RestartButton />
      <ShutdownButton />
    </box>
  );
}
