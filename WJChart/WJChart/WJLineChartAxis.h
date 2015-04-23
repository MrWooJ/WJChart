//
//  WJLineChartAxis.h
//  WJChart
//
//  Created by Alireza Arabi on 1/21/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJLineChartAxis : UIView

@property (nonatomic) BOOL showAxisX;
@property (nonatomic) BOOL showAxisY;

@property (nonatomic) BOOL showVerticalLines;
@property (nonatomic) BOOL showHorizentalLines;

@property (nonatomic) BOOL showAxisXLabels;
@property (nonatomic) BOOL showAxisYLabels;

@property (nonatomic) UIColor *axisColor;
@property (nonatomic) CGFloat axisWidth;

@property (nonatomic) int axisXMargin;
@property (nonatomic) int axisYMargin;

@property (nonatomic) int axisXSteps;
@property (nonatomic) int axisYSteps;

@property (nonatomic) int vectorXSteps;
@property (nonatomic) int vectorYSteps;

@property (nonatomic) CGPoint vectorXStartPoint;
@property (nonatomic) CGPoint vectorYStartPoint;

@property (nonatomic) CGFloat vectorXSize;
@property (nonatomic) CGFloat vectorYSize;

@property (nonatomic) CGFloat axisXMinValue;
@property (nonatomic) CGFloat axisXMaxValue;

@property (nonatomic) CGFloat axisYMinValue;
@property (nonatomic) CGFloat axisYMaxValue;

@property (nonatomic) CGPoint chartStartPoint;

+ (WJLineChartAxis *)chartAxisWithFrame : (CGRect) frame;

- (void)setAxisXWithMinimumValue:(CGFloat)minVal andMaxValue:(CGFloat)maxVal toTicks:(int)numberOfTicks;
- (void)setAxisYWithMinimumValue:(CGFloat)minVal andMaxValue:(CGFloat)maxVal toTicks:(int)numberOfTicks;

- (void)setup;

@end