import { exec } from "astal";

export default function RotateWallpaperButton(): JSX.Element {
  return (
    <button
      onClicked={() => {
        exec('bash -c "waypaper --random > /dev/null"');
      }}
      iconName="preferences-desktop-wallpaper-symbolic"
    />
  );
}
