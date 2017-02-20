//
//  RNPieChart.m
//  PoliRank#0	0x00000001001a7d08 in BalloonMarker.draw(context : CGContext, point : CGPoint) -> () at /Users/xudong/workspace/github/react-native-ios-charts/RNiOSCharts/BalloonMarker.swift:61

//
//  Created by Jose Padilla on 2/8/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RNScatterChart.h"
#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(RNScatterChartSwift, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(config, NSString);
RCT_EXTERN_METHOD(setVisibleXRangeMaximum:(nonnull NSNumber *)reactTag value:(CGFloat *)v);

@end
