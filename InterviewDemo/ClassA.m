//
//  ClassA.m
//  InterviewDemo
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ClassA.h"
@interface ClassA()<MyPTLDelegate>

@end

@implementation ClassA
- (void)methodA{
    ZWWLog(@"通过组合执行A方法");
}

- (void)printClass{
    ZWWLog(@"执行A协议方法");
}
@end


