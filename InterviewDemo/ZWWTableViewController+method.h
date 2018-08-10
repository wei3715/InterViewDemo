//
//  ZWWTableViewController+method.h
//  MediaTest
//
//  Created by mac on 2018/5/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWTableViewController.h"

@interface ZWWTableViewController (method)


//框架类的深浅copy
- (void)TestCopy;

//自定义类的深浅copy
- (void)TestCopy1;

//容器对象的深浅copy
//浅copy
- (void)TestCopy201;

//单层深copy
- (void)TestCopy202;

//字符串的strong和copy
- (void)testStrongAndCopyStr;

//信号量
- (void)testSignal;

//NSArray去重
- (void)deleteSame;

//指针问题
- (void)testPointer;

//测试字符常量区
- (void)testOCSting;


@end
