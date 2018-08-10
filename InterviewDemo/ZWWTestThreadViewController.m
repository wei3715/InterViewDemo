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


//参考链接：https://blog.csdn.net/wei371522/article/details/81216853

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
