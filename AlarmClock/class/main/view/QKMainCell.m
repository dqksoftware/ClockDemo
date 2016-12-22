//
//  QKMainCell.m
//  AlarmClock
//
//  Created by 丁乾坤 on 2016/12/13.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKMainCell.h"
#import "PrefixHeader.pch"
@interface QKMainCell ()

@property(nonatomic, strong)UIImageView *backImageV;

@property(nonatomic, strong)UILabel *timeAndNoteLbl;  //时间备注标签

@property(nonatomic, strong)UILabel *weeksLbl; //周标签


@end

@implementation QKMainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addGesture];
     [self setUpView];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setUpView{
    CGFloat leftMarginLbl = 25.f;
    CGFloat leftMarginImg = 30.f;
    CGFloat centerYOffset = 7.f;
    CGFloat topMarginIg = 10.f;
    self.backImageV = [[UIImageView alloc] init];
    self.backImageV.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
//    self.backImageV.backgroundColor = [UIColor redColor];
    [self addSubview:self.backImageV];
    [self.backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(leftMarginImg);
        make.right.equalTo(self.contentView.mas_right).offset(-(leftMarginImg));
        make.top.equalTo(@(topMarginIg));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-topMarginIg);
    }];
    self.timeAndNoteLbl = [UILabel new];
    self.timeAndNoteLbl.textColor = [UIColor whiteColor];
    [self.backImageV addSubview:self.timeAndNoteLbl];
    self.timeAndNoteLbl.text = @"09:30/快起床了";
    [self.timeAndNoteLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(leftMarginLbl));
        make.right.equalTo(self.backImageV.mas_right).offset(-10);
        make.bottom.equalTo(self.backImageV.mas_centerY).offset(-(centerYOffset));
        make.height.equalTo(@18);
    }];
    
    self.weeksLbl = [UILabel new];
    self.weeksLbl.textColor = [UIColor whiteColor];
    [self.backImageV addSubview:self.weeksLbl];
    self.weeksLbl.text = @"周一、周二、周三";
    [self.weeksLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeAndNoteLbl.mas_left);
        make.height.equalTo(self.timeAndNoteLbl.mas_height);
        make.right.equalTo(self.timeAndNoteLbl.mas_right);
        make.top.equalTo(self.backImageV.mas_centerY).offset(10);
    }];
    
    self.editAlertView = [[QKEditAlermView alloc] initWithFrame:CGRectMake(0, 0, 0, self.backImageV.qk_height)];
    [self.backImageV addSubview:self.editAlertView];
//    [self.editAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.backImageV.mas_right);
//        make.height.equalTo(self.backImageV.mas_height);
//        make.width.equalTo(@(0));
//        make.top.equalTo(self.backImageV.mas_top);
//    }];
}

- (void)addGesture{
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handGesture:)];
    [self addGestureRecognizer:longPressGesture];
}

- (void)handGesture:(UILongPressGestureRecognizer *)gesture{
    if (self.delegate && [self.delegate respondsToSelector:@selector(qk_MainCellHandLongGesture:)]) {
        [self.delegate qk_MainCellHandLongGesture:gesture];
        [UIView animateWithDuration:0.5 animations:^{
            self.editAlertView.qk_x = 0;
            self.editAlertView.qk_height = self.backImageV.qk_height;
            self.editAlertView.qk_width = self.backImageV.qk_width;

        }];
    }
}



@end
