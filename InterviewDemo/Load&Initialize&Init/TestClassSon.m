//
//  TestClassSon.m
//  InterviewDemo
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TestClassSon.h"

@implementation TestClassSon

+ (void)load{
    ZWWLog();
}

+ (void)initialize
{
    ZWWLog();
}

- (instancetype)init
{
   
    ZWWLog();
    return [super init];
}

- (void)testCategoryFunc{
    ZWWLog(@"执行 TestClassSon 子类方法");
}
@end
