//
//  WJLineChartDataItem.m
//  WJChart
//
//  Created by Alireza Arabi on 1/21/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJLineChartDataItem.h"

@interface WJLineChartDataItem ()

- (id)initWithX:(CGFloat)x AndWithY:(CGFloat)y;

@property (readwrite) CGFloat x; // should be within the x range
@property (readwrite) CGFloat y; // should be within the y range

@end

@implementation WJLineChartDataItem

+ (WJLineChartDataItem *)dataItemWithX:(CGFloat)x AndWithY:(CGFloat)y
{
    return [[WJLineChartDataItem alloc] initWithX:x AndWithY:y];
}

- (id)initWithX:(CGFloat)x AndWithY:(CGFloat)y
{
    if ((self = [super init])) {
        self.x = x;
        self.y = y;
    }
    
    return self;
}

@end
