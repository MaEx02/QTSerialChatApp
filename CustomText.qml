import QtQuick 2.10
import QtQuick.Controls 2.0
TextField {
    background: Rectangle{
        color: "#ece0d1"
        border.width: 1
        border.color: "black"
        radius: 10
    }
    placeholderText: ""
    onTextChanged: {
        console.log(text)
    }
}
