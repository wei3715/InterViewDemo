//
//  ZWWTestXibViewController.m
//  InterviewDemo
//
//  Created by jolly on 2018/10/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWTestXibViewController.h"
#import "UIImage+GIF.h"
@interface ZWWTestXibViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;

@property (weak, nonatomic) IBOutlet UIView *loginView;

#pragma 用户信息

@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *loginNameLB;
@property (weak, nonatomic) IBOutlet UILabel *levelLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;

@end

@implementation ZWWTestXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.contentViewWidth.constant = KScreenWidth;
    self.contentViewHeight.constant = 1000;
    [self playGif];
    [self checkLoginStatus];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)playGif {
    NSString *gitPath = [[NSBundle mainBundle] pathForResource:@"home_game_class" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:gitPath];
    self.giftImageView.image = [UIImage sd_animatedGIFWithData:data];
    self.giftImageView.layer.cornerRadius = 6;
    self.giftImageView.layer.masksToBounds = YES;
}

- (void)checkLoginStatus{
    self.loginView.hidden = NO;
    [self updateUserInfo];
}

- (void)updateUserInfo{
    self.headIV.image = nil;
    self.loginNameLB.text = @"";
    self.levelLB.text = @"";
    self.moneyLB.text = @"";
    
}
@end
