//
//  AAViewController.m
//  InterviewDemo
//
//  Created by Jolly on 2018/10/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AAViewController.h"
#import "BBViewController.h"
#import "ZWWTestDelegateView.h"
@interface AAViewController ()

@end

@implementation AAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getDelegateClassName0];
    [self getDelegateClassName1];
    
}

- (void)getDelegateClassName0{
    BBViewController *bbVC = [[BBViewController alloc]init];
    self.delegate = bbVC;
    const char * className = object_getClassName(self.delegate);
    ZWWLog(@"AAVCDelegate类型名字==%s", className);
    if (self.delegate && [self.delegate respondsToSelector:@selector(iNeedYouHelpMeDoSomethingWithStr:)]) {
        [self.delegate iNeedYouHelpMeDoSomethingWithStr:[NSString stringWithFormat:@"%s的钱",object_getClassName(self)]];
    }
}

- (void)getDelegateClassName1{
    ZWWTestDelegateView *zwwView = [[ZWWTestDelegateView alloc]init];
    self.delegate = zwwView;
    const char * className = object_getClassName(self.delegate);
    ZWWLog(@"AAVCDelegate类型名字==%s", className);
    if (self.delegate && [self.delegate respondsToSelector:@selector(iNeedYouHelpMeDoSomethingWithStr:)]) {
        [self.delegate iNeedYouHelpMeDoSomethingWithStr:[NSString stringWithFormat:@"%s的钱",object_getClassName(self)]];
    }
}

@end
