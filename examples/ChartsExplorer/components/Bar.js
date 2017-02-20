import React, { Component } from 'react';
import { StyleSheet } from 'react-native';

import { BarChart } from 'react-native-ios-charts';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'stretch',
    backgroundColor: 'transparent'
  }
});

export default class Bar extends Component {
  static displayName = 'Bar';
  componentDidMount() {
    this.refs.chart.setVisibleXRangeMaximum(2);
  }
  render() {
    const config = {
      dataSets: [{
        values: [5, 40, 77, 81, 43, 5, 40, 77, 81, 43],
        drawValues: true,
        colors: ['rgb(107, 243, 174)'],
        label: 'Company A'
      }, {
        values: [5, 40, 77, 81, 43, 5, 40, 77, 81, 43],
        drawValues: true,
        colors: ['rgb(166, 232, 255)'],
        label: 'Company B'
      }, {
        values: [5, 40, 77, 81, 43, 5, 40, 77, 81, 43],
        drawValues: true,
        colors: ['rgb(248, 248, 157)'],
        label: 'Company C'
      }],
      barWidth : 0.2,
      labels: ['1990', '1991', '1992', '1993', '1994', '1995', '1996', '1997', '1998', '1999'],
      legend: {
      },
      xAxis: {
        position: 'bottom',
        labelCount:10,
        granularity:1,
        axisMinimum: 0,
        axisMaximum: 10,
        centerAxisLabelsEnabled: true
      },
      group: {
        fromX: 0,
        groupSpace : 0.1,
        barSpace : 0.1,
      },
      leftAxis: {
        drawGridLines: false,
        spaceBottom: 0.05
      },
      rightAxis: {
        drawGridLines: false,
        spaceBottom: 0.05
      },
      valueFormatter: {
        type: 'regular',
        maximumDecimalPlaces: 0
      },
      viewport: {
        left: 20,
        top: 0,
        right: 20,
        bottom: 50
      }
    };
    return (
      <BarChart ref='chart' config={config} style={styles.container}/>
    );
  }
}
