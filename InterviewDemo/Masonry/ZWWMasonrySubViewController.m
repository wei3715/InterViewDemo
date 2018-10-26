//
//  ZWWMasonrySubViewController.m
//  InterviewDemo
//
//  Created by jolly on 2018/10/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWMasonrySubViewController.h"
#define detailIVH 100
@interface ZWWMasonrySubViewController ()

@property (nonatomic, strong) MASConstraint   *ivHeightCons;
@property (nonatomic, strong) MASConstraint   *viewTopCons;
@property (weak, nonatomic) IBOutlet UISwitch *hideBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIImageView *detailIV;
@property (weak, nonatomic) IBOutlet UIView *underView;

@end

@implementation ZWWMasonrySubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self makeConstraints];
}

- (void)makeConstraints{
    
    [self.hideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(kRealValue(100), kRealValue(30)));
        make.top.equalTo(self.view).offset(kRealValue(100));
        make.left.equalTo(self.view).offset(kRealValue(15));
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KScreenWidth-kRealValue(30), kRealValue(100)));
        make.top.equalTo(self.hideBtn.mas_bottom).offset(kRealValue(20));
        make.left.equalTo(self.view).offset(kRealValue(15));
    }];
    
    [self.detailIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(KScreenWidth-kRealValue(30)));
        self.ivHeightCons = make.height.equalTo(@(detailIVH));
        make.top.equalTo(self.titleLB.mas_bottom).offset(kRealValue(20));
        make.left.equalTo(self.view).offset(kRealValue(15));
    }];
    
    [self.underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KScreenWidth-kRealValue(30), kRealValue(80)));
        make.top.equalTo(self.detailIV.mas_bottom).offset(kRealValue(20));
        
        //下面约束会在self.detailIV移除（不是hidden）后，self.underView相对self.titleLB布局
//        make.top.equalTo(self.detailIV.mas_bottom).offset(kRealValue(20)).priority(999);
//        make.top.equalTo(self.titleLB.mas_bottom).offset(kRealValue(20)).priorityLow();
        make.left.equalTo(self.view).offset(kRealValue(15));
    }];
    
}
- (IBAction)hideAction:(id)sender {
    
    
}
- (IBAction)hideViewAction:(UISwitch *)sender {
    if (sender.on) {
        self.ivHeightCons.mas_equalTo(detailIVH);
        [self.underView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.detailIV.mas_bottom).offset(kRealValue(20));
        }];
        
        
    } else {
        self.ivHeightCons.mas_equalTo(0);
        [self.underView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.detailIV.mas_bottom);
        }];
        
        //移除后self.underView会相对self.titleLB布局
        //[self.detailIV removeFromSuperview];
        
    }
}


@end
