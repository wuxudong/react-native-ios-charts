//
//  RNPieChart.swift
//  PoliRank
//
//  Created by Jose Padilla on 2/8/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import Charts
import SwiftyJSON

@objc(RNRadarChart)
class RNRadarChart : RadarChartView {
  
  override init(frame: CGRect) {
    super.init(frame: frame);
    self.frame = frame;
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  }
  
  func setConfig(_ config: String!) {
    setPieRadarChartViewBaseProps(config);
    
    var maximumDecimalPlaces: Int = 0;
    var minimumDecimalPlaces: Int = 0;
    var labels: [String] = [];
    
    var json: JSON = nil;
    if let data = config.data(using: String.Encoding.utf8) {
      json = JSON(data: data);
    };
    
    if json["labels"].exists() {
      labels = json["labels"].arrayValue.map({$0.stringValue});
      self.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels);
    }
    
    if json["dataSets"].exists() {
      let dataSets = json["dataSets"].arrayObject;
      
      var sets: [RadarChartDataSet] = [];
      
      for set in dataSets! {
        let tmp = JSON(set);
        if tmp["values"].exists() {
          let values = tmp["values"].arrayObject!;
          let label = tmp["label"].exists() ? tmp["label"].stringValue : "";
          var dataEntries: [ChartDataEntry] = [];
          
          for i in 0..<values.count {
            let object = JSON(values[i]);
            
            var dataEntry : RadarChartDataEntry;
            if(object.double != nil) {
              dataEntry = RadarChartDataEntry(value: object.double!);
            } else {
              let value = object["value"].doubleValue;
              dataEntry = RadarChartDataEntry(value: value, data:object as AnyObject?);
            }
            
            dataEntries.append(dataEntry);
          }
          
          let dataSet = RadarChartDataSet(values: dataEntries, label: label);
          
          if tmp["colors"].exists() {
            let arrColors = tmp["colors"].arrayValue.map({$0.intValue});
            dataSet.colors = arrColors.map({return RCTConvert.uiColor($0)});
          }
          
          if tmp["drawValues"].exists() {
            dataSet.drawValuesEnabled = tmp["drawValues"].boolValue;
          }
          
          if tmp["highlightEnabled"].exists() {
            dataSet.highlightEnabled = tmp["highlightEnabled"].boolValue;
          }
          
          if tmp["fillColor"].exists() {
            dataSet.fillColor = RCTConvert.uiColor(tmp["fillColor"].intValue);
          }
          
          if tmp["fillAlpha"].exists() {
            dataSet.fillAlpha = CGFloat(tmp["fillAlpha"].floatValue);
          }
          
          if tmp["lineWidth"].exists() {
            dataSet.lineWidth = CGFloat(tmp["lineWidth"].floatValue);
          }
          
          if tmp["drawFilledEnabled"].exists() {
            dataSet.drawFilledEnabled = tmp["drawFilledEnabled"].boolValue;
          }
          
          if tmp["valueTextFontName"].exists() {
            dataSet.valueFont = UIFont(
              name: tmp["valueTextFontName"].stringValue,
              size: dataSet.valueFont.pointSize
              )!;
          }
          
          if tmp["valueTextFontSize"].exists() {
            dataSet.valueFont = dataSet.valueFont.withSize(CGFloat(tmp["valueTextFontSize"].floatValue))
          }
          
          if tmp["valueTextColor"].exists() {
            dataSet.valueTextColor = RCTConvert.uiColor(tmp["valueTextColor"].intValue);
          }
          
          if json["valueFormatter"].exists() {
            if json["valueFormatter"]["minimumDecimalPlaces"].exists() {
              minimumDecimalPlaces = json["valueFormatter"]["minimumDecimalPlaces"].intValue;
            }
            if json["valueFormatter"]["maximumDecimalPlaces"].exists() {
              maximumDecimalPlaces = json["valueFormatter"]["maximumDecimalPlaces"].intValue;
            }
            
            var numberFormatter = NumberFormatter();
            
            if json["valueFormatter"]["type"].exists() {
              switch(json["valueFormatter"]["type"]) {
              case "regular":
                numberFormatter = NumberFormatter();
                break;
              case "abbreviated":
                numberFormatter = ABNumberFormatter(minimumDecimalPlaces: minimumDecimalPlaces, maximumDecimalPlaces: maximumDecimalPlaces);
                break;
              default:
                numberFormatter = NumberFormatter();
              }
            }
            
            if json["valueFormatter"]["numberStyle"].exists() {
              switch(json["valueFormatter"]["numberStyle"]) {
              case "CurrencyAccountingStyle":
                if #available(iOS 9.0, *) {
                  numberFormatter.numberStyle = .currencyAccounting;
                }
                break;
              case "CurrencyISOCodeStyle":
                if #available(iOS 9.0, *) {
                  numberFormatter.numberStyle = .currencyISOCode;
                }
                break;
              case "CurrencyPluralStyle":
                if #available(iOS 9.0, *) {
                  numberFormatter.numberStyle = .currencyPlural;
                }
                break;
              case "CurrencyStyle":
                numberFormatter.numberStyle = .currency;
                break;
              case "DecimalStyle":
                numberFormatter.numberStyle = .decimal;
                break;
              case "NoStyle":
                numberFormatter.numberStyle = .none;
                break;
              case "OrdinalStyle":
                if #available(iOS 9.0, *) {
                  numberFormatter.numberStyle = .ordinal;
                }
                break;
              case "PercentStyle":
                numberFormatter.numberStyle = .percent;
                break;
              case "ScientificStyle":
                numberFormatter.numberStyle = .scientific;
                break;
              case "SpellOutStyle":
                numberFormatter.numberStyle = .spellOut;
                break;
              default:
                numberFormatter.numberStyle = .none;
              }
            }
            
            numberFormatter.minimumFractionDigits = minimumDecimalPlaces;
            numberFormatter.maximumFractionDigits = maximumDecimalPlaces;
            
            dataSet.valueFormatter = DefaultValueFormatter(formatter: numberFormatter);
          }
          
          sets.append(dataSet);
        }
      }
      
      let chartData = RadarChartData(dataSets: sets);
      self.data = chartData;
      
      if json["webLineWidth"].exists() {
        self.webLineWidth = CGFloat(json["webLineWidth"].floatValue);
      }
      
      if json["innerWebLineWidth"].exists() {
        self.innerWebLineWidth = CGFloat(json["innerWebLineWidth"].floatValue);
      }

      if json["webColor"].exists() {
        self.webColor = RCTConvert.uiColor(json["webColor"].intValue);
      }
      
      if json["innerWebColor"].exists() {
        self.innerWebColor = RCTConvert.uiColor(json["innerWebColor"].intValue);
      }
      
      if json["webAlpha"].exists() {
        self.webAlpha = CGFloat(json["webAlpha"].floatValue);
      }
      
      if json["drawWeb"].exists() {
        self.drawWeb = json["drawWeb"].boolValue;
      }
      
      if json["skipWebLineCount"].exists() {
        self.skipWebLineCount = json["skipWebLineCount"].intValue;
      }
      
    }
  }
}
