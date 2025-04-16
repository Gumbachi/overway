export function RestartButton() {
	return <button onClicked="systemctl reboot">
    <icon icon="system-reboot-symbolic" />
  </button>
}

export function ShutdownButton() {
  return <button onClicked="systemctl poweroff">
    <icon icon="system-shutdown-symbolic" />
  </button>
}
