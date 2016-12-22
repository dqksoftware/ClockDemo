//
//  QKEditAlermView.m
//  AlarmClock
//
//  Created by wsy on 2016/12/22.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKEditAlermView.h"

@implementation QKEditAlermView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    CGFloat leftMargin = 40.f;
//    CGFloat rightMargin = leftMargin;
    CGFloat buttonBettwen = 30.f;
    
    CGFloat buttonWidth = (SWIDTH - leftMargin * 2 - buttonBettwen * 2) / 3;
    //删除按钮
    self.delegateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.delegateButton.backgroundColor = [UIColor redColor];
    [self addSubview:self.delegateButton];
    [self.delegateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(buttonWidth));
        make.height.equalTo(self.mas_height);
    }];
    //编辑按钮
    self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editButton.backgroundColor = [UIColor blueColor];
    [self addSubview:self.editButton];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.delegateButton.mas_left).offset(-buttonBettwen);
        make.width.equalTo(@(buttonWidth));
        make.height.equalTo(self.mas_height);
    }];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton.backgroundColor = [UIColor greenColor];
    [self addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.delegateButton.mas_right).offset(buttonBettwen);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.mas_height);
        make.width.equalTo(@(buttonWidth));
    }];
    
}




@end
