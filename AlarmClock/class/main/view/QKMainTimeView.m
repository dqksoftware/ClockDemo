//
//  QKMainTimeView.m
//  AlarmClock
//
//  Created by wsy on 2016/12/19.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKMainTimeView.h"

@interface QKMainTimeView ()

@property(nonatomic, strong)UILabel *timeLabel;  //时间标签

@property(nonatomic, strong)UILabel *yearLabel;   //日期标签


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
    //时间标签
    self.timeLabel = [UILabel new];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.font = [UIFont boldSystemFontOfSize:80];
    self.timeLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-25);
        make.top.equalTo(self.mas_top);
    }];
    
    //日期标签
    self.yearLabel = [UILabel new];
    self.yearLabel.textColor = [UIColor whiteColor];
    self.yearLabel.textAlignment = NSTextAlignmentCenter;
    self.yearLabel.font = [UIFont systemFontOfSize:23];
    [self addSubview:self.yearLabel];
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(self.timeLabel.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}


//重写setter方法
- (void)setMainTimeModel:(QKMainTimeModel *)mainTimeModel{
    _mainTimeModel = mainTimeModel;
    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@", mainTimeModel.hour, mainTimeModel.minutes];
    self.yearLabel.text = [NSString stringWithFormat:@"%@/%@/%@  %@", mainTimeModel.year, mainTimeModel.month, mainTimeModel.day, mainTimeModel.weeks];
}

@end
