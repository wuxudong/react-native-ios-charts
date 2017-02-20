//
//  RNPieChart.swift
//  PoliRank
//
//  Created by Jose Padilla on 2/8/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import Charts
import SwiftyJSON

@objc(RNPieChart)
class RNPieChart : PieChartView {
  
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

    if json["holeColor"].exists() {
      self.holeColor = RCTConvert.uiColor(json["holeColor"].intValue);
    }
    
    if json["drawHoleEnabled"].exists() {
      self.drawHoleEnabled = json["drawHoleEnabled"].boolValue;
    }

    if json["centerText"].exists() {
      self.centerText = json["centerText"].stringValue;
    }

    if json["drawCenterTextEnabled"].exists() {
      self.drawCenterTextEnabled = json["drawCenterTextEnabled"].boolValue;
    }
    
    if json["holeRadiusPercent"].exists() {
      self.holeRadiusPercent = CGFloat(json["holeRadiusPercent"].floatValue);
    }
    
    if json["transparentCircleRadiusPercent"].exists() {
      self.transparentCircleRadiusPercent = CGFloat(json["transparentCircleRadiusPercent"].floatValue);
    }
    
    if json["drawSliceTextEnabled"].exists() {
      self.drawSliceTextEnabled = json["drawSliceTextEnabled"].boolValue;
    }
    
    if json["usePercentValuesEnabled"].exists() {
      self.usePercentValuesEnabled = json["usePercentValuesEnabled"].boolValue;
    }
    
    if json["centerTextRadiusPercent"].exists() {
      self.centerTextRadiusPercent = CGFloat(json["centerTextRadiusPercent"].floatValue);
    }
    
    if json["maxAngle"].exists() {
      self.maxAngle = CGFloat(json["maxAngle"].floatValue);
    }
    
    if json["labels"].exists() {
      labels = json["labels"].arrayValue.map({$0.stringValue});
    }
    
    if json["dataSets"].exists() {
      let dataSets = json["dataSets"].arrayObject;
      
      var sets: [PieChartDataSet] = [];
      
      for set in dataSets! {
        let tmp = JSON(set);
        if tmp["values"].exists() {
          let values = tmp["values"].arrayObject!;

          let label = tmp["label"].exists() ? tmp["label"].stringValue : "";
          var dataEntries: [ChartDataEntry] = [];
          
          for i in 0..<values.count {
            let object = JSON(values[i]);
            let dataEntry = PieChartDataEntry(
              value: object["value"].doubleValue,
              label: object["label"].stringValue,
              data: object as AnyObject?);
            dataEntries.append(dataEntry);
          }
          
          let dataSet = PieChartDataSet(values: dataEntries, label: label);
          
          if tmp["sliceSpace"].exists() {
            dataSet.sliceSpace = CGFloat(tmp["sliceSpace"].floatValue);
          }
          
          if tmp["selectionShift"].exists() {
            dataSet.selectionShift = CGFloat(tmp["selectionShift"].floatValue);
          }
          
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
      
      let chartData = PieChartData(dataSets: sets);
      self.data = chartData;
    }
    
  }
  
}
