//
//  BarChart.swift
//  PoliRank
//
//  Created by Jose Padilla on 2/6/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import Charts
import SwiftyJSON

@objc(RNHorizontalBarChart)
class RNHorizontalBarChart : HorizontalBarChartView {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.frame = frame;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    func setConfig(_ config: String!) {
        setBarLineChartViewBaseProps(config);
        
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
            
            var sets: [BarChartDataSet] = [];
            
            for set in dataSets! {
                let tmp = JSON(set);
                if tmp["values"].exists() {
                    let values = tmp["values"].arrayObject!;
                    let label = tmp["label"].exists() ? tmp["label"].stringValue : "";
                    var dataEntries: [BarChartDataEntry] = [];
                    
                    for i in 0..<values.count {
                        let object = JSON(values[i]);
                      
                        var dataEntry : BarChartDataEntry;
                        if(object.double != nil) {
                          dataEntry = BarChartDataEntry(x: Double(i), y: object.double!);
                        } else {
                          let x = object["x"].exists() ? object["x"].doubleValue : Double(i);
                          let y = object["y"].doubleValue;
                          dataEntry = BarChartDataEntry(x:x, y:y, data:object as AnyObject?);
                        }
                      
                      
                        dataEntries.append(dataEntry);
                    }
                    
                    let dataSet = BarChartDataSet(values: dataEntries, label: label);
                    
                    if tmp["barShadowColor"].exists() {
                        dataSet.barShadowColor = RCTConvert.uiColor(tmp["barShadowColor"].intValue);
                    }
                  
                    if tmp["highlightAlpha"].exists() {
                        dataSet.highlightAlpha = CGFloat(tmp["highlightAlpha"].floatValue);
                    }
                    
                    if tmp["highlightColor"].exists() {
                        dataSet.highlightColor = RCTConvert.uiColor(tmp["highlightColor"].intValue);
                    }
                    
                    if tmp["highlightLineDashLengths"].exists() {
                        dataSet.highlightLineDashLengths = [CGFloat(tmp["highlightLineDashLengths"].floatValue)];
                    }
                    
                    if tmp["highlightLineDashPhase"].exists() {
                        dataSet.highlightLineDashPhase = CGFloat(tmp["highlightLineDashPhase"].floatValue);
                    }
                    
                    if tmp["highlightLineWidth"].exists() {
                        dataSet.highlightLineWidth = CGFloat(tmp["highlightLineWidth"].floatValue);
                    }
                    
                    if tmp["stackLabels"].exists() {
                        dataSet.stackLabels = tmp["stackLabels"].arrayValue.map({$0.stringValue});
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
            
            let chartData = BarChartData(dataSets: sets);
            self.data = chartData;
        }
        
        if json["drawValueAboveBar"].exists() {
            self.drawValueAboveBarEnabled = json["drawValueAboveBar"].boolValue;
        }
        
        if json["drawBarShadow"].exists() {
            self.drawBarShadowEnabled = json["drawBarShadow"].boolValue;
        }
        
    }
    
}
