//
//  QKDateTool.m
//  AlarmClock
//
//  Created by wsy on 2016/12/21.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKDateTool.h"

@implementation QKDateTool
//获取当前的时分秒
+ (NSString *)getPointsForNowTime:(Time)timeType{
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




//计算圆周上的坐标点    此方法适合计算在x轴上半周  即0 - 90 - 180 的度数
+(CGPoint) calcCircleCoordinateWithCenter:(CGPoint)center andWithAngle:(CGFloat)angle andWithRadius:(CGFloat) radius{
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


+(NSString *)minutesConversion:(NSString *)minutesStr{
    NSString *tempMinutes;
    NSInteger minutesInt =  minutesStr.integerValue + 1;
    if (minutesInt >= 60) {
        minutesInt -= 60;
        if (minutesInt < 10) {
            tempMinutes = [NSString stringWithFormat:@"0%ld", minutesInt];
        }else{
            tempMinutes = [NSString stringWithFormat:@"%ld", minutesInt];
        }
        
    }else{
        tempMinutes = [NSString stringWithFormat:@"%ld", minutesInt];
    }
    return tempMinutes;
}


@end
