import { createState } from "ags";
import { Gtk } from "ags/gtk4";
import { exec } from "ags/process";

const nightlightService = "wlsunset"

export function NightlightButton() {
	function nightlightStatus(): Boolean {
    try {
      return exec(`systemctl is-active --user ${nightlightService}`) == "active"
    } catch {
      return false
    }
	}

  function toggleNightlight() { 
		if (nightlightStatus()) {
			exec(`systemctl stop --user ${nightlightService}`);
		} else {
			exec(`systemctl start --user ${nightlightService}`);
		}
	}

  const SUN = "weather-clear-symbolic"
  const MOON = "weather-clear-night-symbolic"

  const [icon, setIcon] = createState(nightlightStatus() ? MOON : SUN)

  return <button 
    valign={ Gtk.Align.CENTER }
    halign={ Gtk.Align.CENTER }
    onClicked={ () => {
      toggleNightlight()
      setIcon(nightlightStatus() ? MOON : SUN)
    }}
  >
    <image iconName={ icon } />
  </button>
}

