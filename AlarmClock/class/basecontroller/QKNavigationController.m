//
//  QKNavigationController.m
//  AlarmClock
//
//  Created by 丁乾坤 on 2016/12/13.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKNavigationController.h"

@interface QKNavigationController ()

@end

@implementation QKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}


@end
