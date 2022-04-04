//
//  ZWWHomeItemModel.h
//  InterviewDemo
//
//  Created by jolly on 2022/4/4.
//  Copyright © 2022 mac. All rights reserved.
//

#import "ZWWBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZWWHomeItemModel : ZWWBaseModel

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *pushVCName;

+ (instancetype )modelWithTitle:(NSString *)title pushVCName:(NSString *)vcName;
@end

NS_ASSUME_NONNULL_END
