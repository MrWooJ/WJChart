//
//  WJLineChart.h
//  WJChart
//
//  Created by Alireza Arabi on 1/21/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJColor.h"
#import "WJLineChartAxis.h"
#import "WJChartDelegate.h"

@interface WJLineChart : UIView

@property (nonatomic, weak) id <WJChartDelegate> delegate;

@property (nonatomic,strong) WJLineChartAxis *lineChartAxis;

@property (nonatomic) int resolution;

@property (nonatomic) NSArray *chartData;

@property (nonatomic) CGFloat axisXMinValue;
@property (nonatomic) CGFloat axisXMaxValue;

@property (nonatomic) CGFloat axisYMinValue;
@property (nonatomic) CGFloat axisYMaxValue;

@property (nonatomic) int axisXTicksNumber;
@property (nonatomic) int axisYTicksNumber;

@property (nonatomic) BOOL useStackMetricSources;

- (void)setYAxisMinimumValue:(CGFloat)minVal AndMaxValue:(CGFloat)maxVal toTicksNumber:(int) ticks;
- (void)setXAxisMinimumValue:(CGFloat)minVal AndMaxValue:(CGFloat)maxVal toTicksNumber:(int) ticks;

- (void)setup;
- (void)strokeChart;


@end
