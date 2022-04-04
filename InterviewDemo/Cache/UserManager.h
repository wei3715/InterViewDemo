//
//  UserManager.h
//  InterviewDemo
//
//  Created by Jolly on 2018/10/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface UserManager : NSObject

@property (nonatomic, strong) UserModel     *userModel;

SINGLETON_FOR_HEADER(UserManager);
- (void)updateUserInfo:(id)userInfo;

@end

NS_ASSUME_NONNULL_END
