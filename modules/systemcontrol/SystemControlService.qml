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


    property bool isNightlightRunning: true

    readonly property var toggleNightlight: Process {
        command: ["sh", "./scripts/toggle-wlsunset.sh"]
        stdout: StdioCollector {
            onStreamFinished: {
                console.log(`Wlsunset: ${this.text}`)
                root.isNightlightRunning = this.text === "started"
            }
        }
    }

    // Get idle status on program start
    Process {
        command: ["sh", "-c", "systemctl is-active --user wlsunset"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.isNightlightRunning = this.text.trim() === "active"
        }
    }



    property bool isIdleRunning: true

    readonly property var toggleIdle: Process {
        command: ["sh", "./scripts/toggle-hypridle.sh"]
        stdout: StdioCollector {
            onStreamFinished: {
                console.log(`Hypidle: ${this.text}`)
                root.isIdleRunning = this.text === "started"
            }
        }
    }

    // Get idle status on program start
    Process {
        command: ["sh", "-c", "systemctl is-active --user hypridle"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.isIdleRunning = this.text.trim() === "active"
        }
    }
}
