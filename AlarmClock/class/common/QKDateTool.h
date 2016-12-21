//
//  QKDateTool.h
//  AlarmClock
//
//  Created by wsy on 2016/12/21.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, Time) {
    TimeHour = 0,
    TimePoints = 1,
    TimeSeconds = 2,
    TimeYear = 3,
    TimeMonth = 4,
    TimeDay = 5,
    TimeWeek,
};

@interface QKDateTool : NSObject


+ (NSString *)getPointsForNowTime:(Time)timeType;

+(CGPoint) calcCircleCoordinateWithCenter:(CGPoint)center andWithAngle:(CGFloat)angle andWithRadius:(CGFloat) radius;

+(NSString *)minutesConversion:(NSString *)minutesStr;

@end
