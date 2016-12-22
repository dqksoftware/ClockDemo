//
//  QKDialView.m
//  AlarmClock
//
//  Created by 丁乾坤 on 2016/12/14.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKDialView.h"
#import "QKMainTimeModel.h"
#import "QKMainTimeView.h"
#import "QKDateTool.h"
#import "QKSecondsDialView.h"

@interface QKDialView ()

/************ 数据属性 *****************/
//@property(nonatomic, strong)UIImageView *backGroundImage;   //背景图片

@property(nonatomic, strong)NSMutableArray *lblMintuesFrameArrayM;   //标签刻度frame数组

@property(nonatomic, strong)NSMutableArray *lblHourFrameArrayM;   //标签刻度frame数组

@property(nonatomic, strong)NSMutableArray *lblMintuesArrayM;  //标签刻度数组

@property(nonatomic, strong)NSMutableArray *lblHourArrayM;  //标签刻度数组

@property(nonatomic, strong)NSMutableArray *tempLabelMintuesArrayM;  //标签数组  用来重置数组

@property(nonatomic, strong)NSMutableArray *tempLabelHourArrayM;     //标签数组  用来重置数组

@property(nonatomic, strong)NSMutableArray *transMintuesFormArrayM;  //形变属性数组


/*****************************/

@property(nonatomic, strong)NSTimer *timer;  //定时器

@property(nonatomic, strong)UIView *minutesView;  //分钟转盘

@property(nonatomic, strong)UIView *hourView;  //时钟转盘

@property(nonatomic, strong)UIView *secondsView;  //秒转盘

@property(nonatomic, strong)QKMainTimeView *mainTimeView;   //时间视图

@property(nonatomic, strong)QKSecondsDialView *secondDialView; //秒盘

@property(nonatomic, strong)QKMainTimeModel *mainTimeModel;   //时间模型

@property(nonatomic, strong)CAGradientLayer *gradientLayer;  //梯度层


@end

@implementation QKDialView



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setUpView];
        self.mainTimeModel = [[QKMainTimeModel alloc] init];
        [self addTimeer];       //添加定时器
        //添加观察者
        [self addObserver];
        
    }
    return self;
}

//加载子视图
- (void)setUpView{

    //标签frame数组
    self.lblMintuesFrameArrayM = [NSMutableArray array];
    self.lblHourFrameArrayM = [NSMutableArray array];
    self.transMintuesFormArrayM = [NSMutableArray array];
    //标签数组
    NSMutableArray *lblArrayM = [NSMutableArray array];
    self.lblMintuesArrayM = lblArrayM;
    self.lblHourArrayM = [NSMutableArray array];
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
    [self.layer addSublayer:self.gradientLayer];
    //设置颜色渐变方向
    self.gradientLayer.startPoint = CGPointMake(0.5, 0);
    self.gradientLayer.endPoint = CGPointMake(0.5, 1);
    //设定颜色分割点
    self.gradientLayer.locations = @[@(0.5f) ,@(0.2f)];
    self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor, (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor, (__bridge id)[UIColor blackColor].CGColor];
    
    //创建键盘
    [self createDialViewForMintues];
    [self createDailViewForHour];
    //
    CGFloat r = seconds_circle_radius;  //圆的半径
    CGFloat x = SWIDTH / 2;  //圆心x坐标
    self.secondsView = [[UIView alloc] init];
    self.secondsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self addSubview:self.secondsView];
    self.secondsView.layer.masksToBounds = YES;
    self.secondsView.layer.cornerRadius = r;
    self.secondsView.qk_height = 2 * r;
    self.secondsView.qk_width = 2 * r;
    self.secondsView.qk_centerX = x;
    self.secondsView.qk_centerY = circle_y;
    self.secondsView.layer.borderWidth = 3.f;
    self.secondsView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.8].CGColor;
    
    self.secondDialView = [[QKSecondsDialView alloc] initWithFrame:CGRectMake(0, 0, self.qk_width, self.qk_height)];
    [self addSubview:self.secondDialView];
    //时间视图
    self.mainTimeView = [QKMainTimeView new];
    [self addSubview:self.mainTimeView];
    [self.mainTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@70);
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.width.equalTo(@(SWIDTH / 2 + 40));
    }];
    
 
}

#pragma mark ------  创建转盘
//创建时钟键盘
- (void)createDailViewForHour{
    CGFloat x = SWIDTH / 2;  //圆心x坐标
    self.hourView = [self createDialView:hour_circle_startAngle endAgle:hour_circle_endAngle radius:hour_circle_radius centerCircle:CGPointMake(x, circle_y) timeType:TimeHour];
    //初始化临时标签数组
    self.tempLabelHourArrayM = self.lblHourArrayM;
    [self setValueForTimeDatil:hour_circle_radius centerCircle:CGPointMake(x, circle_y) timeType:TimeHour];
}

//创建分钟键盘
- (void)createDialViewForMintues{
    CGFloat x = SWIDTH / 2;  //圆心x坐标
    self.minutesView = [self createDialView:mintues_circle_startAngle endAgle:mintues_circle_endAngle radius:mintues_circle_radius centerCircle:CGPointMake(x, circle_y) timeType:TimePoints];
    //初始化临时标签数组
    self.tempLabelMintuesArrayM = self.lblMintuesArrayM;
    [self setValueForTimeDatil:mintues_circle_radius centerCircle:CGPointMake(x, circle_y) timeType:TimePoints];
}

- (UIView *)createDialView:(CGFloat)startAngle endAgle:(CGFloat)endAngle radius:(CGFloat)radius centerCircle:(CGPoint)centerCircle timeType:(Time)timeType{
    //转盘视图
    UIView *deialPointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * radius, 2 * radius)];
    deialPointView.qk_centerX = centerCircle.x;
    deialPointView.qk_centerY = centerCircle.y;
    [self addSubview:deialPointView];
    NSInteger lblconut = (startAngle - endAngle) / 5;
    for (int i = 0; i < lblconut; i++) {
        CGPoint point = [QKDateTool calcCircleCoordinateWithCenter:centerCircle andWithAngle:startAngle andWithRadius:radius];
        CGRect lblFrame = CGRectMake(point.x, point.y, label_width, label_height);
        UILabel *lable = [[UILabel alloc] init];
        lable.qk_height = lblFrame.size.height;
        lable.qk_width = lblFrame.size.width;
        lable.qk_centerY = lblFrame.origin.y;
        lable.qk_centerX = lblFrame.origin.x;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor whiteColor];
        lable.font = [UIFont boldSystemFontOfSize:15];
        lable.tag = i + 200;
        //切记 此View是以90度为0度的
        CGFloat offsetAngle = 90 - startAngle;
        if (startAngle >= 90) {
            lable.transform = CGAffineTransformMakeRotation(offsetAngle / 90);

        }else{
            lable.transform = CGAffineTransformMakeRotation(offsetAngle / 90);
        }
        if (timeType == TimePoints) {
            [self.lblMintuesFrameArrayM addObject:NSStringFromCGRect(lblFrame)];
            [self.lblMintuesArrayM addObject:lable];
            NSValue *value = [NSValue valueWithCGAffineTransform:lable.transform];
            [self.transMintuesFormArrayM addObject:value];
            startAngle -= 5;
        }
        if (timeType == TimeHour) {
            [self.lblHourFrameArrayM addObject:NSStringFromCGRect(lblFrame)];
            [self.lblHourArrayM addObject:lable];
            startAngle -= 5;
        }
        [deialPointView addSubview:lable];
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
    //显示当前的日期时间
    QKMainTimeModel *mainTimeModel = [self getTimeModel];
    self.mainTimeView.mainTimeModel = mainTimeModel;
}

- (QKMainTimeModel *)getTimeModel{
    //获取当前时
    NSString *hour = [QKDateTool getPointsForNowTime:TimeHour];
    //获取当前分
    NSString *minute = [QKDateTool getPointsForNowTime:TimePoints];
    //获取当前年
    NSString *year = [QKDateTool getPointsForNowTime:TimeYear];
    //获取当年月
    NSString *month = [QKDateTool getPointsForNowTime:TimeMonth];
    //获取当前日
    NSString *day = [QKDateTool getPointsForNowTime:TimeDay];
    //获取周天
    NSString *week = [QKDateTool getPointsForNowTime:TimeWeek];
    
    if (![self.mainTimeModel.minutes isEqualToString:minute]) {
        self.mainTimeModel.minutes = minute;
    }
    if (![self.mainTimeModel.hour isEqualToString:hour]) {
        self.mainTimeModel.hour = hour;
    }
    self.mainTimeModel.year = year;
    self.mainTimeModel.month = month;
    self.mainTimeModel.day = day;
    self.mainTimeModel.weeks = week;
    return self.mainTimeModel;
}


#pragma mark  添加刻度值
- (void)setValueForTimeDatil:(CGFloat)radius centerCircle:(CGPoint)centerCircle timeType:(Time)TimeType{
    NSInteger angle90Index;
    NSMutableArray *tempArrayM;
    //当前 的分钟数值
    NSString *currentTimeValue;
    CGPoint point = [QKDateTool calcCircleCoordinateWithCenter:centerCircle andWithAngle:90 andWithRadius:radius];
    CGRect lblFrame = CGRectMake(point.x, point.y, label_width, label_height);
    if (TimeType == TimePoints) {
        tempArrayM = self.lblMintuesArrayM;
        currentTimeValue = [QKDateTool getPointsForNowTime:TimePoints];
        angle90Index = [self.lblMintuesFrameArrayM indexOfObject:NSStringFromCGRect(lblFrame)];
    }else{
        tempArrayM = self.lblHourArrayM;
        currentTimeValue = [QKDateTool getPointsForNowTime:TimeHour];
        angle90Index = [self.lblHourFrameArrayM indexOfObject:NSStringFromCGRect(lblFrame)];
    }
    NSInteger currentTimeValueInt = currentTimeValue.integerValue;
    CGFloat otherLabelValue;
    for (int i = 0; i < tempArrayM.count; i++) {
        UILabel *currentLabel = tempArrayM[i];
        NSInteger tag = currentLabel.tag - 200;
        if (TimeType == TimePoints) {
            if (tag != angle90Index) {
                if (currentTimeValueInt - (angle90Index - tag) >= 60) {
                    otherLabelValue = currentTimeValueInt - (angle90Index - tag) - 60;
                }else if((currentTimeValueInt - (angle90Index - tag)) < 0){
                    otherLabelValue = currentTimeValueInt - (angle90Index - tag) + 60;
                }else{
                    otherLabelValue = currentTimeValueInt - (angle90Index - tag);
                }
                if (otherLabelValue < 10) {
                    currentLabel.text = [NSString stringWithFormat:@"0%@", @(otherLabelValue)];
                }else{
                    currentLabel.text = [NSString stringWithFormat:@"%@", @(otherLabelValue)];
                }
            }else{
                currentLabel.text = currentTimeValue;;
            }
        }else{
            if (tag != angle90Index) {
                if (currentTimeValueInt - (angle90Index - tag) >= 24) {
                    otherLabelValue = currentTimeValueInt - (angle90Index - tag) - 24;
                }else if((currentTimeValueInt - (angle90Index - tag)) < 0){
                    otherLabelValue = currentTimeValueInt - (angle90Index - tag) + 24;
                }else{
                    otherLabelValue = currentTimeValueInt - (angle90Index - tag);
                }
                if (otherLabelValue < 10) {
                    currentLabel.text = [NSString stringWithFormat:@"0%@", @(otherLabelValue)];
                }else{
                    currentLabel.text = [NSString stringWithFormat:@"%@", @(otherLabelValue)];
                }
            }else{
                currentLabel.text = currentTimeValue;;
            }

        }
       
    }
}

#pragma mark  ------- 位移互换
- (void)pointChange:(Time)timeType{
    NSMutableArray *lblFrameArrayM;
    NSMutableArray *lblArrarM;
    NSMutableArray *tempLblArrayM;
    if (timeType == TimePoints) {
        lblFrameArrayM = self.lblMintuesFrameArrayM;
        lblArrarM = self.lblMintuesArrayM;
        tempLblArrayM = self.tempLabelMintuesArrayM;
    }
    if (timeType == TimeHour) {
        lblFrameArrayM = self.lblHourFrameArrayM;
        lblArrarM = self.lblHourArrayM;
        tempLblArrayM = self.tempLabelHourArrayM;
    }
    for (int i = 0; i < lblFrameArrayM.count; i++) {
        UILabel *label = lblArrarM[i];
        
        if (i==0) {
            continue;
        }else{
            [UIView animateWithDuration:1.f animations:^{
                //标签的frame 都往前位移一位
                label.frame = CGRectFromString(lblFrameArrayM[i-1]);
                label.qk_centerX = CGRectFromString(lblFrameArrayM[i-1]).origin.x;
                label.qk_centerY = CGRectFromString(lblFrameArrayM[i-1]).origin.y;
                NSValue *valueTransForm = self.transMintuesFormArrayM[i-1];
                CGAffineTransform transForm = [valueTransForm CGAffineTransformValue];
                label.transform = transForm;
                [tempLblArrayM replaceObjectAtIndex:i-1 withObject:label];
            }];
        }
   }
    //特殊判断第一个标签位移到后面
    UILabel *firstLabel = lblArrarM.firstObject;
    firstLabel.frame = CGRectFromString(lblFrameArrayM.lastObject);
    firstLabel.qk_centerX = CGRectFromString(lblFrameArrayM.lastObject).origin.x;
    firstLabel.qk_centerY = CGRectFromString(lblFrameArrayM.lastObject).origin.y;
    UILabel *lastLabel = lblArrarM.lastObject;
    firstLabel.text = [QKDateTool minutesConversion:lastLabel.text];
    NSValue *valueTransForm = self.transMintuesFormArrayM.lastObject;
    CGAffineTransform transForm = [valueTransForm CGAffineTransformValue];
    firstLabel.transform = transForm;
    [tempLblArrayM replaceObjectAtIndex:lblArrarM.count - 1 withObject:firstLabel];

    //重新赋值标签数组
    if (timeType == TimePoints) {
        self.lblMintuesArrayM = tempLblArrayM;
    }
    if (timeType == TimeHour) {
        self.lblHourArrayM = tempLblArrayM;
    }
    
}
#pragma mark  ----- 观察者方法
- (void)addObserver{
    [self addObserver:self forKeyPath:@"mainTimeModel.minutes" options:NSKeyValueObservingOptionNew context:nil];
    
    [self addObserver:self forKeyPath:@"mainTimeModel.hour" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"mainTimeModel.minutes"]) {
        [self pointChange:TimePoints];
    }
    if ([keyPath isEqualToString:@"mainTimeModel.hour"]) {
        
        [self pointChange:TimePoints];
    }
}

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
    [self removeObserver:self forKeyPath:@"mainTimeModel.minutes"];
    [self removeObserver:self forKeyPath:@"mainTimeModel.hour"];
}




@end
