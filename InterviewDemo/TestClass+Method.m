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

@end
