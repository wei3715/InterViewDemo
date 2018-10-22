//
//  ZWWDataEntity.h
//  InterviewDemo
//
//  Created by jolly on 2018/10/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZWWDataEntity : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (strong, nonatomic) UIImage *avatar;

// Cache
@property (assign, nonatomic) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
