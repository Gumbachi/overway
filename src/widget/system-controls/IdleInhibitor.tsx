import { exec, subprocess, Variable } from "astal";

const OPEN_EYE = "xapp-prefs-display-symbolic";
const CLOSED_EYE = "image-red-eye-symbolic";

export default function InhibitIdleButton(): JSX.Element {
	function isHypridleRunning(): Boolean {
		try {
			exec("pidof hypridle");
			return true;
		} catch {
			return false;
		}
	}

	function toggleHypridle() {
		// The below line caused the program to hang idk why
		// Just leaving it here in case I try to one line it again
		// exec('bash -c "pkill hypridle || hypridle & disown"')

		if (isHypridleRunning()) {
			exec("pkill hypridle");
		} else {
			subprocess("hypridle -q");
		}
	}

	const icon = Variable(isHypridleRunning() ? CLOSED_EYE : OPEN_EYE);

	return <button
    className="IdleInhibitor"
    onClicked={() => {
      toggleHypridle();
      icon.set(isHypridleRunning() ? CLOSED_EYE : OPEN_EYE);
    }}
  >
    <icon icon={icon(String)} />
  </button>
}
