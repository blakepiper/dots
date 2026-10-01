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
    toolTipMainText: "Physical memory"
    toolTipSubText: memoryText
    readonly property string memoryText: total.value > 0 ? "RAM: " + root.gib(used.value) + "/" + root.gib(total.value) + " GiB" : "RAM: …"
    FontMetrics { id: metrics; font: Kirigami.Theme.defaultFont }
    Sensors.Sensor { id: used; sensorId: "memory/physical/used"; updateRateLimit: 5000 }
    Sensors.Sensor { id: total; sensorId: "memory/physical/total"; updateRateLimit: 5000 }
    function gib(value) { return (Number(value) / 1073741824).toFixed(1) }
    fullRepresentation: PlasmaComponents.Label {
        id: readout
        text: root.memoryText
        color: "#7aa2f7"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
