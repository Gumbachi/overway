import { createState } from "ags";
import { Gtk } from "ags/gtk4";
import { exec } from "ags/process";

const OPEN_EYE = "xapp-prefs-display-symbolic";
const CLOSED_EYE = "image-red-eye-symbolic";

export default function InhibitIdleButton(): JSX.Element {
	function isHypridleRunning(): Boolean {
    try {
      return exec("systemctl is-active --user hypridle") == "active"
    } catch {
      return false
    }
	}

	function toggleHypridle() {
		if (isHypridleRunning()) {
			exec("systemctl stop --user hypridle");
		} else {
			exec("systemctl start --user hypridle");
		}
	}

	const [icon, setIcon] = createState(isHypridleRunning() ? CLOSED_EYE : OPEN_EYE);

	return <button
    onClicked={() => {
      toggleHypridle();
      setIcon(isHypridleRunning() ? CLOSED_EYE : OPEN_EYE);
    }}
    valign={ Gtk.Align.CENTER }
    halign={ Gtk.Align.CENTER } 
  >
    <image iconName={icon} />
  </button>
}
