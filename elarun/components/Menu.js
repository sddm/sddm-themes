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
var docRoot = null;

function getDocRoot()
{
    if(!docRoot)
    {
        docRoot = menu.parent;

        while(docRoot.parent)
        {
            docRoot = docRoot.parent;
        }
    }

    return docRoot;
}

var menuPadding = 64;
var menuWidth = -1;
var rowHeight = -1;
var docRootWidth = -1;
var menuMargin = 5;

function getMenuWidth()
{
    if(menuWidth == -1 || (getDocRoot().width != docRootWidth))
    {
        docRootWidth = getDocRoot().width;
        var extraWidth = menuMargin * 2;
        for(var i = 0; i < model.count; i++)
        {
            var textItem = Qt.createQmlObject('import QtQuick 1.1; Text { font.pointSize:' + itemFontSize + '; text: "' + model.get(i).name + '"}',
            menuList);

            menuWidth = Math.max(menuWidth, textItem.width) + extraWidth;
            rowHeight = textItem.height + extraWidth;

            textItem.destroy();
        }
    }
    menuWidth = Math.min(menuWidth, getDocRoot().width - menuPadding);

    return menuWidth;
}

function getMenuHeight()
{
    return Math.min(rowHeight * model.count + 1, getDocRoot().height - menuPadding);
}
    
function hide() {
    menu.state = ""
}