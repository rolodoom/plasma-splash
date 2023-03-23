import QtQuick 2.15
import QtGraphicalEffects 1.15

import QtQuick.Window 2.2
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: root
    Image{
        anchors.fill: parent
        source: "images/background.png"

    }
    

    property int stage

    onStageChanged: {
//         if (stage == 1) {
//             introAnimation.running = true
//         }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Image {
            id: logo
            //match SDDM/lockscreen avatar positioning
            property real size: units.gridUnit * 8

            anchors.centerIn: parent

            source: "images/archlinux-logo.svgz"

            sourceSize.width: 248
            sourceSize.height: 65
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 1
                verticalOffset: 1
                radius: 3
            }
        }
            Rectangle{
                y: parent.height - (parent.height - logo.y) / 1.225 - height / 2
                property real maxWidth: units.gridUnit * 13
                anchors.left: parent.left
                anchors.leftMargin: parent.width / 2 - maxWidth / 2
                height:PlasmaCore.Units.gridUnit/3
                radius: height/2
                
                width: (maxWidth / 5) * (stage - 1 - 0.01)
                
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 3
                }
                Behavior on width{
                       NumberAnimation {
                           easing: Easing.InOutQuad
                    }
                }
                
            }
            Image {
                y: parent.height - (parent.height - logo.y) / 2.7 - height / 2
                id: busyIndicator
                
                source: "images/busy.svgz"
                sourceSize.height: units.gridUnit * 2.5
                sourceSize.width: units.gridUnit * 2.5
                anchors.horizontalCenter: parent.horizontalCenter

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 0
                    verticalOffset: 0
                    radius: 4
                    RotationAnimator on rotation {
                        id: rotationAnimator
                        from: 0
                        to: 360
                        duration: 2000
                        loops: Animation.Infinite
                    }
                }
            }
        Row {
            spacing: PlasmaCore.Units.smallSpacing*2
            anchors {
                bottom: parent.bottom
                right: parent.right
                margins: PlasmaCore.Units.gridUnit
            }
            Text {
                color: "#eff0f1"
                // Work around Qt bug where NativeRendering breaks for non-integer scale factors
                // https://bugreports.qt.io/browse/QTBUG-67007
                renderType: Screen.devicePixelRatio % 1 !== 0 ? Text.QtRendering : Text.NativeRendering
                anchors.verticalCenter: parent.verticalCenter
                text: i18ndc("plasma_lookandfeel_org.kde.lookandfeel", "This is the first text the user sees while starting in the splash screen, should be translated as something short, is a form that can be seen on a product. Plasma is the project name so shouldn't be translated.", "Plasma made by KDE")
            }
            Image {
                source: "images/kde.svgz"
                sourceSize.height: PlasmaCore.Units.gridUnit * 2
                sourceSize.width: PlasmaCore.Units.gridUnit * 2
            }
        }

    }

    OpacityAnimator {
        id: introAnimation
        running: true
        target: content
        from: 0
        to: 1
        duration: 500
        easing.type: Easing.InOutQuad
    }
}
