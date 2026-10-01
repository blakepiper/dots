import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.ksysguard.sensors as Sensors
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root
    Layout.minimumWidth: metrics.advanceWidth(memoryText) + 16
    Layout.preferredWidth: metrics.advanceWidth(memoryText) + 16
    Layout.maximumWidth: metrics.advanceWidth(memoryText) + 16
    Layout.fillHeight: true
    preferredRepresentation: fullRepresentation
    toolTipMainText: "CPU usage"
    toolTipSubText: memoryText
    readonly property string memoryText: "CPU: " + Number(used.value || 0).toFixed(0) + "%"
    FontMetrics { id: metrics; font: Kirigami.Theme.defaultFont }
    Sensors.Sensor { id: used; sensorId: "cpu/all/usage"; updateRateLimit: 5000 }
    function gib(value) { return (Number(value) / 1073741824).toFixed(1) }
    fullRepresentation: PlasmaComponents.Label {
        id: readout
        text: root.memoryText
        color: "#e0af68"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
