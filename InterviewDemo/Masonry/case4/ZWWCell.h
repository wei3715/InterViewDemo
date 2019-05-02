//
//  ZWWCell.h
//  InterviewDemo
//
//  Created by jolly on 2018/10/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWWDataEntity;
NS_ASSUME_NONNULL_BEGIN

@interface ZWWCell : UITableViewCell

- (void)setupData:(ZWWDataEntity *)dataEntity;

@end

NS_ASSUME_NONNULL_END
