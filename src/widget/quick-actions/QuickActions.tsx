import { Gtk } from "astal/gtk3";
import { showVolumeMixer } from "../../data/config";

function QuickActionButton(label: string, onClick: () => void) {
  return <button className="quick-action-button" onClick={ onClick }>
    <label label={label} /> 
  </button>
}

export default function QuickActions() {
  return <box className="quick-actions" halign={Gtk.Align.FILL} hexpand>
    { QuickActionButton("Volume Mixer", () => showVolumeMixer.set(!showVolumeMixer.get())) }
    { QuickActionButton("Timers", () => print("Unsure button")) }
  </box>    
}

