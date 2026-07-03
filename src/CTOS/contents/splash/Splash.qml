/*
 *   CTOS splash screen for Plasma 6
 *   Derived from the Parrot Security splash (GPLv2+, (c) 2014 Marco Martin).
 *   Keeps only the central CTOS-style animation on a clean black background.
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 */

import QtQuick 2.5
import QtQuick.Window 2.2

Rectangle {
    id: root
    color: "#000"

    Item {
        id: content
        anchors.fill: parent
        opacity: 1
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Rectangle {

            property int sizeAnim: 704

            id: imageSource
            width:  sizeAnim
            height: sizeAnim
            color:  "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            clip: true;

            AnimatedImage {
                id: face
                source: "images/animation.gif"
                paused: false
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width:  imageSource.sizeAnim
                height: imageSource.sizeAnim
                visible: true
            }
        }
    }
}
