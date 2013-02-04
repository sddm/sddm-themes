/*
 * Copyright 2013  Reza Fatahilah Shah <rshah0385@kireihana.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 1.1

Rectangle {
    width: 640
    height: 480

    Connections {
        target: sessionManager

        onSuccess: {
            errorMessage.color = "steelblue"
            errorMessage.text = qsTr("Login succeeded.")
        }

        onFail: {
            errorMessage.color = "red"
            errorMessage.text = qsTr("Login failed.")
        }
    }

    Component.onCompleted: {
        initSessionModel();
    }

    function initSessionModel(){
        for (var ii=0; ii<sessionManager.sessionNames.length; ii++)
            sessionModel.append({"name":sessionManager.sessionNames[ii]});
    }

    ListModel {
         id: sessionModel
    }

    Image {
        id: background
        anchors.fill: parent
        source: "../images/background.png"
        fillMode: Image.PreserveAspectCrop
    }

    MouseArea {
        anchors.fill: parent
        onClicked: menu_session.state = ""
    }

    Rectangle {
        width: 416
        height: 262
        color: "#00000000"

        anchors.centerIn: parent

        Image {
            anchors.fill: parent
            source: "../images/rectangle.png"
        }

        Image {
            anchors.fill: parent
            source: "../images/rectangle_overlay.png"
            opacity: 0.1
        }

        Column {
            anchors {
                topMargin: 20
                leftMargin: 20
                rightMargin: 20
                bottomMargin: 20
                fill: parent
            }

            spacing: 12

            Text {
                anchors {
                    left: parent.left
                    right: parent.right
                }
                color: "#0b678c"
                opacity: 0.75
                text: sessionManager.hostName
                font.bold: true
                font.pixelSize: 18
            }

            Column {
                id: login_box
                anchors.centerIn: parent

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 50

                    Image {
                        id: image1
                        anchors.verticalCenter: parent.verticalCenter
                        source: "../images/user_icon.png"
                    }

                    TextBox {
                        id: user_entry
                        anchors.verticalCenter: parent.verticalCenter
                        width: 150
                        height: 30
                        text: sessionManager.lastUser
                        font.pixelSize: 14
                    }

                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 50

                    Image {
                        id: image1a
                        anchors.verticalCenter: parent.verticalCenter
                        source: "../images/lock.png"
                    }

                    TextBox {
                        id: pw_entry
                        anchors.verticalCenter: parent.verticalCenter
                        width: 150
                        height: 30
                        echoMode: TextInput.Password
                        font.pixelSize: 14
                    }

                }
            }

            Text {
                id: caps_lock_warning
                text: qsTr("Caps Lock is enabled")
                visible: false
                anchors {
                    topMargin: 10
                    top: login_box.bottom
                    horizontalCenter: parent.horizontalCenter
                }

                color: "#0b678c"
                font.bold: true
                font.pixelSize: 12
            }

            Row {
                spacing: 8

                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                ImageButton {
                    id: session_button
                    source: "../images/session_normal.png"
                    onClicked: {
                        menu_session.state = "visible"
                    }

                    Menu {
                        id: menu_session
                        anchors {
                            top: parent.bottom
                            topMargin: 4
                            left: parent.left
                            leftMargin: 4
                        }

                        opacity: 0
                        onItemClicked: {
                            //console.log("clicked red item: " + index)
                            sessionManager.login(user_entry.text, pw_entry.text, index)
                        }
                        model: sessionModel
                    }
                }

                ImageButton {
                    id: system_button
                    source: "../images/system_normal.png"
                    onClicked: {
                        sessionManager.shutdown()
                    }
                }

                ImageButton {
                    id: reboot_button
                    source: "../images/system_reboot.png"
                    onClicked: {
                        sessionManager.reboot()
                    }
                }

                Text {
                    id: time_label
                    text: Qt.formatDateTime(new Date(), "dddd, dd MMMM yyyy HH:mm AP")
                    horizontalAlignment: Text.AlignRight

                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                    }

                    color: "#0b678c"
                    font.bold: true
                    font.pixelSize: 12
                    /*
if (!dateFormatSet) {
            // xgettext:no-c-format
            KGlobal::locale()->setDateFormat(i18nc("date format", "%a %d %B"));
            dateFormatSet = true;
        }
        ret << KGlobal::locale()->formatDateTime(QDateTime::currentDateTime(), KLocale::LongDate);*/
                }

            }
        }

        Image {
            id: login_button
            anchors {
                rightMargin: 20
                verticalCenter: parent.verticalCenter
                right: parent.right
            }
            source: "../images/login_normal.png"

            MouseArea {
                id: mouseArea
                hoverEnabled: true
                anchors.fill: parent

                onEntered: login_button.source = "../images/login_active.png"
                onExited: login_button.source = "../images/login_normal.png"
                onClicked: {
                    if (mouse.button === Qt.LeftButton)
                        sessionManager.login(user_entry.text, pw_entry.text, session.index)
                }
            }
        }

    }
    
}
