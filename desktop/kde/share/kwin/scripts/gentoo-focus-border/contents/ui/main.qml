import QtQuick
import QtQuick.Window
import org.kde.kwin

Window {
    id: outline
    readonly property var focusedWindow: Workspace.activeWindow
    readonly property bool showBorder: focusedWindow !== null
        && focusedWindow.normalWindow && !focusedWindow.minimized
        && !focusedWindow.fullScreen
    readonly property rect frame: focusedWindow ? focusedWindow.frameGeometry : Qt.rect(0, 0, 0, 0)

    flags: Qt.BypassWindowManagerHint | Qt.FramelessWindowHint
        | Qt.WindowDoesNotAcceptFocus | Qt.WindowTransparentForInput
    color: "transparent"
    x: frame.x
    y: frame.y
    width: Math.max(1, frame.width)
    height: Math.max(1, frame.height)
    visible: showBorder

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: "#3daee9"
        border.width: 2
        radius: 0
    }
}
