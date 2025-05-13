import { bind, exec, Variable } from "astal";
import { Gtk } from "astal/gtk3";

export function NightlightButton() {
	function hyprsunsetStatus(): Boolean {
    try {
      return exec("systemctl is-active --user hyprsunset") == "active"
    } catch {
      return false
    }
	}

  function toggleHyprsunset() {
    
		if (hyprsunsetStatus()) {
			exec("systemctl stop --user hyprsunset");
		} else {
			exec("systemctl start --user hyprsunset");
		}
	}

  const SUN = "weather-clear-symbolic"
  const MOON = "weather-clear-night-symbolic"

  const icon = Variable(hyprsunsetStatus() ? MOON : SUN)

  return <button 
    valign={ Gtk.Align.CENTER }
    halign={ Gtk.Align.CENTER }
    onClicked={ () => {
      toggleHyprsunset()
      icon.set(hyprsunsetStatus() ? MOON : SUN)
    }}
  >
    <icon icon={ bind(icon) } />
  </button>
}

