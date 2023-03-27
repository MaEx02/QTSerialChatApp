import QtQuick 2.10
import QtQuick.Controls 2.15
import QtQuick.Window 2.3
ApplicationWindow{
    id:root
    height: 100
    width: 400
    maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width
    background: Rectangle {
        color: "#dbc1ac"
    }
    Row{
        padding: 20
        spacing: 20
        CustomText{
            id: nameText
            width: 250
            height: 40
            placeholderText: qsTr("Kullanıcı Adınız")
        }
        NewButton{
            id: sendButton
            width: 85
            height: 40
            text: qsTr("Tamamla")
            onClicked: {
                mainWindow.name = nameText.text;
                root.close();
            }
        }
    }

}
