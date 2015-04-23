//
//  ViewController.m
//  WJChart
//
//  Created by Alireza Arabi on 1/21/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "ViewController.h"
#import "WJLineChartAxis.h"
#import "WJLineChart.h"
#import "WJLineChartData.h"
#import "WJLineChartDataItem.h"

#define ARC4RANDOM_MAX 0x100000000

@interface ViewController ()

@property (nonatomic,strong) UIView *detailsView;
@property (nonatomic,strong) WJLineChart *lineChart;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGRect chartFrame = CGRectMake(SCREEN_WIDTH /6.0 - 30, 135, SCREEN_WIDTH - (SCREEN_WIDTH / 5), SCREEN_WIDTH - (SCREEN_WIDTH / 2));
    _lineChart = [[WJLineChart alloc] initWithFrame:chartFrame];

    [_lineChart setXAxisMinimumValue:10 AndMaxValue:100 toTicksNumber:4];
    [_lineChart setYAxisMinimumValue:20 AndMaxValue:250 toTicksNumber:4];
    [_lineChart setUseStackMetricSources:false];
    [_lineChart setup];
    
    [_lineChart.lineChartAxis setShowVerticalLines:false];

    NSArray * data01Array = [self randomSetOfObjects];
    WJLineChartData *data01 = [WJLineChartData new];
    data01.diagramName = @"Diagram 1";
    data01.strokeColor = WJGreen;
    data01.stackColor = [WJGreen colorWithAlphaComponent:0.3];
    data01.lineWidth = 1.5f;
    data01.itemCount = [[data01Array objectAtIndex:0] count];
    __block NSMutableArray *XAr1 = [NSMutableArray arrayWithArray:[data01Array objectAtIndex:0]];
    __block NSMutableArray *YAr1 = [NSMutableArray arrayWithArray:[data01Array objectAtIndex:1]];
    data01.getData = ^(NSUInteger index) {
        CGFloat xValue = [[XAr1 objectAtIndex:index] floatValue];
        CGFloat yValue = [[YAr1 objectAtIndex:index] floatValue];
        return [WJLineChartDataItem dataItemWithX:xValue AndWithY:yValue];
    };
    
    NSArray * data02Array = [self randomSetOfObjects];
    WJLineChartData *data02 = [WJLineChartData new];
    data02.diagramName = @"Diagram 2";
    data02.strokeColor = WJTwitterColor;
    data02.stackColor = [WJTwitterColor colorWithAlphaComponent:0.3];
    data02.lineWidth = 1.5f;
    data02.itemCount = [[data02Array objectAtIndex:0] count];
    __block NSMutableArray *XAr2 = [NSMutableArray arrayWithArray:[data02Array objectAtIndex:0]];
    __block NSMutableArray *YAr2 = [NSMutableArray arrayWithArray:[data02Array objectAtIndex:1]];
    data02.getData = ^(NSUInteger index) {
        CGFloat xValue = [[XAr2 objectAtIndex:index] floatValue];
        CGFloat yValue = [[YAr2 objectAtIndex:index] floatValue];
        return [WJLineChartDataItem dataItemWithX:xValue AndWithY:yValue];
    };
    
    NSArray * data03Array = [self randomSetOfObjects];
    WJLineChartData *data03 = [WJLineChartData new];
    data03.diagramName = @"Diagram 3";
    data03.strokeColor = WJYellow;
    data03.stackColor = [WJYellow colorWithAlphaComponent:0.3];
    data03.lineWidth = 1.5f;
    data03.itemCount = [[data03Array objectAtIndex:0] count];
    __block NSMutableArray *XAr3 = [NSMutableArray arrayWithArray:[data03Array objectAtIndex:0]];
    __block NSMutableArray *YAr3 = [NSMutableArray arrayWithArray:[data03Array objectAtIndex:1]];
    data03.getData = ^(NSUInteger index) {
        CGFloat xValue = [[XAr3 objectAtIndex:index] floatValue];
        CGFloat yValue = [[YAr3 objectAtIndex:index] floatValue];
        return [WJLineChartDataItem dataItemWithX:xValue AndWithY:yValue];
    };
    
    _lineChart.center = self.view.center;
    _lineChart.chartData = @[data01,data02,data03];
    _lineChart.delegate = self;
    
    [_lineChart strokeChart];
    
    [self.view addSubview:_lineChart];

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)userClickedOnLineKeyPoint:(CGPoint)point diagramNames:(NSArray *)diagramName diagramResult:(NSArray *)diagramResult diagramColor:(NSArray *) diagramColor
{
    _detailsView = [[UIView alloc]init];

    CGSize maximumDiagramNameLabelSize   = CGSizeMake(60, 20);
    CGSize maximumDiagramResultLabelSize = CGSizeMake(15, 20);
    
    _detailsView.frame = CGRectMake(point.x, point.y, 90 , (diagramName.count * 25) + 5);
    _detailsView.backgroundColor = [WJGrey colorWithAlphaComponent:0.7];
    
    CGFloat borderWidth = 2.0f;
    _detailsView.frame = CGRectInset(_detailsView.frame, -borderWidth, -borderWidth);
    _detailsView.layer.borderColor = WJGrey.CGColor ;
    _detailsView.layer.borderWidth = borderWidth;
    
    //FADE IN
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.25f;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:1.0f];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    animation.additive = NO;
    
    for (int i = 0 ; i < diagramName.count; i++) {
    
        UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(5, 5 + (i * 25), maximumDiagramNameLabelSize.width, maximumDiagramNameLabelSize.height)];
        UILabel *labelResult = [[UILabel alloc] initWithFrame:CGRectMake(70, 5 + (i * 25), maximumDiagramResultLabelSize.width, maximumDiagramResultLabelSize.height)];
        
        labelName.text = [NSString stringWithFormat:@"%@:",[diagramName objectAtIndex:i]];
        labelName.font = [UIFont fontWithName:@"Futura-Medium" size:10.0];
        labelName.textColor = [diagramColor objectAtIndex:i];
        labelName.textAlignment = NSTextAlignmentLeft;
        labelName.lineBreakMode = NSLineBreakByTruncatingTail;
        
        labelResult.text = [diagramResult objectAtIndex:i];
        labelResult.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:12.0];
        labelResult.textColor = WJBlack;
        labelResult.textAlignment = NSTextAlignmentCenter;
        
        [_detailsView addSubview:labelName];
        [_detailsView addSubview:labelResult];

    }
    
    [_detailsView.layer addAnimation:animation forKey:@"opacityIN"];
    [self.view addSubview:_detailsView];
}

- (void)userClickedOnLineKeyPoint
{
    if (_detailsView) {
        
        //FADE OUT
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.duration = 0.25f;
        animation.fromValue = [NSNumber numberWithFloat:1.0f];
        animation.toValue = [NSNumber numberWithFloat:0.0f];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeBoth;
        animation.additive = NO;
        [_detailsView.layer addAnimation:animation forKey:@"opacityOUT"];
        
        [_detailsView removeFromSuperview];

    }
}

- (NSArray *)randomSetOfObjects
{

    NSMutableArray *array = [NSMutableArray array];
    NSString *LabelFormat = @"%1.f";
    __block NSMutableArray *XAr = [NSMutableArray array];
    __block NSMutableArray *YAr = [NSMutableArray array];
    
    NSSortDescriptor *aSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES comparator:^(id obj1, id obj2) {
        
        if ([obj1 intValue] > [obj2 intValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 intValue] < [obj2 intValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];

    
    for (int i = 0; i < 15 ; i++) {
        [XAr addObject:[NSString stringWithFormat:LabelFormat,(((double)arc4random() / ARC4RANDOM_MAX) * (self.lineChart.axisXMaxValue - self.lineChart.axisXMinValue) + self.lineChart.axisXMinValue)]];
        [YAr addObject:[NSString stringWithFormat:LabelFormat,(((double)arc4random() / ARC4RANDOM_MAX) * (self.lineChart.axisYMaxValue - self.lineChart.axisYMinValue) + self.lineChart.axisYMinValue)]];
    }
    
    NSArray *XArray = [NSArray array];
    XArray = [NSMutableArray arrayWithArray:[XAr sortedArrayUsingDescriptors:[NSArray arrayWithObject:aSortDescriptor]]];
    
    [array addObject:XArray];
    [array addObject:YAr];
    return (NSArray*) array;
}

@end
