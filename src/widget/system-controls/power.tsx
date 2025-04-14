export function RestartButton(): JSX.Element {
  return (
    <button onClicked="systemctl reboot" iconName="system-reboot-symbolic" />
  );
}

export function ShutdownButton(): JSX.Element {
  return (
    <button
      onClicked="systemctl poweroff"
      iconName="system-shutdown-symbolic"
    />
  );
}
