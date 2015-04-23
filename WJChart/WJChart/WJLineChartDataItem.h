//
//  WJLineChartDataItem.h
//  WJChart
//
//  Created by Alireza Arabi on 1/21/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WJLineChartDataItem : NSObject

+ (WJLineChartDataItem *)dataItemWithX:(CGFloat)x AndWithY:(CGFloat)y;

@property (readonly) CGFloat x; // should be within the x range
@property (readonly) CGFloat y; // should be within the y range

@end
