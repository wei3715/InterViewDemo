//
//  TestClass+method1.m
//  InterviewDemo
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TestClass+method1.h"

@implementation TestClass (method1)
+ (void)load{
    ZWWLog();
}

+ (void)initialize
{
    if (self == [self class]) {
        ZWWLog();
    }
}

- (void)testCategoryFunc{
    ZWWLog(@"执行 TestClass (method1) 分类方法");
}
@end
