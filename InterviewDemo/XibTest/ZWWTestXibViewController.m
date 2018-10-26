//
//  ZWWTestXibViewController.m
//  InterviewDemo
//
//  Created by jolly on 2018/10/17.
//  Copyright © 2018年 mac. All rights reserved.
//11

#import "ZWWTestXibViewController.h"
#import "UIImage+GIF.h"
#import "ZWWLoginViewController.h"

@interface ZWWTestXibViewController ()
- (IBAction)chatBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;

@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIView *bottomAdView;

#pragma 用户信息

@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *loginNameLB;
@property (weak, nonatomic) IBOutlet UILabel *levelLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UIView *recommendView;

@end

@implementation ZWWTestXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.contentViewWidth.constant = KScreenWidth;
    self.contentViewHeight.constant = kRealValue(1000);
    [self playGif];
    [self checkLoginStatus];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    self.bottomAdView.hidden = NO;
//    self.loginView.hidden = YES;
//    self.bottomAdView.hidden = YES;
    [self updateUserInfo];
}

- (void)updateUserInfo{
//    self.headIV.image = nil;
//    self.loginNameLB.text = @"tall000";
//    self.levelLB.text = @"V0";
//    self.moneyLB.text = @"10.0";
    
}
- (IBAction)chatBtnAction:(id)sender {
   [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)loginAction:(UIButton *)sender {
    ZWWLoginViewController *loginXibVC = [[ZWWLoginViewController alloc]init];
    [self.navigationController pushViewController:loginXibVC animated:YES];
}
@end
