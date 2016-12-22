//
//  QKMainTimeView.m
//  AlarmClock
//
//  Created by wsy on 2016/12/19.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKMainTimeView.h"

@interface QKMainTimeView ()

@property(nonatomic, strong)UILabel *hourLabel;  //时间标签

@property(nonatomic, strong)UILabel *yearLabel;   //日期标签

@property(nonatomic, strong)UILabel *pointLabel;  //

@property(nonatomic, strong)UILabel *mintuesLabel;  //秒标签


@end

@implementation QKMainTimeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}
- (void)setUpView{
    
    self.pointLabel = [UILabel new];
    self.pointLabel.contentMode = UIViewContentModeCenter;
    [self addSubview:self.pointLabel];
    self.pointLabel.textAlignment = NSTextAlignmentCenter;
    self.pointLabel.font = [UIFont boldSystemFontOfSize:80];
    self.pointLabel.textColor = [UIColor whiteColor];
    [self.pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-45);
        make.top.equalTo(self.mas_top);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@20);
    }];
    
    //时间标签
    self.hourLabel = [UILabel new];
    self.hourLabel.textAlignment = NSTextAlignmentRight;
    self.hourLabel.font = [UIFont boldSystemFontOfSize:80];
    self.hourLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.hourLabel];
    [self.hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(self.pointLabel.mas_left);
        make.bottom.equalTo(self.mas_bottom).offset(-25);
        make.top.equalTo(self.mas_top);
    }];
    
    self.mintuesLabel = [UILabel new];
    self.mintuesLabel.textAlignment = NSTextAlignmentLeft;
    self.mintuesLabel.font = [UIFont boldSystemFontOfSize:80];
    self.mintuesLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.mintuesLabel];
    [self.mintuesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pointLabel.mas_right);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom).offset(-25);
    }];
    
    //日期标签
    self.yearLabel = [UILabel new];
    self.yearLabel.textColor = [UIColor whiteColor];
    self.yearLabel.textAlignment = NSTextAlignmentCenter;
    self.yearLabel.font = [UIFont systemFontOfSize:23];
    [self addSubview:self.yearLabel];
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(self.hourLabel.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
//重写setter方法
- (void)setMainTimeModel:(QKMainTimeModel *)mainTimeModel{
    _mainTimeModel = mainTimeModel;
    self.hourLabel.text = [NSString stringWithFormat:@"%@", mainTimeModel.hour];
    self.pointLabel.text = @":";
    self.mintuesLabel.text = [NSString stringWithFormat:@"%@", mainTimeModel.minutes];
    self.yearLabel.text = [NSString stringWithFormat:@"%@/%@/%@  %@", mainTimeModel.year, mainTimeModel.month, mainTimeModel.day, mainTimeModel.weeks];
}

@end
