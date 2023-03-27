import QtQuick 2.10
import QtQuick.Window 2.15
import MyApp 1.0
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.3
ApplicationWindow {
    property string name: myClass.getUserName()
    property string message: ""
    property string senderName: ""
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Seri Port Haberleşme")
    background: Rectangle {
        color: "#dbc1ac"
    }
    menuBar: MenuBar {
        id: menuBari
        background: Rectangle {
            color: "#967259"
        }
        Menu {
            title: qsTr("Bağlantı")
            MenuBarItem {
                text: qsTr("Bağlantıları Göster")
                onClicked: {
                    outputText.text +=  myClass.avaibleSerialPorts()
                }
            }
        }
        Menu{
            title:qsTr("Sohbet")
            MenuBarItem{
                text: qsTr("Sohbet kutusunu sıfırla")
                onClicked: outputText.text = ""
            }
            MenuBarItem{
                id: kullaniciMenu
                text: qsTr("Kullanıcı adını değiştir")
                onClicked:{
                    showRenameDialog();
                }
            }
        }
    }
    Column {
        id: mainColumn
        anchors.fill: parent
        spacing: 25
        Row{
            topPadding: parent.height*0.1
            leftPadding: parent.width*0.2
            ScrollView {
                id: scrollView
                background: Rectangle {
                    color: "#ece0d1"
                    border.color: "black"
                    border.width:1
                    radius: 10
                }
                width: mainColumn.width*0.6
                height: mainColumn.height*0.5
                clip: true
                TextArea {
                    readOnly: true
                    id: outputText
                    wrapMode: TextArea.Wrap
                    text: ""

                }
            }
        }
        Row {
            leftPadding: width*0.2
            anchors.horizontalCenter: parent.horizontalCenter
            id: buttonRow
            spacing: 10
            height: parent.height*0.08
            width: parent.width
            CustomText {
                anchors.centerIn: parent.Center
                id: inputField
                width: parent.width*0.5
                height: parent.height
                placeholderText: ""
            }
            NewButton {
                anchors.centerIn: parent.Center
                text: qsTr("Gönder")
                id: portButton
                onClicked: {
                    console.log(myClass.sendStringData(inputField.text+"^"+name)+", "+inputField.text+","+name)
                    outputText.text += "\n" + name+ ": " +inputField.text
                    inputField.text = ""
                }
            }
        }
    }
    function messageSetting(){
        senderName = myClass.getSerialData()[0]
        message = myClass.getSerialData()[1]
        outputText.text += "\n"+ senderName+": "+ message;
    }

    function setUserName(){
        myClass.setUserName(name);
    }

    function showRenameDialog(){
        var component = Qt.createComponent("customMessage.qml");
        var window = component.createObject(window);
        window.show();
    }

    function refreshName(){
        name: myClass.getUserName()
    }

    MyClass {
        id: myClass
    }
}
