//
//  ZWWTestScollviewXib.m
//  InterviewDemo
//
//  Created by jolly on 2019/3/30.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ZWWTestScollviewXib.h"

@interface ZWWTestScollviewXib ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registByPhoneViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *RegistFastViewBottom;
@property (weak, nonatomic) IBOutlet UIView *registFastView;
@property (weak, nonatomic) IBOutlet UIView *registPhoneView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ZWWTestScollviewXib

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.registFastView removeConstraint:self.RegistFastViewBottom];
//    [self.registPhoneView removeConstraint:self.registByPhoneViewBottom];
    
}
- (IBAction)registFastAction:(UIButton *)sender {
    self.registFastView.hidden = NO;
    self.registPhoneView.hidden = YES;
//    [self.registFastView addConstraint:self.RegistFastViewBottom];
//    [self.registPhoneView removeConstraint:self.registByPhoneViewBottom];
    
    self.registByPhoneViewBottom.priority = 300;
  
    
}
- (IBAction)registPhoneAction:(UIButton *)sender {
    self.registFastView.hidden = YES;
    self.registPhoneView.hidden = NO;
    
    self.registByPhoneViewBottom.priority = 1000;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
