//
//  BBViewController.m
//  InterviewDemo
//
//  Created by Jolly on 2018/10/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BBViewController.h"

@interface BBViewController ()

@end

@implementation BBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)iNeedYouHelpMeDoSomethingWithStr:(NSString *)str{
    ZWWLog(@"%s使用%@完成委托事情",object_getClassName(self), str);
    
}

@end
