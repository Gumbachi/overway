pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {

    readonly property var shutdown: Process {
        command: ["sh", "-c", "loginctl lock-session"]
    }


}    

