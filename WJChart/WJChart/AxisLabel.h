//
//  AxisLabel.h
//  WJChart
//
//  Created by Alireza Arabi on 1/21/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AxisLabel : UILabel

@property (nonatomic) UIFont  *descriptionTextFont;

@property (nonatomic) UIColor *descriptionTextColor;

@property (nonatomic) UIColor *descriptionTextShadowColor;

@property (nonatomic) CGSize   descriptionTextShadowOffset;

@property (nonatomic) NSString *labelFormat;

@end
