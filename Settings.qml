import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Pane
{
    id: settingsView
    property var info : ({})
    //    anchors.leftMargin: 10

    ColumnLayout
    {
        id: layout
        anchors.fill: parent
        spacing:20

        Column
        {
            spacing: 10
            Layout.fillHeight: true
            Layout.fillWidth: true

            Label
            {
                text: "User info: "
                font.bold: true
            }

            Label { text: "Email: " + info.user.email || ""}
            Label { text: "Name: "+ info.user.name + " " +info.user.last_name || "" }
            Label { text: "Type: " + info.type || "" }
            Label { text: "Tags: " + info.user.tags || ""}

            Rectangle {
                    border.width: 1
                    height: 2
                    width: parent.width
                    anchors.margins: 20
                    border.color: "#2d2b19"
                }
        }



        Column
        {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Label
            {
                text: "User settings: "
                Layout.fillWidth: true
                Layout.fillHeight: true

            }
        }


    }

}
