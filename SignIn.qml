import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "Network.js" as Network

Pane
{
    property alias loginBtn:loginBtn
    id: pane
    signal loggedIn (var doc)
    property string secret: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoibWVkb3MiLCJpYXQiOjE1MDkwNTg3MDUsImV4cCI6MTYwMzc1MzEwNX0.fDuiiB58TgKWmj92H8qlInTiQJHLV728p4GJZILd3QM"
    property string urlLocal: 'http://localhost:3001/API/community/loginUser'
    property string urlAndroid: 'http://192.168.0.12:3001/API/community/loginUser'
    property string message
    Rectangle
    {
        anchors.centerIn: parent
        width: parent.width/2
        Column
        {
            anchors.centerIn: parent
            id: fields
            spacing: 30

            Label
            {
                text: "Join medOS!"

                font.pixelSize: 25
                horizontalAlignment: Label.AlignHCenter

            }

            TextField
            {
                id: userName
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                selectByMouse: true
                placeholderText: "nick or email"

            }

            TextField
            {
                id: password
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                selectByMouse: true
                echoMode: TextInput.Password
                placeholderText: "password"

            }


            Button
            {
                id: loginBtn

                property bool logged: false

                text: "Login"
                width: parent.width

                background: Rectangle
                {
                    anchors.fill: parent
                    color: "#ff8080"
                    radius:2
                }


                onClicked:
                {
                    if(userName.length>0 && password.length>0)
                    {
                        Network.get(urlAndroid, function (o)
                        {
                            if(o.status === 200)
                            {
                                logged = true
                                pane.loggedIn(o.responseText)
                                messageLabel.visible= false
                            }else if(o.status === 418)
                            {
                                singupDialog.open()

                            }else

                            {
                                var obj = JSON.parse(o.responseText)
                                var error = obj.error || obj.message

                                console.log(o.status, error)
                                messageLabel.text= error
                                messageLabel.visible= true
                            }
                        });
                    }
                }
            }

            Label
            {

                id: singupLabel
                text: "Sing up"
                width: parent.width
                horizontalAlignment: Text.AlignHCenter


                MouseArea
                {
                    anchors.fill: parent
                    cursorShape: "PointingHandCursor"
                    onClicked: console.log("singup clicked")
                }


            }

            Label
            {

                id: messageLabel
                text:message
                visible:false
                width: parent.width
                horizontalAlignment: Text.AlignHCenter


            }

        }
    }

    Dialog
    {
        id: singupDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        parent: ApplicationWindow.overlay

        modal: true
        title: "Confirmation"
        standardButtons: Dialog.Yes | Dialog.No

        Column
        {
            spacing: 20
            anchors.fill: parent
            Label
            {
                text: "Join medOS Community\nDo you want to join medOS?"
            }
        }

        onAccepted: console.log("accepted join medos")

    }
}
