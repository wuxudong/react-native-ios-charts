//
//  BarChart.swift
//  PoliRank
//
//  Created by Jose Padilla on 2/6/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import Charts
import SwiftyJSON

@objc(RNBarChart)
class RNBarChart : BarChartView {
    
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
      
        let data = getBarData(json: json);
      
        if json["barWidth"].exists() {
            data.barWidth = json["barWidth"].doubleValue;
        }
      
        self.data = data;
      
        if json["drawValueAboveBar"].exists() {
            self.drawValueAboveBarEnabled = json["drawValueAboveBar"].boolValue;
        }
        
        if json["drawBarShadow"].exists() {
            self.drawBarShadowEnabled = json["drawBarShadow"].boolValue;
        }
      
        if json["group"].exists() {
            let fromX = json["group"]["fromX"].doubleValue;
            let groupSpace = json["group"]["groupSpace"].doubleValue;
            let barSpace = json["group"]["barSpace"].doubleValue;
              
            self.groupBars(fromX: fromX, groupSpace: groupSpace, barSpace: barSpace)
        }
      
      
      
      
      
      
        
    }
    
}
