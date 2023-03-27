import QtQuick 2.10
import QtQuick.Controls 2.15
import QtQuick 2.0
Button {
    width: 90
    height: 25
    background: Rectangle {
        radius: 10
        color: parent.hovered ? "#d8c5a6" : "#ece0d1"
        border.color: "black"
        border.width: 1
    }
}
