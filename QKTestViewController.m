//
//  QKTestViewController.m
//  AlarmClock
//
//  Created by wsy on 2016/12/16.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKTestViewController.h"
#import "QKSecondsDialView.h"

@interface QKTestViewController ()

@property(nonatomic, strong)UIView *pointDialView;

@property(nonatomic, strong)NSTimer *timer;

@end

@implementation QKTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *redView = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 10, 30)];
    redView.backgroundColor = [UIColor redColor];
    redView.text = @"d";
    redView.transform = CGAffineTransformMakeRotation(-0.2);
    [self.view addSubview:redView];
}








@end
