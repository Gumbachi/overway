import { bind, exec, Variable } from "astal";
import { Gtk } from "astal/gtk3";

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

  const icon = Variable(nightlightStatus() ? MOON : SUN)

  return <button 
    valign={ Gtk.Align.CENTER }
    halign={ Gtk.Align.CENTER }
    onClicked={ () => {
      toggleNightlight()
      icon.set(nightlightStatus() ? MOON : SUN)
    }}
  >
    <icon icon={ bind(icon) } />
  </button>
}

