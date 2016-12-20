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

typedef NS_ENUM(NSInteger, Time) {
    TimeHour = 0,
    TimePoints = 1,
    TimeSeconds = 2,
    TimeYear = 3,
    TimeMonth = 4,
    TimeDay = 5,
    TimeWeek,
};

@interface QKDialView ()

/************ 数据属性 *****************/
@property(nonatomic, strong)UIImageView *backGroundImage;   //背景图片

@property(nonatomic, strong)NSMutableArray *lblMintuesFrameArrayM;   //标签刻度frame数组

@property(nonatomic, strong)NSMutableArray *lblHourFrameArrayM;   //标签刻度frame数组

@property(nonatomic, strong)NSMutableArray *lblMintuesArrayM;  //标签刻度数组

@property(nonatomic, strong)NSMutableArray *lblHourArrayM;  //标签刻度数组

@property(nonatomic, strong)NSMutableArray *tempLabelMintuesArrayM;  //标签数组  用来重置数组

@property(nonatomic, strong)NSMutableArray *tempLabelHourArrayM;     //标签数组  用来重置数组


/*****************************/

@property(nonatomic, strong)NSTimer *timer;  //定时器

@property(nonatomic, strong)UIView *minutesView;  //分钟转盘

@property(nonatomic, strong)UIView *hourView;  //时钟转盘

@property(nonatomic, strong)UIView *secondsView;  //秒转盘

@property(nonatomic, strong)QKMainTimeView *mainTimeView;   //时间视图

@property(nonatomic, strong)QKMainTimeModel *mainTimeModel;   //时间模型




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
    //标签数组
    NSMutableArray *lblArrayM = [NSMutableArray array];
    self.lblMintuesArrayM = lblArrayM;
    self.lblHourArrayM = [NSMutableArray array];
    
    self.backGroundImage = [[UIImageView alloc] init];
    [self addSubview:self.backGroundImage];
    [self.backGroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(self.mas_height);
    }];
   
    //创建键盘
    [self createDialViewForMintues];
    [self createDailViewForHour];

    self.secondsView = [[UIView alloc] init];
    self.secondsV
    [self addSubview:self.secondsView];
    [self.secondsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.minutesView.mas_top).offset(-20);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    //时间视图
    self.mainTimeView = [QKMainTimeView new];
    [self addSubview:self.mainTimeView];
    [self.mainTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@50);
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.width.equalTo(@(SWIDTH / 2 + 20));
    }];
}

#pragma mark ------  创建转盘
- (void)createDailViewForHour{
    CGFloat r = 370.f;  //圆的半径
    CGFloat x = SWIDTH / 2;  //圆心x坐标
    CGFloat y = r + 50; //圆心y坐标
    CGFloat startAngel = 115;  //开始弧度
    CGFloat endAngel = 60;      //结束弧度
    self.hourView = [self createDialView:startAngel endAgle:endAngel radius:r centerCircle:CGPointMake(x, y) timeType:TimeHour];
    //初始化临时标签数组

    self.tempLabelHourArrayM = self.lblHourArrayM;
    [self setValueForTimeDatil:r centerCircle:CGPointMake(x, y) timeType:TimeHour];
}

//创建分钟键盘
- (void)createDialViewForMintues{
    CGFloat r = 370.f;  //圆的半径
    CGFloat x = SWIDTH / 2;  //圆心x坐标
    CGFloat y = r; //圆心y坐标
    CGFloat startAngel = 130;    //开始弧度
    CGFloat endAngel = 50;      //结束弧度
    self.minutesView = [self createDialView:startAngel endAgle:endAngel radius:r centerCircle:CGPointMake(x, y) timeType:TimePoints];
    //初始化临时标签数组
    self.tempLabelMintuesArrayM = self.lblMintuesArrayM;
    [self setValueForTimeDatil:r centerCircle:CGPointMake(x, y) timeType:TimePoints];
}

- (UIView *)createDialView:(CGFloat)startAngle endAgle:(CGFloat)endAngle radius:(CGFloat)radius centerCircle:(CGPoint)centerCircle timeType:(Time)timeType{
    CGFloat lblWidth = 30.f;
    CGFloat lblHeight = 25.f;
    //转盘视图
    UIView *deialPointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * radius, 2 * radius)];
    deialPointView.qk_centerX = centerCircle.x;
    deialPointView.qk_centerY = centerCircle.y;
    [self addSubview:deialPointView];
    NSInteger lblconut = (startAngle - endAngle) / 5;
    for (int i = 0; i < lblconut; i++) {
        CGPoint point = [self calcCircleCoordinateWithCenter:centerCircle andWithAngle:startAngle andWithRadius:radius];
        startAngle -= 5;
        CGRect lblFrame = CGRectMake(point.x, point.y, lblWidth, lblHeight);
        UILabel *lable = [[UILabel alloc] init];
        lable.qk_height = lblFrame.size.height;
        lable.qk_width = lblFrame.size.width;
        lable.qk_centerY = lblFrame.origin.y;
        lable.qk_centerX = lblFrame.origin.x;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor whiteColor];
        lable.font = [UIFont boldSystemFontOfSize:20];
        lable.tag = i + 200;
        if (timeType == TimePoints) {
            [self.lblMintuesFrameArrayM addObject:NSStringFromCGRect(lblFrame)];
            [self.lblMintuesArrayM addObject:lable];
        }
        if (timeType == TimeHour) {
            [self.lblHourFrameArrayM addObject:NSStringFromCGRect(lblFrame)];
            [self.lblHourArrayM addObject:lable];
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
    NSString *hour = [self getPointsForNowTime:TimeHour];
    //获取当前分
    NSString *minute = [self getPointsForNowTime:TimePoints];
    //获取当前年
    NSString *year = [self getPointsForNowTime:TimeYear];
    //获取当年月
    NSString *month = [self getPointsForNowTime:TimeMonth];
    //获取当前日
    NSString *day = [self getPointsForNowTime:TimeDay];
    //获取周天
    NSString *week = [self getPointsForNowTime:TimeWeek];
    
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

//获取当前的时分秒
- (NSString *)getPointsForNowTime:(Time)timeType{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    formate.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSString *dateStr = [formate stringFromDate:nowDate];
    NSString *yearTime = [dateStr componentsSeparatedByString:@" "].firstObject;
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
    if (timeType == TimeYear) {
        return [yearTime componentsSeparatedByString:@"-"].firstObject;
    }
    if (timeType == TimeMonth) {
        return [yearTime componentsSeparatedByString:@"-"][1];
    }
    if (timeType == TimeDay) {
        return [yearTime componentsSeparatedByString:@"-"].lastObject;
    }
    if (timeType == TimeWeek) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIndian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSCalendarUnitWeekday;
        comps = [calendar components:unitFlags fromDate:nowDate];
        return [NSString stringWithFormat:@"%ld", [comps weekday]];
    }
    
    return nil;
}

#pragma mark  ----  计算坐标点
//计算圆周上的坐标点    此方法适合计算在x轴上半周  即0 - 90 - 180 的度数
-(CGPoint) calcCircleCoordinateWithCenter:(CGPoint)center andWithAngle:(CGFloat)angle andWithRadius:(CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    if (angle >= 90 && angle < 180) {     //第象限
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
- (void)setValueForTimeDatil:(CGFloat)radius centerCircle:(CGPoint)centerCircle timeType:(Time)TimeType{
    CGFloat lblWidth = 30.f;
    CGFloat lblHeight = 25.f;
    NSInteger angle90Index;
    NSMutableArray *tempArrayM;
    //当前 的分钟数值
    NSString *currentTimeValue;
    CGPoint point = [self calcCircleCoordinateWithCenter:centerCircle andWithAngle:90 andWithRadius:radius];
    CGRect lblFrame = CGRectMake(point.x, point.y, lblWidth, lblHeight);
    if (TimeType == TimePoints) {
        tempArrayM = self.lblMintuesArrayM;
        currentTimeValue = [self getPointsForNowTime:TimePoints];
        angle90Index = [self.lblMintuesFrameArrayM indexOfObject:NSStringFromCGRect(lblFrame)];
    }else{
        tempArrayM = self.lblHourArrayM;
        currentTimeValue = [self getPointsForNowTime:TimeHour];
        angle90Index = [self.lblHourFrameArrayM indexOfObject:NSStringFromCGRect(lblFrame)];
    }
    NSInteger currentTimeValueInt = currentTimeValue.integerValue;
    CGFloat otherLabelValue;
    for (int i = 0; i < tempArrayM.count; i++) {
        UILabel *currentLabel = tempArrayM[i];
        NSInteger tag = currentLabel.tag - 200;
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
    }

}

#pragma mark  ------- 位移互换
- (void)pointChange{
    for (int i = 0; i < self.lblMintuesFrameArrayM.count; i++) {
    UILabel *label = self.lblMintuesArrayM[i];
        if (i==0) {
            continue;
        }
       [UIView animateWithDuration:1.f animations:^{
            //标签的frame 都往前位移一位
            label.frame = CGRectFromString(self.lblMintuesFrameArrayM[i-1]);
            label.qk_centerX = CGRectFromString(self.lblMintuesFrameArrayM[i-1]).origin.x;
            label.qk_centerY = CGRectFromString(self.lblMintuesFrameArrayM[i-1]).origin.y;
            [self.tempLabelMintuesArrayM replaceObjectAtIndex:i-1 withObject:label];
        }];
    }
    //特殊判断第一个标签位移到后面
    UILabel *firstLabel = self.lblMintuesArrayM.firstObject;
    firstLabel.frame = CGRectFromString(self.lblMintuesFrameArrayM.lastObject);
    firstLabel.qk_centerX = CGRectFromString(self.lblMintuesFrameArrayM.lastObject).origin.x;
    firstLabel.qk_centerY = CGRectFromString(self.lblMintuesFrameArrayM.lastObject).origin.y;
    UILabel *lastLabel = self.lblMintuesArrayM.lastObject;
    firstLabel.text = [self minutesConversion:lastLabel.text];
    [self.tempLabelMintuesArrayM replaceObjectAtIndex:self.lblMintuesArrayM.count - 1 withObject:firstLabel];
    //重新赋值标签数组
    self.lblMintuesArrayM = self.tempLabelMintuesArrayM;
}
//分钟转换
- (NSString *)minutesConversion:(NSString *)minutesStr{
    NSString *tempMinutes;
    NSInteger minutesInt =  minutesStr.integerValue + 1;
    if (minutesInt >= 60) {
        minutesInt -= 60;
        if (minutesInt < 10) {
            tempMinutes = [NSString stringWithFormat:@"%.2ld", minutesInt];
        }else{
            tempMinutes = [NSString stringWithFormat:@"%ld", minutesInt];
        }
        
    }else{
        tempMinutes = [NSString stringWithFormat:@"%ld", minutesInt];
    }
    return tempMinutes;
}

#pragma mark  ----- 观察者方法

- (void)addObserver{
    [self addObserver:self forKeyPath:@"mainTimeModel.minutes" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    [self pointChange];
}


- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
    [self removeObserver:self forKeyPath:@"mainTimeModel.minutes"];
}




@end
