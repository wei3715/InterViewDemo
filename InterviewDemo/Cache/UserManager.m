//
//  UserManager.m
//  InterviewDemo
//
//  Created by Jolly on 2018/10/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UserManager.h"
#import <YYKit.h>
#import <MJExtension.h>
@interface UserManager ()

@property (nonatomic, strong) YYCache       *userCache;
@property (nonatomic, strong) NSDictionary  *userInfo;

@end

@implementation UserManager

SINGLETON_FOR_CLASS(UserManager)
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userCache = [[YYCache alloc]initWithName:@"zww.userInfo"];
    }
    return self;
}

- (void)updateUserInfo:(id)userInfo{
    [self.userCache setObject:userInfo forKey:@"info"];
}

- (NSDictionary *)userInfo{
    if (!_userInfo) {
        id value = [self.userCache objectForKey:@"info"];
       _userInfo = (NSDictionary *)value;
    }
    return _userInfo;
}

- (UserModel *)userModel{
    if (!_userModel) {
       _userModel = [UserModel mj_objectWithKeyValues:self.userInfo];
    }
    return _userModel;
}


@end
