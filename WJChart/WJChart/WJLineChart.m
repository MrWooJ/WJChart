//
//  WJLineChart.m
//  WJChart
//
//  Created by Alireza Arabi on 1/21/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "WJLineChart.h"
#import "WJLineChartData.h"
#import "WJLineChartDataItem.h"

@interface WJLineChart ()

@property (nonatomic, weak) CAShapeLayer *pathLayer;
@property (nonatomic, weak) NSMutableArray *verticalLineLayer;
@property (nonatomic, weak) NSMutableArray *horizentalLinepathLayer;

@property (nonatomic) CGPoint startPoint;

@property (nonatomic) CGPoint startPointVectorX;
@property (nonatomic) CGPoint endPointVecotrX;

@property (nonatomic) CGPoint startPointVectorY;
@property (nonatomic) CGPoint endPointVecotrY;

@property (nonatomic) CGFloat vectorX_Size;
@property (nonatomic) CGFloat vectorY_Size;

@property (nonatomic) NSMutableArray *axisX_labels;
@property (nonatomic) NSMutableArray *axisY_labels;

@property (nonatomic) CGFloat AxisX_Margin;
@property (nonatomic) CGFloat AxisY_Margin;

@property (nonatomic) NSMutableArray *chartLineArray;

@property (nonatomic) NSMutableArray *chartXPointArray;
@property (nonatomic) NSMutableArray *chartYPointArray;
@property (nonatomic) NSMutableArray *chartNPointArray;
@property (nonatomic) NSMutableArray *chartCPointArray;

@property (nonatomic) NSMutableArray *chartLineLayers;
@property (nonatomic) NSMutableArray *chartPathLayer;

@property (nonatomic,strong) CAShapeLayer *detectLine;


@end

@implementation WJLineChart

#pragma mark initialization

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

- (void)setupDefaultValues
{
    // Initialization code
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds   = YES;

    _useStackMetricSources = false;
    
    _chartLineArray = [NSMutableArray array];
    
    _chartXPointArray = [NSMutableArray array];
    _chartYPointArray = [NSMutableArray array];
    _chartNPointArray = [NSMutableArray array];
    _chartCPointArray = [NSMutableArray array];
    
    _chartLineLayers = [NSMutableArray array];
    _chartPathLayer = [NSMutableArray array];
    
    _detectLine = [CAShapeLayer layer];
    
    _resolution = 5;
    
    CGRect rect = CGRectMake(0, 0, self.frame.size.width - 35 , self.frame.size.height - 45);
    _lineChartAxis = [[WJLineChartAxis alloc] initWithFrame:rect];
    _lineChartAxis.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
}

- (void)setChartData:(NSArray *)data
{
    CGFloat yFinilizeValue , xFinilizeValue;
    CGFloat yValue , xValue;

    for (WJLineChartData *chartData in data) {
        NSMutableArray *pAr = [NSMutableArray array];
        for (NSUInteger i = 0; i < chartData.itemCount; i++) {
            yValue = chartData.getData(i).y;
            xValue = chartData.getData(i).x;
            if (!(xValue >= _axisXMinValue && xValue <= _axisXMaxValue) || !(yValue >= _axisYMinValue && yValue <= _axisYMaxValue)){
                NSLog(@"input is not in correct range.");
                exit(0);
            }
            xFinilizeValue = [self mappingIsForAxisX:true WithValue:xValue];
            yFinilizeValue = [self mappingIsForAxisX:false WithValue:yValue];
            CGPoint p = CGPointMake(xFinilizeValue, yFinilizeValue);
            NSValue *valPoint = [NSValue valueWithCGPoint:p];
            [pAr addObject:valPoint];
            [self.chartXPointArray addObject:[NSString stringWithFormat:@"%f",xFinilizeValue]];
            [self.chartYPointArray addObject:[NSString stringWithFormat:@"%1.f",yValue]];
            [self.chartNPointArray addObject:chartData.diagramName];
            [self.chartCPointArray addObject:chartData.strokeColor];
        }
        [self.chartLineArray addObject:pAr];
    }
    _chartData = data;
}

- (CGFloat)mappingIsForAxisX : (BOOL) isForAxisX WithValue : (CGFloat) value
{
    if (isForAxisX) {
        float temp = _lineChartAxis.chartStartPoint.x + (_lineChartAxis.vectorXSteps / 2) + _lineChartAxis.axisXMargin ;
        CGFloat xPos = temp + (((value - _axisXMinValue)/_lineChartAxis.axisXSteps) * _lineChartAxis.vectorXSteps) ;
        return xPos;
    }
    else {
        float temp = _lineChartAxis.chartStartPoint.y - (_lineChartAxis.vectorYSteps / 2) + _lineChartAxis.axisYMargin;
        CGFloat yPos = temp - (((value - _axisYMinValue) /_lineChartAxis.axisYSteps) * _lineChartAxis.vectorYSteps);
        return yPos;
    }
    return 0;
}

- (void)strokeChart
{
    for (NSUInteger lineIndex = 0; lineIndex < self.chartData.count; lineIndex++) {
        WJLineChartData *chartData = self.chartData[lineIndex];

        NSMutableArray *ar = [self.chartLineArray objectAtIndex:lineIndex];
        
        if (_useStackMetricSources) {
            NSValue *fp = [NSValue valueWithCGPoint:CGPointMake([[ar firstObject] CGPointValue].x, _lineChartAxis.vectorXStartPoint.y + _lineChartAxis.axisYMargin + 2)];
            NSValue *ep = [NSValue valueWithCGPoint:CGPointMake([[ar lastObject] CGPointValue].x, _lineChartAxis.vectorXStartPoint.y + _lineChartAxis.axisYMargin + 2)];

            [ar insertObject:fp atIndex:0];
            [ar addObject:ep];

            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:[[ar objectAtIndex:0] CGPointValue]];
            
            for (int i = 1 ; i < ar.count ; i++) {
                [path addLineToPoint:[[ar objectAtIndex:i] CGPointValue]];
            }
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = [path CGPath];
            
            shapeLayer.name = [NSString stringWithFormat:@"Diagram #: %i",(int)lineIndex];
            shapeLayer.frame = CGPathGetBoundingBox(shapeLayer.path);
            shapeLayer.bounds = CGPathGetBoundingBox( shapeLayer.path );
            
            shapeLayer.strokeColor = [chartData.strokeColor CGColor];
            shapeLayer.lineWidth = [chartData lineWidth];
            shapeLayer.fillColor = [chartData.stackColor CGColor];
            // adding animation to path
            CABasicAnimation *animateStrokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animateStrokeEnd.duration  = 0;
            animateStrokeEnd.fromValue = [NSNumber numberWithFloat:0.0f];
            animateStrokeEnd.toValue   = [NSNumber numberWithFloat:1.0f];
            [shapeLayer addAnimation:animateStrokeEnd forKey:nil];
            [self.layer addSublayer:shapeLayer];
            [self.chartLineLayers addObject:shapeLayer];
            [ar removeAllObjects];
        }
        else {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:[[ar objectAtIndex:0] CGPointValue]];
            
            for (int i = 1 ; i < ar.count ; i++) {
                [path addLineToPoint:[[ar objectAtIndex:i] CGPointValue]];
            }

            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = [path CGPath];
            
            shapeLayer.name = [NSString stringWithFormat:@"Diagram #: %i",(int)lineIndex];
            shapeLayer.frame = CGPathGetBoundingBox(shapeLayer.path);
            shapeLayer.bounds = CGPathGetBoundingBox( shapeLayer.path );
            
            shapeLayer.strokeColor = [chartData.strokeColor CGColor];
            shapeLayer.fillColor = [[UIColor clearColor] CGColor];
            shapeLayer.lineWidth = [chartData lineWidth];
            // adding animation to path
            CABasicAnimation *animateStrokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animateStrokeEnd.duration  = 1;
            animateStrokeEnd.fromValue = [NSNumber numberWithFloat:0.0f];
            animateStrokeEnd.toValue   = [NSNumber numberWithFloat:1.0f];
            [shapeLayer addAnimation:animateStrokeEnd forKey:nil];
            [self.layer addSublayer:shapeLayer];
            [self.chartLineLayers addObject:shapeLayer];
            [ar removeAllObjects];
        }
    }
}

- (void)setXAxisMinimumValue:(CGFloat)minVal AndMaxValue:(CGFloat)maxVal toTicksNumber:(int)ticks
{
    _axisXMinValue = minVal;
    _axisXMaxValue = maxVal;
    _axisXTicksNumber = ticks;
    
    [_lineChartAxis setAxisXWithMinimumValue:_axisXMinValue andMaxValue:_axisXMaxValue toTicks:_axisXTicksNumber];
}

- (void)setYAxisMinimumValue:(CGFloat)minVal AndMaxValue:(CGFloat)maxVal toTicksNumber:(int)ticks
{
    _axisYMinValue = minVal;
    _axisYMaxValue = maxVal;
    _axisYTicksNumber = ticks;
    
    [_lineChartAxis setAxisYWithMinimumValue:_axisYMinValue andMaxValue:_axisYMaxValue toTicks:_axisYTicksNumber];
}

- (void)setup
{
    [_lineChartAxis setup];
    [self addSubview:_lineChartAxis];
}


#pragma mark - Touch at point

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_delegate userClickedOnLineKeyPoint];
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    CGPoint touchPointInSuperView = [touch locationInView:self.superview];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(touchPoint.x, _lineChartAxis.vectorXStartPoint.y + _lineChartAxis.axisYMargin + 2)];
    [path addLineToPoint:CGPointMake(touchPoint.x, _lineChartAxis.vectorXStartPoint.y + _lineChartAxis.axisYMargin + 2 - _lineChartAxis.vectorYSize)];
    
    //FADE IN
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.25f;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:1.0f];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    animation.additive = NO;
    [_detectLine addAnimation:animation forKey:@"opacityIN"];
    
    _detectLine.path = [path CGPath];
    _detectLine.strokeColor = [WJBlack CGColor];
    _detectLine.fillColor = [[UIColor clearColor] CGColor];
    _detectLine.lineWidth = 0.2f;
    
    _detectLine.frame = CGPathGetBoundingBox(_detectLine.path);
    _detectLine.bounds = CGPathGetBoundingBox(_detectLine.path);
    
    [self.layer addSublayer:_detectLine];

    NSMutableArray *diagramNameArray = [NSMutableArray array];
    NSMutableArray *diagramResultArray = [NSMutableArray array];
    NSMutableArray *diagramNameColor = [NSMutableArray array];

    for (int i = 0; i < self.chartXPointArray.count; i++) {
        if (fabsf((touchPoint.x - [[self.chartXPointArray objectAtIndex:i] floatValue])) < 2.0f) {
            [diagramNameArray addObject:[self.chartNPointArray objectAtIndex:i]];
            [diagramResultArray addObject:[self.chartYPointArray objectAtIndex:i]];
            [diagramNameColor addObject:[self.chartCPointArray objectAtIndex:i]];
        }
    }
    
    if (diagramNameArray.count > 0) {
        [_delegate userClickedOnLineKeyPoint:CGPointMake(touchPointInSuperView.x + 3, self.frame.origin.y + (2 * _lineChartAxis.axisYMargin) ) diagramNames:diagramNameArray diagramResult:diagramResultArray diagramColor:diagramNameColor];
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_delegate userClickedOnLineKeyPoint];
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    CGPoint touchPointInSuperView = [touch locationInView:self.superview];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(touchPoint.x, _lineChartAxis.vectorXStartPoint.y + _lineChartAxis.axisYMargin + 2)];
    [path addLineToPoint:CGPointMake(touchPoint.x, _lineChartAxis.vectorXStartPoint.y + _lineChartAxis.axisYMargin + 2 - _lineChartAxis.vectorYSize)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [WJBlack CGColor];
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.lineWidth = 0.2f;
    
    shapeLayer.frame = CGPathGetBoundingBox(shapeLayer.path);
    shapeLayer.bounds = CGPathGetBoundingBox(shapeLayer.path);

    [self.layer replaceSublayer:_detectLine with:shapeLayer];
    _detectLine = shapeLayer;
    
    NSMutableArray *diagramNameArray = [NSMutableArray array];
    NSMutableArray *diagramResultArray = [NSMutableArray array];
    NSMutableArray *diagramNameColor = [NSMutableArray array];
    
    for (int i = 0; i < self.chartXPointArray.count; i++) {
        if (fabsf((touchPoint.x - [[self.chartXPointArray objectAtIndex:i] floatValue])) < 2.0f) {
            [diagramNameArray addObject:[self.chartNPointArray objectAtIndex:i]];
            [diagramResultArray addObject:[self.chartYPointArray objectAtIndex:i]];
            [diagramNameColor addObject:[self.chartCPointArray objectAtIndex:i]];
        }
    }
    if (diagramNameArray.count > 0) {
        [_delegate userClickedOnLineKeyPoint:CGPointMake(touchPointInSuperView.x + 3, self.frame.origin.y + (2 * _lineChartAxis.axisYMargin) ) diagramNames:diagramNameArray diagramResult:diagramResultArray diagramColor:diagramNameColor];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //FADE OUT
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.25f;
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    animation.additive = NO;
    [_detectLine addAnimation:animation forKey:@"opacityOUT"];

    [_delegate userClickedOnLineKeyPoint];
}

@end
