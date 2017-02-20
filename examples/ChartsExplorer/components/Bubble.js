import React, { Component } from 'react';
import { StyleSheet } from 'react-native';

import { BubbleChart } from 'react-native-ios-charts';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'stretch',
    backgroundColor: 'transparent'
  }
});

export default class Bubble extends Component {
  static displayName = 'Bubble';

  render() {
    const config = {
      dataSets: [{
        values: [{
          size: 23.4,
          x:1990,
          y: 8
        }, {
          size: 17.4,
          x:1991,
          y: 5
        }, {
          size: 6.0,
          x:1992,
          y: 2
        }, {
          size: 52.0,
          x:1993,
          y: 12
        }, {
          size: 40.1,
          x:1994,
          y: 10
        }],
        colors: ['rgba(241, 152, 174, 0.7)'],
        label: 'Company A'
      }],
      legend: {
        showLegend: false
      },
      xAxis: {
        position: 'bottom',
        granularity:1,
      },
      leftAxis: {
        spaceBottom: 0.05
      },
      rightAxis: {
        spaceBottom: 0.05
      }
    };
    return (
      <BubbleChart config={config} style={styles.container}/>
    );
  }
}
