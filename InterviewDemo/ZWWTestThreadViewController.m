//
//  ZWWTestThreadViewController.m
//  InterviewDemo
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWTestThreadViewController.h"

@interface ZWWTestThreadViewController ()

@end

@implementation ZWWTestThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    ZWWLog(@"retainCount=%ld",CFGetRetainCount((__bridge CFTypeRef)self));
    //performSelector调用方法
    [self performSelector:@selector(testPerformSelectorFunc) withObject:self afterDelay:10.0];
    
    //直接调用方法
//    [self testPerformSelectorFunc];
    ZWWLog(@"retainCount=%ld",CFGetRetainCount((__bridge CFTypeRef)self));
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    ZWWLog();
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

//
- (void)testPerformSelectorFunc{
    ZWWLog();
}

- (void)dealloc
{
    ZWWLog(@"对象被销毁");
    ZWWLog(@"retainCount=%ld",CFGetRetainCount((__bridge CFTypeRef)self));
}
//现象：

/*
 1.执行performSelector后，self.retainCount是会增加的
 2.当未达到10s就退出此界面，此时执行viewDidDisappear，但不执行dealloc，证明对象并没有销毁，造成内存泄漏
等达到10s的时候，testPerformSelectorFunc仍然会执行，此时才会执行dealloc方法，对象才真正得到释放
 打印情况：
 2018-07-26 10:30:33.823862+0800 InterviewDemo[10335:82456] -[ZWWTestThreadViewController viewDidLoad] [Line 21] retainCount=8
 2018-07-26 10:30:33.823942+0800 InterviewDemo[10335:82456] -[ZWWTestThreadViewController viewDidLoad] [Line 27] retainCount=10
 2018-07-26 10:30:36.548624+0800 InterviewDemo[10335:82456] -[ZWWTestThreadViewController viewDidDisappear:] [Line 32]
 2018-07-26 10:30:43.824704+0800 InterviewDemo[10335:82456] -[ZWWTestThreadViewController testPerformSelectorFunc] [Line 37]
 2018-07-26 10:30:43.824890+0800 InterviewDemo[10335:82456] -[ZWWTestThreadViewController dealloc] [Line 42] 对象被销毁
 2018-07-26 10:30:43.825009+0800 InterviewDemo[10335:82456] -[ZWWTestThreadViewController dealloc] [Line 43] retainCount=1
 3.如果达到10s，再退出页面则会正常执行dealloc方法
 打印情况：
 2018-07-26 10:31:56.436817+0800 InterviewDemo[10487:84121] -[ZWWTestThreadViewController viewDidLoad] [Line 21] retainCount=8
 2018-07-26 10:31:56.436925+0800 InterviewDemo[10487:84121] -[ZWWTestThreadViewController viewDidLoad] [Line 27] retainCount=10
 2018-07-26 10:32:06.437717+0800 InterviewDemo[10487:84121] -[ZWWTestThreadViewController testPerformSelectorFunc] [Line 37]
 2018-07-26 10:32:12.201159+0800 InterviewDemo[10487:84121] -[ZWWTestThreadViewController viewDidDisappear:] [Line 32]
 2018-07-26 10:32:12.201518+0800 InterviewDemo[10487:84121] -[ZWWTestThreadViewController dealloc] [Line 42] 对象被销毁
 2018-07-26 10:32:12.201606+0800 InterviewDemo[10487:84121] -[ZWWTestThreadViewController dealloc] [Line 43] retainCount=1*/

//总结
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
