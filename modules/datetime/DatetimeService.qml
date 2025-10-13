import Quickshell
import QtQuick

Scope {

    readonly property string time: {
        return Qt.formatDateTime(clock.date, "hh:mm:ss")
    }

    readonly property string date: {
        return Qt.formatDateTime(clock.date, "ddd MMMM, d, yyyy")
    }
    
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

}
