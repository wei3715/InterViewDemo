//
//  TestClass.h
//  InterviewDemo
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestClass : NSObject
//测试”多继承“
- (void)methodCA;
- (void)methodCB;

- (void)printClass:(id <MyPTLDelegate>)obj;

//测试多个分类和原类有同名方法，到底执行哪个方法
- (void)testCategoryFunc;
@end
