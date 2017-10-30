import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "Icons.js" as MdiFont


ApplicationWindow
{
    id: window
    width: 400
    height: 500
    visible: true
    //    x: Screen.width / 2 - width / 2
    //    y: Screen.height / 2 - height / 2
    title: "medOS"

    property string userTxt
    property var userInfo

    header: ToolBar
    {
        id: headerBar
        visible: false

        Rectangle
        {
            anchors.fill: parent
            color: "#31363b"
        }

        RowLayout
        {
            anchors.fill: parent
            ToolButton
            {
                Icon
                {
                    text: MdiFont.Icon.menu
                    color: "white"
                }

                ToolTip { text: "Menu" }

                onClicked: drawer.open()
            }


            Row
            {
                anchors.centerIn: parent

                ToolButton
                {
                    id: newsViewBtn
                    Icon
                    {
                        id:newsIcon
                        text: MdiFont.Icon.newspaper
                        color: swipeView.currentIndex === 1? "#ff8080" : "white"
                    }

                    onClicked:
                    {
                        swipeView.currentIndex = 1

                        console.log("newsviewbtn clicked")
                    }


                    hoverEnabled: true

                    ToolTip.delay: 1000
                    ToolTip.timeout: 5000
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("News")
                }



                ToolButton
                {
                    id:peopleViewBtn
                    Icon
                    {
                        id: peopleIcon
                        text: MdiFont.Icon.face
                        color: swipeView.currentIndex === 2? "#ff8080" : "white"
                    }

                    onClicked:
                    {
                        swipeView.currentIndex = 2

                        console.log("peopleviewbtn clicked")
                    }


                    hoverEnabled: true

                    ToolTip.delay: 1000
                    ToolTip.timeout: 5000
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("People")
                }

                ToolButton
                {
                    id:messagesViewBtn

                    Icon
                    {
                        id: messagesIcon
                        text: MdiFont.Icon.commentText
                        color: swipeView.currentIndex === 3? "#ff8080" : "white"
                    }

                    onClicked:
                    {
                        swipeView.currentIndex = 3

                        console.log("messagesviewbtn clicked")
                    }

                    hoverEnabled: true

                    ToolTip.delay: 1000
                    ToolTip.timeout: 5000
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Messages")
                }

            }

        }

    }


    Drawer
    {
        id: drawer

        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
        z: 1

        ListView
        {
            id: listView
            currentIndex: -1
            anchors.fill: parent

            headerPositioning: ListView.OverlayHeader
            header: Pane
            {
                id: header
                z: 2
                width: parent.width
                contentHeight: headerColumn.height

                Column
                {
                    id: headerColumn
                    anchors.centerIn: parent
                    property alias userEmail : userEmail

                    Image
                    {
                        id: logo
                        width: parent.width
                        source: "qrc:/images/logo_salmon.png"
                        fillMode: implicitWidth > width ? Image.PreserveAspectFit : Image.Pad
                    }


                    Label
                    {
                        id:userEmail
                        text:userTxt
                    }
                }


            }



            delegate: ItemDelegate
            {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked:
                {
                    if (listView.currentIndex != index)
                    {
                        listView.currentIndex = index
                        window.title = model.title
                        //                        stackView.replace(model.source)
                    }

                    drawer.close()
                }
            }

            model: ListModel
            {
                ListElement { title: "News"; source: "qrc:/pages/BusyIndicatorPage.qml" }
                ListElement { title: "People"; source: "qrc:/pages/ButtonPage.qml" }
                ListElement { title: "Groups"; source: "qrc:/pages/CheckBoxPage.qml" }
                ListElement { title: "Tasks"; source: "qrc:/pages/ComboBoxPage.qml" }
                ListElement { title: "Messages"; source: "qrc:/pages/DialPage.qml" }
                ListElement { title: "Files"; source: "qrc:/pages/DelegatePage.qml" }
                ListElement { title: "Settings"; source: "qrc:/Settings.qml" }
            }

            footer: ItemDelegate
            {
                id: footer
                text: qsTr("Logout")
                width: parent.width
            }
        }
    }


    SwipeView
    {
        id: swipeView
        currentIndex: 0
        anchors.fill: parent
        interactive: false


        StackView
        {
            id:mainView

            initialItem:  SignIn
            {
                onLoggedIn:
                {
                    if(loginBtn.logged)
                    {
                        headerBar.visible= loginBtn.logged
                        userInfo  = JSON.parse(doc)

                        userTxt= userInfo.user.email

                        console.log(userInfo.token)
                        console.log(userInfo.type)
                        console.log(userInfo.user.email)
                        settingsView.info= userInfo
                        mainView.push(settingsView)
                        swipeView.interactive= true

                    }
                }
            }

            Settings {id: settingsView }
        }


        Pane
        {
            width: swipeView.width
            height: swipeView.height

            Column
            {
                spacing: 40
                width: parent.width

                Label
                {
                    width: parent.width
                    wrapMode: Label.Wrap
                    horizontalAlignment: Qt.AlignHCenter
                    text: "News view"
                }

            }

        }

        Pane
        {
            width: swipeView.width
            height: swipeView.height

            Column {
                spacing: 40
                width: parent.width

                Label {
                    width: parent.width
                    wrapMode: Label.Wrap
                    horizontalAlignment: Qt.AlignHCenter
                    text: "People view"
                }

            }

        }

        Pane
        {
            width: swipeView.width
            height: swipeView.height

            Column {
                spacing: 40
                width: parent.width

                Label {
                    width: parent.width
                    wrapMode: Label.Wrap
                    horizontalAlignment: Qt.AlignHCenter
                    text: "Messages view"
                }

            }

        }


    }
}


