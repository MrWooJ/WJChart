//
//  WJLineChartData.h
//  WJChart
//
//  Created by Alireza Arabi on 1/21/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WJLineChartDataItem;

typedef WJLineChartDataItem *(^LCLineChartDataGetter)(NSUInteger item);

@interface WJLineChartData : NSObject

@property (nonatomic,strong) NSString *diagramName;

@property (strong) UIColor *fillColor;
@property (strong) UIColor *strokeColor;
@property (strong) UIColor *stackColor;

@property (nonatomic) CGFloat alpha;

@property NSUInteger itemCount;

@property (copy) LCLineChartDataGetter getData;

@property (nonatomic, assign) CGFloat lineWidth;


@end
