
//
//  ChartViewBaseExtension.swift
//  PoliRank
//
//  Created by Jose Padilla on 2/8/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import SwiftyJSON
import Charts

extension ChartViewBase {

    func setChartViewBaseProps(_ config: String!) {
        var legendColors: [UIColor] = ChartColorTemplates.colorful();
        var legendLabels: [String] = [];

        self.descriptionText = "";
        self.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.0);

        var json: JSON = nil;
        if let data = config.data(using: String.Encoding.utf8) {
            json = JSON(data: data);
        };

        if json["backgroundColor"].exists() {
            self.backgroundColor = RCTConvert.uiColor(json["backgroundColor"].intValue);
        }

        if json["noDataText"].exists() {
            self.noDataText = json["noDataText"].stringValue;
        }

        if json["descriptionText"].exists() {
            self.descriptionText = json["descriptionText"].stringValue;
        }

        if json["descriptionFontName"].exists() {
            self.descriptionFont = UIFont(
                name: json["descriptionFontName"].stringValue,
                size: self.descriptionFont!.pointSize
            );
        }

        if json["descriptionFontSize"].exists() {
            self.descriptionFont = self.descriptionFont?.withSize(CGFloat(json["descriptionFontSize"].floatValue));
        }

        if json["descriptionTextColor"].exists() {
            self.descriptionTextColor = RCTConvert.uiColor(json["descriptionTextColor"].intValue);
        }
        
        if json["descriptionTextAlign"].exists() {
            switch (json["descriptionTextAlign"].stringValue) {
            case "left":
                self.descriptionTextAlign = NSTextAlignment.left;
                break;
            case "center":
                self.descriptionTextAlign = NSTextAlignment.center;
                break;
            case "right":
                self.descriptionTextAlign = NSTextAlignment.right;
                break;
            case "justified":
                self.descriptionTextAlign = NSTextAlignment.justified;
                break;
            default:
                break;
            }
        }

        if json["drawMarkers"].exists() {
            self.drawMarkers = json["drawMarkers"].boolValue;
        }

        if json["marker"].exists() {
            var markerFont = UIFont.systemFont(ofSize: 12.0);

            if json["marker"]["markerFontSize"].exists() {
                markerFont = markerFont.withSize(CGFloat(json["marker"]["markerFontSize"].floatValue));
            }

            if json["marker"]["markerFontName"].exists() {
                markerFont = UIFont(
                  name: json["marker"]["markerFontName"].stringValue,
                  size: markerFont.pointSize
                )!;
            }

            let ballonMarker = BalloonMarker(
                    color: RCTConvert.uiColor(json["marker"]["markerColor"].intValue),
                    font: markerFont,
                    textColor: RCTConvert.uiColor(json["marker"]["markerTextColor"].intValue),
                    insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0));
            self.marker = ballonMarker;
          
        }

        if json["showLegend"].exists() {
            self.legend.enabled = json["showLegend"].boolValue;
        }

        if json["legend"].exists() {
            if json["legend"]["textColor"].exists() {
                self.legend.textColor = RCTConvert.uiColor(json["legend"]["textColor"].intValue);
            }

            if json["legend"]["textSize"].exists() {
                self.legend.font = self.legend.font.withSize(CGFloat(json["legend"]["textSize"].floatValue));
            }

            if json["legend"]["textFontName"].exists() {
                self.legend.font = UIFont(
                    name: json["legend"]["textFontName"].stringValue,
                    size: self.legend.font.pointSize
                    )!;
            }

            if json["legend"]["wordWrap"].exists() {
                self.legend.wordWrapEnabled = json["legend"]["wordWrap"].boolValue;
            }

            if json["legend"]["maxSizePercent"].exists() {
                self.legend.maxSizePercent = CGFloat(json["legend"]["maxSizePercent"].floatValue);
            }

            if json["legend"]["position"].exists() {
                switch(json["legend"]["position"].stringValue) {
                case "rightOfChart":
                    self.legend.position = Legend.Position.rightOfChart;
                    break;
                case "rightOfChartCenter":
                    self.legend.position = Legend.Position.rightOfChartCenter;
                    break;
                case "rightOfChartInside":
                    self.legend.position = Legend.Position.rightOfChartInside;
                    break;
                case "leftOfChart":
                    self.legend.position = Legend.Position.leftOfChart;
                    break;
                case "leftOfChartCenter":
                    self.legend.position = Legend.Position.leftOfChartCenter;
                    break;
                case "leftOfChartInside":
                    self.legend.position = Legend.Position.leftOfChartInside;
                    break;
                case "belowChartLeft":
                    self.legend.position = Legend.Position.belowChartLeft;
                    break;
                case "belowChartRight":
                    self.legend.position = Legend.Position.belowChartRight;
                    break;
                case "belowChartCenter":
                    self.legend.position = Legend.Position.belowChartCenter;
                    break;
                case "aboveChartLeft":
                    self.legend.position = Legend.Position.aboveChartLeft;
                    break;
                case "aboveChartRight":
                    self.legend.position = Legend.Position.aboveChartRight;
                    break;
                case "aboveChartCenter":
                    self.legend.position = Legend.Position.aboveChartCenter;
                    break;
                case "pieChartCenter":
                    self.legend.position = Legend.Position.piechartCenter;
                    break;
                default:
                    self.legend.position = Legend.Position.belowChartLeft;
                    break;
                }
            }

            if json["legend"]["form"].exists() {
                switch(json["legend"]["form"]) {
                case "square":
                    self.legend.form = Legend.Form.square;
                    break;
                case "circle":
                    self.legend.form = Legend.Form.circle;
                    break;
                case "line":
                    self.legend.form = Legend.Form.line;
                    break;
                default:
                    self.legend.form = Legend.Form.square;
                    break;
                }
            }

            if json["legend"]["formSize"].exists() {
                self.legend.formSize = CGFloat(json["legend"]["formSize"].floatValue);
            }

            if json["legend"]["xEntrySpace"].exists() {
                self.legend.xEntrySpace = CGFloat(json["legend"]["xEntrySpace"].floatValue);
            }

            if json["legend"]["yEntrySpace"].exists() {
                self.legend.yEntrySpace = CGFloat(json["legend"]["yEntrySpace"].floatValue);
            }

            if json["legend"]["formToTextSpace"].exists() {
                self.legend.formToTextSpace = CGFloat(json["legend"]["formToTextSpace"].floatValue);
            }

            if json["legend"]["colors"].exists() {
                let arrColors = json["legend"]["colors"].arrayValue.map({$0.intValue});
                legendColors = arrColors.map({return RCTConvert.uiColor($0)});
                if legendLabels.count == legendColors.count {
                    legend.setCustom(colors: legendColors, labels: legendLabels);
                }
            }

            if json["legend"]["labels"].exists() {
                legendLabels = json["legend"]["labels"].arrayValue.map({$0.stringValue});
                if legendLabels.count == legendColors.count {
                    legend.setCustom(colors:  legendColors, labels: legendLabels);
                }
            }
        }

        if json["userInteractionEnabled"].exists() {
          self.isUserInteractionEnabled = json["userInteractionEnabled"].boolValue;
        }

        if json["dragDecelerationEnabled"].exists() {
          self.dragDecelerationEnabled = json["dragDecelerationEnabled"].boolValue;
        }

        if json["dragDecelerationFrictionCoef"].exists() {
          self.dragDecelerationFrictionCoef = CGFloat(json["dragDecelerationFrictionCoef"].floatValue);
        }

        if json["highlightPerTap"].exists() {
          self.highlightPerTapEnabled = json["highlightPerTap"].boolValue;
        }

        if json["highlightValues"].exists() {
            let highlightValues = json["highlightValues"].arrayValue.map({$0.doubleValue});
            self.highlightValues(highlightValues.map({return Highlight(x: $0, dataSetIndex: 0, stackIndex: 0)}));
        }

        if json["animation"].exists() {
            let xAxisDuration = json["animation"]["xAxisDuration"].exists() ?
                json["animation"]["xAxisDuration"].doubleValue : 0;
            let yAxisDuration = json["animation"]["yAxisDuration"].exists() ?
                json["animation"]["yAxisDuration"].doubleValue : 0;

            var easingOption: ChartEasingOption = .linear;

            if json["animation"]["easingOption"].exists() {
                switch(json["animation"]["easingOption"]) {
                case "linear":
                    easingOption = .linear;
                    break;
                case "easeInQuad":
                    easingOption = .easeInQuad;
                    break;
                case "easeOutQuad":
                    easingOption = .easeOutQuad;
                    break;
                case "easeInOutQuad":
                    easingOption = .easeInOutQuad;
                    break;
                case "easeInCubic":
                    easingOption = .easeInCubic;
                    break;
                case "easeOutCubic":
                    easingOption = .easeOutCubic;
                    break;
                case "easeInOutCubic":
                    easingOption = .easeInOutCubic;
                    break;
                case "easeInQuart":
                    easingOption = .easeInQuart;
                    break;
                case "easeOutQuart":
                    easingOption = .easeOutQuart;
                    break;
                case "easeInOutQuart":
                    easingOption = .easeInOutQuart;
                    break;
                case "easeInQuint":
                    easingOption = .easeInQuint;
                    break;
                case "easeOutQuint":
                    easingOption = .easeOutQuint;
                    break;
                case "easeInOutQuint":
                    easingOption = .easeInOutQuint;
                    break;
                case "easeInSine":
                    easingOption = .easeInSine;
                    break;
                case "easeOutSine":
                    easingOption = .easeOutSine;
                    break;
                case "easeInOutSine":
                    easingOption = .easeInOutSine;
                    break;
                case "easeInExpo":
                    easingOption = .easeInExpo;
                    break;
                case "easeOutExpo":
                    easingOption = .easeOutExpo;
                    break;
                case "easeInOutExpo":
                    easingOption = .easeInOutExpo;
                    break;
                case "easeInCirc":
                    easingOption = .easeInCirc;
                    break;
                case "easeOutCirc":
                    easingOption = .easeOutCirc;
                    break;
                case "easeInOutCirc":
                    easingOption = .easeInOutCirc;
                    break;
                case "easeInElastic":
                    easingOption = .easeInElastic;
                    break;
                case "easeOutElastic":
                    easingOption = .easeOutElastic;
                    break;
                case "easeInBack":
                    easingOption = .easeInBack;
                    break;
                case "easeOutBack":
                    easingOption = .easeOutBack;
                    break;
                case "easeInOutBack":
                    easingOption = .easeInOutBack;
                    break;
                case "easeInBounce":
                    easingOption = .easeInBounce;
                    break;
                case "easeOutBounce":
                    easingOption = .easeOutBounce;
                    break;
                case "easeInOutBounce":
                    easingOption = .easeInOutBounce;
                    break;
                default:
                    easingOption = .linear;
                    break;
                }
            }

            self.animate(xAxisDuration: xAxisDuration, yAxisDuration: yAxisDuration, easingOption: easingOption);
        }
    }
}
