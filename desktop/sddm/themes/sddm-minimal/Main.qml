import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "#1a1b26"
    property bool authenticating: false
    property bool optionsVisible: false
    property string errorText: ""
    property string username: userModel.lastUser || config.defaultUser || "przvl"
    property int selectedSession: sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : 0
    function login() {
        if (authenticating || password.text.length === 0) return
        errorText = ""
        authenticating = true
        sddm.login(username, password.text, selectedSession)
    }
    Image {
        anchors.fill: parent
        source: Qt.resolvedUrl(config.background)
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        y: Math.round((parent.height - height) * 0.53)
        width: Math.min(360, root.width - 48)
        spacing: 12
        Rectangle {
            width: parent.width
            height: 56
            radius: 14
            color: "#e61a1b26"
            border.width: 1
            border.color: password.activeFocus ? "#889fe3c4" : "#4434324a"
            TextField {
                id: password
                anchors.left: parent.left
                anchors.right: submit.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 12
                color: "#eeeeee"
                placeholderText: root.authenticating ? "Signing in…" : "Password"
                placeholderTextColor: "#aaaaaa"
                echoMode: TextInput.Password
                passwordCharacter: "•"
                font.pixelSize: 16
                selectByMouse: true
                enabled: !root.authenticating
                background: Item {}
                onAccepted: root.login()
                Component.onCompleted: forceActiveFocus()
                Keys.onEscapePressed: { text = ""; root.errorText = "" }
            }
            Button {
                id: submit
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 7
                width: 42
                height: 42
                enabled: !root.authenticating && password.text.length > 0
                onClicked: root.login()
                background: Rectangle { radius: 10; color: submit.hovered ? "#293b38" : "transparent" }
                contentItem: Text {
                    text: "→"
                    color: submit.enabled ? "#9fe3c4" : "#777777"
                    font.pixelSize: 24
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
        Text {
            width: parent.width
            visible: root.errorText.length > 0
            text: root.errorText
            color: "#f7768e"
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }
        Column {
            visible: root.optionsVisible
            width: parent.width
            spacing: 8
            TextField {
                width: parent.width
                text: root.username
                placeholderText: "Username"
                onTextEdited: root.username = text
            }
            ComboBox {
                width: parent.width
                model: sessionModel
                textRole: "name"
                currentIndex: root.selectedSession
                onActivated: root.selectedSession = currentIndex
            }
        }
    }
    Shortcut { sequence: "F2"; onActivated: root.optionsVisible = !root.optionsVisible }
    Connections {
        target: sddm
        function onLoginFailed() {
            root.authenticating = false
            password.text = ""
            root.errorText = "Password incorrect. Try again."
            password.forceActiveFocus()
        }
        function onLoginSucceeded() { root.errorText = "" }
        function onInformationMessage(message) { root.errorText = message }
    }
}
