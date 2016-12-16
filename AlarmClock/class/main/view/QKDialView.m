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

@property(nonatomic, strong)UIView *pointDialView;

@end

@implementation QKDialView



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setUpView];
        self.backgroundColor = [UIColor redColor];
        
        [self pointChange];
//        [self addTimeer];
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
    CGFloat r = 380.f;  //圆的半径
    CGFloat x = SWIDTH / 2;  //圆心x坐标
    CGFloat y = r + 15; //圆心y坐标
    CGFloat startAngel = 130;  //开始弧度
    CGFloat endAngel = 50;      //结束弧度
    NSInteger lblconut = (startAngel - endAngel) / 5;
    UIView *deialPointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * r, 2 * r)];
    deialPointView.qk_centerX = x;
    deialPointView.qk_centerY = y;
    self.pointDialView = deialPointView;
    [self addSubview:deialPointView];
    for (int i = 0; i < lblconut; i++) {
        CGPoint point = [self calcCircleCoordinateWithCenter:CGPointMake(x, y) andWithAngle:startAngel andWithRadius:r];
            startAngel -= 5;
        CGRect lblFrame = CGRectMake(point.x, point.y, lblWidth, lblHeight);
        [self.lblFrameArrayM addObject:NSStringFromCGRect(lblFrame)];
        UILabel *lable = [[UILabel alloc] init];
        lable.qk_height = lblFrame.size.height;
        lable.qk_width = lblFrame.size.width;
        lable.qk_centerY = lblFrame.origin.y;
        lable.qk_centerX = lblFrame.origin.x;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor whiteColor];
        lable.tag = i + 200;
        [self.lblArrayM addObject:lable];
        [self.pointDialView addSubview:lable];
    }
}

//添加定时器
- (void)addTimeer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    [timer fire];
}

- (void)timeAction{
    [self addtimeDatilForLabel];
}

//获取当前的时分秒
- (NSString *)getPointsForNowTime:(Time)timeType{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    formate.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSString *dateStr = [formate stringFromDate:nowDate];
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
    return nil;
}

//计算圆周上的坐标点    此方法适合计算在x轴上半周  即0 - 90 - 180 的度数
-(CGPoint) calcCircleCoordinateWithCenter:(CGPoint)center andWithAngle:(CGFloat)angle andWithRadius:(CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    if (angle >= 90 && angle < 180) {     //第一象限
        x2 = radius - fabs(x2);
        y2 = radius - fabs(y2);
    }else if(angle < 90 && angle >= 0){    //第二象限
        x2 = radius + fabs(x2);
        y2 = radius - fabs(y2);
    }else if(angle > 180 && angle <= 270){   //第三象限
        x2 = radius - fabs(x2);
        y2 = radius + fabs(y2);
    }else{                                    //第四象限
        x2 = radius + fabs(x2);
        y2 = radius + fabs(y2);
    }
    return CGPointMake(fabs(x2), fabs(y2));
}


#pragma mark  添加刻度值
- (void)addtimeDatilForLabel{
    CGFloat lblWidth = 30.f;
    CGFloat lblHeight = 25.f;
    CGFloat r = 380.f;  //圆的半径
    CGFloat x = SWIDTH / 2 ;  //圆心x坐标
    CGFloat y = r + 15; //圆心y坐标
    //当前 的分钟数值
    NSString *currentPoint =[self getPointsForNowTime:TimePoints];
    NSInteger currentPointInt = currentPoint.integerValue;
    CGPoint point = [self calcCircleCoordinateWithCenter:CGPointMake(x, y) andWithAngle:90 andWithRadius:r];
    CGRect lblFrame = CGRectMake(point.x, point.y, lblWidth, lblHeight);
    NSInteger angle90Index = [self.lblFrameArrayM indexOfObject:NSStringFromCGRect(lblFrame)];
    CGFloat otherLabelTime;
    for (int i = 0; i < self.lblArrayM.count; i++) {
        UILabel *currentLabel = self.lblArrayM[i];
        NSInteger tag = currentLabel.tag - 200;
        if (tag != angle90Index) {
            if (currentPointInt - (angle90Index - tag) >= 60) {
                otherLabelTime = currentPointInt - (angle90Index - tag) - 60;
            }else if((currentPointInt - (angle90Index - tag)) < 0){
                otherLabelTime = currentPointInt - (angle90Index - tag) + 60;
            }else{
                otherLabelTime = currentPointInt - (angle90Index - tag);
            }
            if (otherLabelTime < 10) {
                currentLabel.text = [NSString stringWithFormat:@"%@", @(otherLabelTime)];
            }else{
                currentLabel.text = [NSString stringWithFormat:@"%@", @(otherLabelTime)];
            }
            
        }else{
            currentLabel.textColor = [UIColor orangeColor];
            currentLabel.text = @"100";
        }
    }
}


#pragma mark  ------- 位移互换
- (void)pointChange{
    
    for (UILabel *label in self.lblArrayM) {
        
        NSLog(@"  变换前   ---------  %@ ", NSStringFromCGRect(label.frame));
    }
    
    for (NSString *frame in self.lblFrameArrayM) {
        NSLog(@" frame =================  %@", frame);
    }
    
    for (int i = 0; i < self.lblFrameArrayM.count; i++) {
        UILabel *label = self.lblArrayM[i];
        if (i != 0) {
            //标签的frame 都往前位移一位
            label.frame = CGRectFromString(self.lblFrameArrayM[i-1]);
            label.qk_centerX = CGRectFromString(self.lblFrameArrayM[i-1]).origin.x;
            label.qk_centerY = CGRectFromString(self.lblFrameArrayM[i-1]).origin.y;
        }else{  //第一个标签 是最后一个frame
            label.frame = CGRectFromString(self.lblFrameArrayM.lastObject);
            label.qk_centerX = CGRectFromString(self.lblFrameArrayM.lastObject).origin.x;
            label.qk_centerY = CGRectFromString(self.lblFrameArrayM.lastObject).origin.y;
        }
    }
    for (UILabel *label in self.lblArrayM) {
        
        NSLog(@"  变换后   ---------  %@", NSStringFromCGRect(label.frame));
    }
    
}




- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}




@end
