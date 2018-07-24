//
//  ClassB.m
//  InterviewDemo
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ClassB.h"
@interface ClassB()<MyPTLDelegate>

@end

@implementation ClassB
- (void)methodB{
    ZWWLog(@"通过组合执行B方法");
}

-(void)printClass{
    ZWWLog(@"执行B协议方法");
}



@end
