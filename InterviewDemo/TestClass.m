//
//  TestClass.m
//  InterviewDemo
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TestClass.h"


@implementation TestClass

- (void)printClass:(id <MyPTLDelegate>)obj{
    [obj printClass];
}

@end
