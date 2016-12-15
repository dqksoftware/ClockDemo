//
//  UIView+QKFrame.h
//  Gigle
//
//  Created by 丁乾坤 on 16/9/9.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (QKFrame)
@property (nonatomic ,assign) CGFloat qk_x;
@property (nonatomic ,assign) CGFloat qk_y;
@property (nonatomic ,assign) CGFloat qk_width;
@property (nonatomic ,assign) CGFloat qk_height;
@property (nonatomic ,assign) CGFloat qk_centerX;
@property (nonatomic ,assign) CGFloat qk_centerY;

@property (nonatomic ,assign) CGSize qk_size;

@property (nonatomic, assign) CGFloat qk_right;
@property (nonatomic, assign) CGFloat qk_bottom;

+ (instancetype)qk_viewFromXib;


@end
