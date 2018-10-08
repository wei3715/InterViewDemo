//
//  TestBlock.m
//  InterviewDemo
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TestBlock.h"
typedef void(^Ablock)(id testData);
typedef void(^Bblock)(id data, Ablock testBlock);

@interface TestBlock()

@property (nonatomic, copy) Bblock byBlock;

@end

@implementation TestBlock

//void (^GlobalBlock)(void(^)(void)) = ^{
//     NSLog(@"外层全局Block：_NSConcreteGlobalBlock");
//    void(^insideGlobalBlock)(void)=^{
//         NSLog(@"内层全局Block：_NSConcreteGlobalBlock");
//    };
//
//};

- (void)testBlock{
    
//    GlobalBlock();
    
    int val = 10;
    int *p = &val;
    NSLog(@"原参数地址=%p",p);
    void(^StackBlock)(int *p) = ^(int *p){
        //通过指针改变局部变量的值（指针传递，访问的是同一块内存，所以可以改变val的值）
        //如果直接通过变量名访问，是值传递，只是block外val的一个副本，所以改变不会影响原来val的值
        NSLog(@"指针值=%p,参数地址==%p",p,&val);
        (*p)=(*p)+1;
        NSLog(@"block内改变后值*p==%d，val==%d",*p,val);
    };
    
    val++;
    StackBlock(p);
    NSLog(@"block外改变后值==%d",val);
    
    //嵌套block
    
    [self testActionWith:^(id data, Ablock testBlock) {
        NSLog(@"第一层block参数==%@",data);
        if (testBlock) {
            testBlock(@"第二层block");
        }
    }];
}

- (void)testActionWith:(Bblock)block{
    NSLog(@"测试block嵌套调用");
    _byBlock = block;
    
    NSString *striData = @"BlockTestB say hello to VC";
    _byBlock(striData, ^(id testData){
        NSLog(@"BlockTestB get response from VC: %@",testData);
    });
}

@end
