/***************************************************************************
* Copyright (c) 2013 Abdurrahman AVCI <abdurrahmanavci@gmail.com
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge,
* publish, distribute, sublicense, and/or sell copies of the Software,
* and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included
* in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
* OR OTHER DEALINGS IN THE SOFTWARE.
*
***************************************************************************/

import QtQuick 2.0

Rectangle {
    id: container
    width: 1024
    height: 768

    Connections {
        target: sessionManager
        onSuccess: {
        }

        onFail: {
        }
    }

    FontLoader { id: clockFont; source: "GeosansLight.ttf" }

    Image {
        anchors.fill: parent
        source: "background.png"
        fillMode: Image.PreserveAspectCrop
    }

    Row {
        anchors.fill: parent

        Rectangle {
            width: parent.width / 2; height: parent.height
            color: "#00000000"

            Clock {
                id: clock
                anchors.fill: parent
                color: "white"
                font: clockFont.name
            }
        }

        Rectangle {
            id: userList
            width: parent.width / 2; height: parent.height
            color: "#22000000"
            clip: true

            Row {
                anchors.centerIn: parent
                spacing: 5

                Repeater {
                    model: userModel

                    PictureBox {
                        width: 150; height: 180
                        anchors.verticalCenter: parent.verticalCenter
                        name: (model.realName === "") ? model.userName : model.realName
                        icon: model.icon
                        onLogin: sessionManager.login(model.userName, password, sessionManager.lastSessionIndex)
                    }
                }
            }
        }
    }

    Component.onCompleted: {
    }
}
