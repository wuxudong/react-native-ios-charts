import React, { Component } from 'react';
import { StyleSheet } from 'react-native';

import { LineChart } from 'react-native-ios-charts';


const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'stretch',
    backgroundColor: 'transparent'
  }
});

export default class TimeSeriesLine extends Component {
  static displayName = 'TimeSeriesLine';

  render() {
    let size = 30;

    let data = [];
    for(let i=0; i<size; i++) {
      data.push({x:i, y:i * i})
    }

    const config = {
      dataSets: [{
        values: data,
        drawValues: false,
        colors: ['rgb(199, 255, 140)'],
        label: 'refer',
        drawCubic: true,
        drawCircles: false,
        lineWidth: 2
      }, {
        values: [{x:5, y:15}, {x:10,y:200}, {x:18, y:400}, {x:39, y:2000, marker: "you are overweight"}],
        drawValues: false,
        colors: ['rgb(255, 247, 141)'],
        label: 'user',
        drawCubic: false,
        drawCircles: false,
        lineWidth: 2
      }],
      minOffset: 20,
      scaleYEnabled: false,
      drawMarkers: true,
      marker: {
        markerColor: 'grey',
        markerTextColor: 'white',
        markerFontSize: 14,
      },
      legend: {
        textSize: 12
      },
      xAxis: {
        axisLineWidth: 0,
        drawLabels: false,
        position: 'bottom',
        drawGridLines: false
      },
      leftAxis: {
        customAxisMax: 1,
        customAxisMin: -1,
        labelCount: 11,
        startAtZero: false,
        spaceTop: 0.1,
        spaceBottom: 0.1
      },
      rightAxis: {
        enabled: false,
        drawGridLines: false
      },
      valueFormatter: {
        minimumSignificantDigits: 1,
        type: 'regular',
        maximumDecimalPlaces: 1
      }
    };
    return (
      <LineChart config={config} style={styles.container}/>
    );
  }
}
