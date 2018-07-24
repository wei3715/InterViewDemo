//
//  TestClass.m
//  InterviewDemo
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TestClass.h"
#import "ClassA.h"
#import "ClassB.h"

@interface TestClass()<ClassAProtocol,ClassBProtocol>{
    ClassA *a;
    ClassB *b;
}

@end
@implementation TestClass
- (instancetype)init{
    self = [super init];
    if (self) {
        a = [[ClassA alloc]init];
        b = [[ClassB alloc]init];
    }
    return self;
    
}

//通过组合实现多继承
- (void)methodA{
    [a methodA];
    //下面执行本类操作
    ZWWLog(@"实现本类自定义操作");
}

-(void)methodB{
    [b methodB];
    //下面执行本类操作
    ZWWLog(@"实现本类自定义操作");
}

//通过代理实现多继承基类的接口
- (void)protocolMethodA{
    //下面执行本类操作
    ZWWLog(@"实现本类自定义操作");
    
}

- (void)protocolMethodB{
    //下面执行本类操作
    ZWWLog(@"实现本类自定义操作");
    
}


- (void)printClass:(id <MyPTLDelegate>)obj{
    [obj printClass];
    //下面执行本类操作
    ZWWLog(@"实现本类自定义操作");
}

@end
