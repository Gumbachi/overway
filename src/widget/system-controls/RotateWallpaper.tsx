import { exec } from "astal";

export default function RotateWallpaperButton(): JSX.Element {
  // return <button onClicked={ exec('bash -c "waypaper --random > /dev/null"') }>
  return <button onClicked='bash -c "waypaper --random > /dev/null"'>
    <icon icon="preferences-desktop-wallpaper-symbolic" />
  </ button>
}
