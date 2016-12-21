//
//  QKSecondsDialView.m
//  AlarmClock
//
//  Created by wsy on 2016/12/21.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKSecondsDialView.h"
#import "QKDateTool.h"
#import "QKMainTimeModel.h"

@interface  QKSecondsDialView()

@property(nonatomic, strong)UIView *secondsDialView;

@property(nonatomic, strong)UILabel *beforeSelectView;

@property(nonatomic, strong)NSMutableArray *labelArrayM;   //标签数组

@property(nonatomic, strong)NSTimer *timer;

@end

@implementation QKSecondsDialView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.labelArrayM = [NSMutableArray array];
        [self setUpView];
        [self addTimeer];
    }
    return self;
}

- (void)setUpView{
    CGFloat circle_x = SWIDTH / 2;
    self.secondsDialView = [[UIView alloc] initWithFrame:CGRectZero];
    self.secondsDialView.qk_height = 2 * seconds_circle_radius;
    self.secondsDialView.qk_width = 2 * seconds_circle_radius;
    self.secondsDialView.qk_y = circle_y;
    self.secondsDialView.qk_x = circle_x;
    self.secondsDialView.layer.masksToBounds = YES;
    self.secondsDialView.layer.cornerRadius = YES;
    self.secondsDialView.layer.masksToBounds = YES;
    self.secondsDialView.layer.cornerRadius = seconds_circle_radius;
    [self createDialView:seconds_circle_startAngle endAgle:seconds_circle_endAngle radius:seconds_circle_radius + 5 centerCircle:CGPointMake(SWIDTH / 2, circle_y) timeType:0];
}

#pragma mark  创建转盘
- (UIView *)createDialView:(CGFloat)startAngle endAgle:(CGFloat)endAngle radius:(CGFloat)radius centerCircle:(CGPoint)centerCircle timeType:(Time)timeType{
    //转盘视图
    UIView *deialPointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * radius, 2 * radius)];
    deialPointView.qk_centerX = centerCircle.x;
    deialPointView.qk_centerY = centerCircle.y;
    [self addSubview:deialPointView];
    NSInteger lblconut = 60;
    for (int i = 0; i < lblconut; i++) {
        CGPoint point = [QKDateTool calcCircleCoordinateWithCenter:centerCircle andWithAngle:startAngle andWithRadius:radius];
        UILabel *lable = [[UILabel alloc] init];
        lable.qk_height = 10;
        lable.qk_width = 3;
        lable.qk_y = point.y - lable.qk_height;
        lable.qk_x = point.x;
        lable.backgroundColor = [UIColor whiteColor];
        //切记 此View是以90度为0度的
        CGFloat offsetAngle = 90 - startAngle;
        if (startAngle >= 90) {
            lable.transform = CGAffineTransformMakeRotation(offsetAngle / 90);
        }else{
            lable.transform = CGAffineTransformMakeRotation(offsetAngle / 90);
        }
        [self.labelArrayM addObject:lable];
        [deialPointView addSubview:lable];
        startAngle -= (seconds_circle_startAngle - seconds_circle_endAngle) / 60;
    }
    return deialPointView;
}

//添加定时器
- (void)addTimeer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    [timer fire];
}


- (void)timeAction{

    NSInteger seconds = [QKDateTool getPointsForNowTime:TimeSeconds].integerValue;
    UILabel *selectView = self.labelArrayM[seconds];
    if (self.beforeSelectView != selectView) {
        self.beforeSelectView.backgroundColor = [UIColor whiteColor];
        self.beforeSelectView = selectView;
    }
    selectView.backgroundColor = [UIColor blackColor];
    
}







@end
