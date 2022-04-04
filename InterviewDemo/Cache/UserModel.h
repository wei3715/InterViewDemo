//
//  UserModel.h
//  InterviewDemo
//
//  Created by Jolly on 2018/10/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (nonatomic, copy, readonly) NSString      *name;
@property (nonatomic, copy, readonly) NSString      *gender;
@property (nonatomic, assign, readonly) NSInteger   age;

@end

NS_ASSUME_NONNULL_END
