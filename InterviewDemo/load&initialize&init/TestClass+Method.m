//
//  TestClass+Method.m
//  InterviewDemo
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TestClass+Method.h"
#import <objc/runtime.h>

const char *Addr = "NSString *";
@implementation TestClass (Method)

- (void)setAddr:(NSString *)addr
{
    objc_setAssociatedObject(self, Addr, addr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)addr
{
    NSString *addr = objc_getAssociatedObject(self, Addr);
    return addr;
}

//不会覆盖主类的load
+ (void)load{
    ZWWLog();
}

//会覆盖主类的initialize
+ (void)initialize
{
    if (self == [self class]) {
        ZWWLog();
    }
}

//会覆盖主类的init方法
- (instancetype)init
{
    ZWWLog(@"TestClass (Method) init方法执行");
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)testCategoryFunc{
    ZWWLog(@"执行 TestClass (method) 分类方法");
}

@end
