//
//  AxisLabel.m
//  WJChart
//
//  Created by Alireza Arabi on 1/21/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "AxisLabel.h"

@implementation AxisLabel

- (id)init
{
    self = [super init];
    if (self)
    {
        self.font = [UIFont fontWithName:@"Avenir-Medium" size:12.0];
        _descriptionTextColor = [UIColor blackColor];
        _descriptionTextShadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _descriptionTextShadowOffset =  CGSizeMake(0, 1);
        _labelFormat = @"%1.f";
    }
    return self;
}
  
  
@end
