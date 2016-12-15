//
//  QKDialView.m
//  AlarmClock
//
//  Created by 丁乾坤 on 2016/12/14.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKDialView.h"

typedef NS_ENUM(NSInteger, Time) {
    TimeHour = 0,
    TimePoints,
    TimeSeconds
};

@interface QKDialView ()

@property(nonatomic, strong)UIImageView *backGroundImage;

@property(nonatomic, strong)NSMutableArray *lblFrameArrayM;

@property(nonatomic, strong)NSMutableArray *lblArrayM;

@property(nonatomic, strong)NSTimer *timer;

@end

@implementation QKDialView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setUpView];
        self.backgroundColor = [UIColor redColor];
       // [self addTimeer];
        [self getPointsForNowTime];
        
    }
    return self;
}

//加载子视图
- (void)setUpView{
    //标签frame数组
    NSMutableArray *arrayFrame = [NSMutableArray array];
    self.lblFrameArrayM = arrayFrame;
    //标签数组
    NSMutableArray *lblArrayM = [NSMutableArray array];
    self.lblArrayM = lblArrayM;
    self.backGroundImage = [[UIImageView alloc] init];
    [self addSubview:self.backGroundImage];
    [self.backGroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(self.mas_height);
    }];
    CGFloat lblWidth = 30.f;
    CGFloat lblHeight = 25.f;
    CGFloat lblx;
    CGFloat lbly = 30.f;   //最高的y值是10；  最低的是30.
    CGFloat r = 380.f;  //圆的半径
    CGFloat x = SWIDTH / 2 - 7;  //圆心x坐标
    CGFloat y = 406; //圆心y坐标
    CGFloat startAngel = -240;  //开始弧度
    CGFloat endAngel = 60;      //结束弧度
    CGFloat criticalAngel = 90.f;
    NSInteger lblconut = (endAngel - startAngel) / 5;
    for (int i = 1; i <= lblconut; i++) {
        if (startAngel <= -270.f) {
            lblx = x + r * cosf(criticalAngel * M_PI / 180);
            lbly = y - r * sinf(criticalAngel * M_PI / 180);
            criticalAngel -= 5;
        }else{
            lblx = x + r * cosf(startAngel * M_PI / 180);
            lbly = y - r * sinf(startAngel * M_PI / 180);
          startAngel -= 5;
        }
        CGRect lblFrame = CGRectMake(lblx, lbly, lblWidth, lblHeight);
        [self.lblFrameArrayM addObject:NSStringFromCGRect(lblFrame)];
        UILabel *lable = [[UILabel alloc] initWithFrame:lblFrame];
        lable.text = [NSString stringWithFormat:@"%d", i];
        lable.tag = i + 200;
        [self.lblArrayM addObject:lable];
        [self addSubview:lable];
    }
    
}

//添加定时器
- (void)addTimeer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    [timer fire];
}

- (void)timeAction{
    //获取弧度为90的点
    CGFloat lblWidth = 30.f;
    CGFloat lblHeight = 25.f;
    CGFloat r = 380.f;  //圆的半径
    CGFloat y = 406; //圆心y坐标
    CGFloat x = SWIDTH / 2 - 7;  //圆心x坐标
    CGRect frame90 = CGRectMake(x + r * cosf(90 * M_PI / 180), y - r * sinf(90 * M_PI / 180), lblWidth, lblHeight);
    for (int i = 0; i < self.lblFrameArrayM.count; i++) {
        if ([NSStringFromCGRect(frame90) isEqualToString:self.lblFrameArrayM[i]]) {
            //弧度为90的坐标
            UILabel *lable = self.lblArrayM[i];
            lable.text = @"90";
        }
    }
}

//获取当前的时分秒
- (NSString *)getPointsForNowTime:(Time)timeType{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    formate.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSString *dateStr = [formate stringFromDate:nowDate];
    NSLog(@"==========  %@", dateStr);
    //NSString *yearTime = [dateStr componentsSeparatedByString:@" "].firstObject;
    NSString *hourTime = [dateStr componentsSeparatedByString:@" "].lastObject;
    if (timeType == TimeHour) {
        
        return [hourTime componentsSeparatedByString:@":"].firstObject;
    }
    if (timeType == TimeSeconds) {
        return [hourTime componentsSeparatedByString:@":"].lastObject;
    }
    
    if (timeType == TimePoints) {
        return [hourTime componentsSeparatedByString:@":"][1];
    }
    
}

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}




@end
