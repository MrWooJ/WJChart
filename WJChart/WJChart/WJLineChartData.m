//
//  WJLineChartData.m
//  WJChart
//
//  Created by Alireza Arabi on 1/21/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJLineChartData.h"

@implementation WJLineChartData

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setupDefaultValues];
    }
    return self;
}

- (void)setupDefaultValues
{
    _fillColor = [UIColor grayColor];
    _strokeColor = [UIColor grayColor];
    _stackColor = [_fillColor colorWithAlphaComponent:0.5];
    _lineWidth = 1.f;
    _alpha = 1.f;
}

@end
