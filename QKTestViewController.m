//
//  QKTestViewController.m
//  AlarmClock
//
//  Created by wsy on 2016/12/16.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKTestViewController.h"

@interface QKTestViewController ()

@property(nonatomic, strong)UIView *pointDialView;

@property(nonatomic, strong)NSTimer *timer;

@end

@implementation QKTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 30, 30)];
    label.backgroundColor = [UIColor redColor];
    label.text = @"dqk";
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *deialPointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    deialPointView.qk_centerX = SWIDTH / 2;
    deialPointView.qk_centerY = SHEIGHT;
    deialPointView.layer.cornerRadius = 100;
    deialPointView.layer.masksToBounds = YES;
    [deialPointView addSubview:label];
    deialPointView.backgroundColor = [UIColor blackColor];
    self.pointDialView = deialPointView;
    [self.view addSubview:deialPointView];
    [self addTimeer];
    
}

//添加定时器
- (void)addTimeer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    [timer fire];
}

- (void)timeAction{
//    //获取弧度为90的点
//    CGFloat lblWidth = 30.f;
//    CGFloat lblHeight = 25.f;
//    CGFloat r = 380.f;  //圆的半径
//    CGFloat y = 406; //圆心y坐标
//    CGFloat x = SWIDTH / 2 - 10;  //圆心x坐标
//    CGRect frame90 = CGRectMake(x + r * cosf(90 * M_PI / 180), y - r * sinf(90 * M_PI / 180), lblWidth, lblHeight);

    
    /*
     *
     *    弧度和角度的转换公式
     *    弧度=角度*pi(pi是圆周率)/180
     *    角度=弧度*180/pi(pi是圆周率)
     */
    
    static CGFloat angle = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.pointDialView.transform = CGAffineTransformMakeRotation(-angle);
    }];
    angle+= M_PI * 5 / 180;
    
    
    NSLog(@"   旋转角度   ");
}








@end
