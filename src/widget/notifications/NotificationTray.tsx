import { Astal, Gtk, Gdk } from "astal/gtk3"
import Notifd from "gi://AstalNotifd"
import Notification from "./Notification"
import { NotificationMap } from "./NotificationPopups"
import { type Subscribable } from "astal/binding"
import { Variable, bind, timeout } from "astal"

export default function NotificationTray() {
  const notifs = new NotificationMap((_) => {})

  return <box className="NotificationTray" vertical>
    {bind(notifs)}
  </box>
}
