//
//  RNPieChart.swift
//  PoliRank
//
//  Created by Jose Padilla on 2/8/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import Charts
import SwiftyJSON

@objc(RNCombinedChart)
class RNCombinedChart : CombinedChartView {
  
  override init(frame: CGRect) {
    super.init(frame: frame);
    self.frame = frame;
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  }
  
  func setConfig(_ config: String!) {
    setBarLineChartViewBaseProps(config);
    
    var labels: [String] = [];
    
    var json: JSON = nil;
    if let data = config.data(using: String.Encoding.utf8) {
      json = JSON(data: data);
    };
    
    if json["labels"].exists() {
      labels = json["labels"].arrayValue.map({$0.stringValue});
      self.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels);
    }
    
    let data = CombinedChartData();
    
    if json["lineData"].exists() {
      data.lineData = getLineData(json: json["lineData"]);
    }

    if json["barData"].exists() {
      data.barData = getBarData(json: json["barData"]);
    }
    
    if json["bubbleData"].exists() {
      data.bubbleData = getBubbleData(json: json["bubbleData"]);
    }
    
    if json["scatterData"].exists() {
      data.scatterData = getScatterData(json: json["scatterData"]);
    }
    
    if json["candleData"].exists() {
      data.candleData = getCandleStickData(json: json["candleData"]);
    }
    
    if json["drawValueAboveBarEnabled"].exists() {
      self.drawValueAboveBarEnabled = json["drawValueAboveBarEnabled"].boolValue;
    }
    
    if json["drawBarShadowEnabled"].exists() {
      self.drawBarShadowEnabled = json["drawBarShadowEnabled"].boolValue;
    }
    
    if json["drawOrder"].exists() {
      self.drawOrder = json["drawOrder"].map({
        if (String(describing: $0) == "Bar") {
          return DrawOrder.bar.rawValue;
        }
        if (String(describing: $0) == "Bubble") {
          return DrawOrder.bubble.rawValue;
        }
        if (String(describing: $0) == "Line") {
          return DrawOrder.line.rawValue;
        }
        if (String(describing: $0) == "Candle") {
          return DrawOrder.candle.rawValue;
        }
        return DrawOrder.scatter.rawValue;
      });
    }
    
    self.data = data;
  }
}
