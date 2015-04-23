//
//  WJLineChartAxis.m
//  WJChart
//
//  Created by Alireza Arabi on 1/21/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJLineChartAxis.h"
#import "AxisLabel.h"

@interface WJLineChartAxis ()

@property (nonatomic,strong) AxisLabel *label;

@property (nonatomic) int axisXTicksNumber;
@property (nonatomic) int axisYTicksNumber;

@property (nonatomic) CGPoint vectorXEndPoint;
@property (nonatomic) CGPoint vectorYEndPoint;

@property (nonatomic,strong) NSMutableArray *axisXLabels;
@property (nonatomic,strong) NSMutableArray *axisYLabels;

@end

@implementation WJLineChartAxis

+ (WJLineChartAxis *)chartAxisWithFrame : (CGRect) frame
{
    return [[WJLineChartAxis alloc] initWithFrame:frame];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self)
    {
        [self setupDefaultValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setupDefaultValues];
    }
    return self;
}

- (void)setup
{
    [self vectorXSetup];
    [self vectorYSetup];
}

- (void)setupDefaultValues
{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds   = NO;
    self.userInteractionEnabled = YES;

    _showAxisX = true;
    _showAxisY = true;
    _showAxisXLabels = true;
    _showAxisYLabels = true;
    
    _showHorizentalLines = true;
    _showVerticalLines = true;
    
    _label = [[AxisLabel alloc] init];

    _axisColor = [UIColor grayColor];
    _axisWidth = 1.f;
    
    _axisXMargin = 20;
    _axisYMargin = 20;
    
    _chartStartPoint.y = self.frame.size.height - self.axisYMargin ;
    _chartStartPoint.x = self.axisXMargin ;
    
    _axisXLabels = [NSMutableArray array];
    _axisYLabels = [NSMutableArray array];
    
}

- (void)setAxisXWithMinimumValue:(CGFloat)minVal andMaxValue:(CGFloat)maxVal toTicks:(int)numberOfTicks
{
    _axisXMinValue = minVal;
    _axisXMaxValue = maxVal;
    _axisXTicksNumber = numberOfTicks - 1;
    _axisXSteps = (float)((maxVal - minVal)/(numberOfTicks - 1));
    
    CGFloat tempValue = minVal ;
    _label.text = [NSString stringWithFormat:_label.labelFormat,minVal] ;
    [_axisXLabels addObject:_label.text];
    for (int i = 0 ; i < (numberOfTicks - 1); i++) {
        tempValue = tempValue + _axisXSteps;
        _label.text = [NSString stringWithFormat:_label.labelFormat,tempValue] ;
        [_axisXLabels addObject:_label.text];
    }
}

- (void)setAxisYWithMinimumValue:(CGFloat)minVal andMaxValue:(CGFloat)maxVal toTicks:(int)numberOfTicks
{
    _axisYMinValue = minVal;
    _axisYMaxValue = maxVal;
    _axisYTicksNumber = numberOfTicks - 1;
    _axisYSteps = (float)((maxVal - minVal)/(numberOfTicks - 1));
    
    CGFloat tempValue = minVal ;
    _label.text = [NSString stringWithFormat:_label.labelFormat,minVal] ;
    [_axisYLabels addObject:_label.text];
    for (int i = 0 ; i < (numberOfTicks - 1); i++) {
        tempValue = tempValue + _axisYSteps;
        _label.text = [NSString stringWithFormat:_label.labelFormat,tempValue] ;
        [_axisYLabels addObject:_label.text];
    }
}

- (void)vectorXSetup
{
    _axisXTicksNumber += 1;
    _vectorXSize = self.frame.size.width - (_axisXMargin) - 15 ;
    _vectorXSteps = (_vectorXSize) / (_axisXTicksNumber) ;
    _vectorXEndPoint = CGPointMake(_chartStartPoint.x + _vectorXSize, _chartStartPoint.y) ;
    _vectorXStartPoint = _chartStartPoint ;
}

- (void)vectorYSetup
{
    _axisYTicksNumber += 1;
    _vectorYSize = self.frame.size.height - (_axisYMargin) - 15;
    _vectorYSteps = (_vectorYSize) / (_axisYTicksNumber);
    _vectorYEndPoint = CGPointMake(_chartStartPoint.x, _chartStartPoint.y - _vectorYSize) ;
    _vectorYStartPoint = _chartStartPoint ;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (_showAxisX) {
        CGContextSetStrokeColorWithColor(context, [_axisColor CGColor]);
        CGContextSetLineWidth(context, _axisWidth);
        //drawing x vector
        CGContextMoveToPoint(context, _chartStartPoint.x, _chartStartPoint.y);
        CGContextAddLineToPoint(context, _vectorXEndPoint.x, _vectorXEndPoint.y);
        //drawing x arrow vector
        CGContextMoveToPoint(context, _vectorXEndPoint.x, _vectorXEndPoint.y);
        CGContextAddLineToPoint(context, _vectorXEndPoint.x - 5, _vectorXEndPoint.y + 3);
        CGContextMoveToPoint(context, _vectorXEndPoint.x, _vectorXEndPoint.y);
        CGContextAddLineToPoint(context, _vectorXEndPoint.x - 5, _vectorXEndPoint.y - 3);
    }
    
    if (_showAxisY) {
        CGContextSetStrokeColorWithColor(context, [_axisColor CGColor]);
        CGContextSetLineWidth(context, _axisWidth);
        //drawing y vector
        CGContextMoveToPoint(context, _chartStartPoint.x, _chartStartPoint.y);
        CGContextAddLineToPoint(context, _vectorYEndPoint.x, _vectorYEndPoint.y);
        //drawing y arrow vector
        CGContextMoveToPoint(context, _vectorYEndPoint.x, _vectorYEndPoint.y);
        CGContextAddLineToPoint(context, _vectorYEndPoint.x - 3, _vectorYEndPoint.y + 5);
        CGContextMoveToPoint(context, _vectorYEndPoint.x, _vectorYEndPoint.y);
        CGContextAddLineToPoint(context, _vectorYEndPoint.x + 3, _vectorYEndPoint.y + 5);
    }
    
    if (_showVerticalLines) {
        float temp = _vectorXStartPoint.x + (_vectorXSteps / 2) ;
        for (int i = 0; i < _axisXLabels.count; i++) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(temp, _vectorXStartPoint.y)];
            [path addLineToPoint:CGPointMake(temp, _vectorXStartPoint.y - _vectorYSize)];
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = [path CGPath];
            shapeLayer.strokeColor = [[_axisColor colorWithAlphaComponent:0.5] CGColor];
            shapeLayer.lineWidth = _axisWidth;
            shapeLayer.fillColor = [[_axisColor colorWithAlphaComponent:0.5] CGColor];
            [self.layer addSublayer:shapeLayer];
            temp = temp + _vectorXSteps ;
        }
    }
    
    if (_showHorizentalLines) {
        
        float temp = _vectorYStartPoint.y - (_vectorYSteps / 2) ;
        for (int i = 0; i < _axisYLabels.count; i++) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(_vectorYStartPoint.x, temp)];
            [path addLineToPoint:CGPointMake(_vectorYStartPoint.x + _vectorXSize, temp)];
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = [path CGPath];
            shapeLayer.strokeColor = [[_axisColor colorWithAlphaComponent:0.5] CGColor];
            shapeLayer.lineWidth = _axisWidth;
            shapeLayer.fillColor = [[_axisColor colorWithAlphaComponent:0.5] CGColor];
            [self.layer addSublayer:shapeLayer];
            temp = temp - _vectorYSteps ;
        }
    }
    
    if (_showAxisXLabels) {
        NSString *str;
        //drawing x steps vector and putting axis x labels
        float temp = _vectorXStartPoint.x + (_vectorXSteps / 2) ;
        for (int i = 0; i < _axisXLabels.count; i++) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(temp, _vectorXStartPoint.y - 2)];
            [path addLineToPoint:CGPointMake(temp, _vectorXStartPoint.y + 3)];
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = [path CGPath];
            shapeLayer.strokeColor = [_axisColor CGColor];
            shapeLayer.lineWidth = _axisWidth;
            shapeLayer.fillColor = [_axisColor CGColor];
            [self.layer addSublayer:shapeLayer];
            AxisLabel *lb = [[AxisLabel alloc] init];
            lb.text = [_axisXLabels objectAtIndex:i] ;
            str = lb.text;
            [self showXLabel:lb InPosition:CGPointMake(temp - 15, _vectorXStartPoint.y + 10 )];
            temp = temp + _vectorXSteps ;
        }
    }
    
    if (_showAxisYLabels) {
        NSString *str;
        //drawing y steps vector and putting axis x labels
        float temp = _vectorYStartPoint.y - (_vectorYSteps / 2) ;
        for (int i = 0; i < _axisYLabels.count; i++) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(_vectorYStartPoint.x - 3, temp)];
            [path addLineToPoint:CGPointMake(_vectorYStartPoint.x + 2, temp)];
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = [path CGPath];
            shapeLayer.strokeColor = [_axisColor CGColor];
            shapeLayer.lineWidth = _axisWidth;
            shapeLayer.fillColor = [_axisColor CGColor];
            [self.layer addSublayer:shapeLayer];
            AxisLabel *lb = [[AxisLabel alloc] init];
            lb.text = [_axisYLabels objectAtIndex:i];
            str = lb.text;
            [self showXLabel:lb InPosition:CGPointMake(_vectorYStartPoint.x - 30, temp - 5)];
            temp = temp - _vectorYSteps ;
        }
    }
    
    CGContextDrawPath(context, kCGPathStroke);
}

- (void) showXLabel : (AxisLabel *) descriptionLabel InPosition : (CGPoint) point
{
    CGRect frame = CGRectMake(point.x, point.y, 30, 10);
    descriptionLabel.frame = frame;
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    descriptionLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:descriptionLabel];
}


@end
