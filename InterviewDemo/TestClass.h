//
//  TestClass.h
//  InterviewDemo
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestClass : NSObject
//通过组合实现“多继承”
- (instancetype)init;
- (void)methodA;
- (void)methodB;

- (void)testCls;
- (void)printClass:(id <MyPTLDelegate>)obj;
@end
