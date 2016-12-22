//
//  QKMainCell.h
//  AlarmClock
//
//  Created by 丁乾坤 on 2016/12/13.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKEditAlermView.h"

@protocol QKMainCellDelegate <NSObject>

- (void)qk_MainCellHandLongGesture:(UILongPressGestureRecognizer *)gesture;

@end

@interface QKMainCell : UITableViewCell

@property(nonatomic, strong)QKEditAlermView *editAlertView;

@property(nonatomic, assign)id delegate;

@end
