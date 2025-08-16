import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: root

    readonly property var shutdown: Process {
        command: ["sh", "-c", "systemctl poweroff"]
    }

    readonly property var restart: Process {
        command: ["sh", "-c", "systemctl reboot"]
    }

    readonly property var lock: Process {
        command: ["sh", "-c", "loginctl lock-session"]
    }

    readonly property var killIdle: Process {
        command: ["sh", "-c", "systemctl stop --user hypridle"] 
    }
    readonly property var startIdle: Process {
        command: ["sh", "-c", "systemctl start --user hypridle"] 
    }

    property bool isIdleRunning: true

    readonly property var checkIdle: Process {
        command: ["sh", "-c", "systemctl is-active --user hypridle"] 
        running: true
        stdout: StdioCollector {
            onStreamFinished:  root.isIdleRunning = this.text === "active"
        }
    }
}    

