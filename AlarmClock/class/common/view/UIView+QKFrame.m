//
//  UIView+QKFrame.m
//  Gigle
//
//  Created by 丁乾坤 on 16/9/9.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "UIView+QKFrame.h"

@implementation UIView (QKFrame)

- (void)setQk_x:(CGFloat)qk_x{
    CGRect frame = self.frame;
    frame.origin.x = qk_x;
    self.frame = frame;
}

- (void)setQk_y:(CGFloat)qk_y{
    CGRect frame = self.frame;
    frame.origin.y = qk_y;
    self.frame = frame;
}

- (void)setQk_width:(CGFloat)qk_width{
    CGRect frame = self.frame;
    frame.size.width = qk_width;
    self.frame = frame;
}

- (void)setQk_height:(CGFloat)qk_height{
    CGRect frame = self.frame;
    frame.size.height = qk_height;
    self.frame = frame;
}

- (CGFloat)qk_x{
    return self.frame.origin.x;
}

- (CGFloat)qk_y{
    return self.frame.origin.y;
}

- (CGFloat)qk_width{
    return self.frame.size.width;
}

- (CGFloat)qk_height{
    return self.frame.size.height;
}

- (CGFloat)qk_centerX{
    return self.center.x;
}

- (void)setQk_centerX:(CGFloat)qk_centerX{
    CGPoint center = self.center;
    center.x = qk_centerX;
    self.center = center;
}

- (CGFloat)qk_centerY{
    return self.center.y;
}

- (void)setQk_centerY:(CGFloat)qk_centerY{
    CGPoint center = self.center;
    center.y = qk_centerY;
    self.center = center;
}

- (void)setQk_size:(CGSize)qk_size{
    CGRect frame = self.frame;
    frame.size = qk_size;
    self.frame = frame;
}

- (CGSize)qk_size{
    return self.frame.size;
}

- (CGFloat)qk_right{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)qk_bottom{
    return CGRectGetMaxY(self.frame);
}

- (void)setQk_right:(CGFloat)qk_right{
    self.qk_x = qk_right - self.qk_width;
}

- (void)setQk_bottom:(CGFloat)qk_bottom{
    self.qk_y = qk_bottom - self.qk_height;
}


+ (instancetype)SG_viewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

@end
