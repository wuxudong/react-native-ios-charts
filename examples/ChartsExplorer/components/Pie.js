import React, { Component } from 'react';
import { StyleSheet } from 'react-native';

import { PieChart } from 'react-native-ios-charts';


const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'stretch',
    backgroundColor: 'transparent'
  }
});

export default class Pie extends Component {
  static displayName = 'Pie';

  render() {
    const config = {
      dataSets: [{
        values: [{value:0.14, label:"Quarter 1"}, {value:0.14, label:"Quarter 2"}, {value:0.34, label:"Quarter 3"}, {y:0.38, label:"Quarter 4"}],
        colors: ['rgb(197, 255, 140)', 'rgb(255, 247, 140)', 'rgb(255, 210, 141)', 'rgb(140, 235, 255)'],
        label: 'Quarter Revenues 2014'
      }],
      centerText: 'Quartely Revenue',
      legend: {
        position: 'aboveChartRight',
        wordWrap: true
      },
      valueFormatter: {
        type: 'regular',
        numberStyle: 'PercentStyle',
        maximumDecimalPlaces: 0
      }
    };
    return (
      <PieChart config={config} style={styles.container}/>
    );
  }
}
