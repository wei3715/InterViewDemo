//
//  ZWWDataCase8Entity.h
//  InterviewDemo
//
//  Created by jolly on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZWWDataCase8Entity : NSObject

@property (nonatomic, copy) NSString  *content;
@property (assign, nonatomic) BOOL expanded; // 是否已经展开
// Cache
@property (assign, nonatomic) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
