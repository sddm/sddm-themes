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

Item{
    id: root

    property alias source: image.source
    signal clicked()

    width: image.width
    height: image.height

    Image {
        id: image
        opacity: 0.8
        MouseArea {
            hoverEnabled: true
            anchors.fill: parent

            onEntered: parent.opacity = 1
            onExited: parent.opacity = 0.8
            onClicked: {
                if (mouse.button === Qt.LeftButton)
                    root.clicked()
            }
        }
    }
}
