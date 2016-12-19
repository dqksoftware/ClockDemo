//
//  QKMainTimeModel.m
//  AlarmClock
//
//  Created by wsy on 2016/12/19.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKMainTimeModel.h"

@implementation QKMainTimeModel

- (instancetype)init{
    __block typeof(self)weaself = self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weaself = [super init];
    });
    return self;
}

//重写setter方法
-(void)setWeeks:(NSString *)weeks{
    NSString *weekString;
    switch (weeks.integerValue) {
        case 0:
            weekString = @"日";
            break;
        case (1):
            weekString = @"一";
            break;
        case (2):
            weekString = @"二";
            break;
        case (3):
            weekString = @"三";
            break;
        case (4):
            weekString = @"四";
            break;
        case (5):
            weekString = @"五";
            break;
        case (6):
            weekString = @"六";
            break;
        default:
            break;
    }
    _weeks = [NSString stringWithFormat:@"周%@",weekString];
}


@end
