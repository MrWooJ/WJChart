//
//  PNChartDelegate.h
//  PNChartDemo
//
//  Created by kevinzhow on 13-12-11.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WJChartDelegate <NSObject>

@optional

- (void)userClickedOnLineKeyPoint:(CGPoint)point
                     diagramNames:(NSArray *)diagramName
                    diagramResult:(NSArray *)diagramResult
                     diagramColor:(NSArray *)diagramColor;

- (void)userClickedOnLineKeyPoint;

@end
