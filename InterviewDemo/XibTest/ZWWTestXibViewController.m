//
//  ZWWTestXibViewController.m
//  InterviewDemo
//
//  Created by Jolly on 2018/10/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWTestXibViewController.h"
#import "ZWWTestXibView.h"

@interface ZWWTestXibViewController ()

@end

@implementation ZWWTestXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    ZWWTestXibView *nibView = (ZWWTestXibView *)[[[NSBundle mainBundle]loadNibNamed:@"ZWWTestXibView" owner:self options:nil]lastObject];
    [self.view addSubview:nibView];
    
}



@end
