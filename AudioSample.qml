import QtQuick
import QtQuick.Controls
import QtCharts

Item {
    visible: true

    anchors.fill: parent

    ChartView{
        id:chartView
        //animationOptions: chartView.NoAnimation
        //theme: chartView.ChartThemeBlueIcy
        animationOptions: ChartView.AllAnimations
        //theme:ChartView.ChartThemeDark
        theme:ChartView.ChartThemeQt
        property bool openGL: true
        property bool openGLSupported: true
        anchors.fill: parent

        Component.onCompleted: {
            dataSource.setSeries(chartView.series(0));
        }

        Component.onDestruction: {
            dataSource.setSeries(0);
        }

        ValueAxis{
            id:axisY1
            min: -1
            max: 1
        }

        ValueAxis{
            id:axisX
            min: 0
            max: 2000
        }

        LineSeries{
            id: lineSeries
            name: "Audio Sample"
            axisX: axisX
            axisY: axisY1
            useOpenGL: chartView.openGL
        }
    }
}

