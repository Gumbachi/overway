import { exec, execAsync, subprocess, Variable } from "astal"

const OPEN_EYE = 'xapp-prefs-display-symbolic'
const CLOSED_EYE = 'image-red-eye-symbolic'

export function RestartButton(): JSX.Element {
  return <button 
    onClicked = "systemctl reboot"
    iconName = "system-reboot-symbolic"/>
}

export function ShutdownButton(): JSX.Element {
  return <button 
    onClicked = "systemctl poweroff"
    iconName = "system-shutdown-symbolic"/>
}

export function RotateWallpaperButton(): JSX.Element {
  return <button
    onClicked = { () => { exec('bash -c "waypaper --random > /dev/null"') } }
    iconName = "preferences-desktop-wallpaper-symbolic"
  />
}

export function InhibitIdleButton(): JSX.Element {

  function isHypridleRunning(): Boolean {
    try {
      exec("pidof hypridle")
      return true
    } catch {
      return false
    }
  } 

  function toggleHypridle() {
    // The below line caused the program to hang idk why
    // Just leaving it here in case I try to one line it again
    // exec('bash -c "pkill hypridle || hypridle & disown"')

    if (isHypridleRunning()) {
      exec("pkill hypridle")
    } else {
      subprocess("hypridle -q")
    }
  }

  const icon = Variable(isHypridleRunning() ? CLOSED_EYE : OPEN_EYE)

  return <button 
    iconName = { icon(String) }
    onClicked = { () => {
      toggleHypridle()
      icon.set(isHypridleRunning() ? CLOSED_EYE : OPEN_EYE)
    }}/>
}

