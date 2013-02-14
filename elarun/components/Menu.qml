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
import "Menu.js" as MenuImpl

Rectangle {
    id: menu

    property alias model: menuList.model
    property alias index: menuList.currentIndex
    property int itemFontSize : 9


    width: 200; // MenuImpl.getMenuWidth() + 1
    height: 200; //MenuImpl.getMenuHeight()
    //radius: 5
    color: "#e5e5e5"

    states: State {
        name: "visible"
        PropertyChanges {target: menu; opacity: 1}
    }

    transitions: Transition {
        NumberAnimation {
            target:  menu
            properties: "opacity"
            duration: 250
        }
    }

    ListView {
        id: menuList

        highlight: Rectangle { color: "steelblue" }
        clip: true
        anchors.fill: parent

        delegate: Rectangle {
            id: listViewItem

            color: mouseArea.containsMouse ? "lightsteelblue" : "transparent"

            width: menu.width - 1
            height: itemText.height + 10

            Text {
                id: itemText
                text: name
                width: listViewItem.width
                font.pointSize: itemFontSize
                elide: Text.ElideRight

                anchors {
                    top: parent.top
                    left: parent.left
                    margins: 5
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    menuList.currentIndex = index;
                    MenuImpl.hide();
                }
            }

            Keys.onReturnPressed: {
                itemClicked(index);
                MenuImpl.hide();
            }
        }
    }
}

