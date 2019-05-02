//
//  ZWWCase3MasonryVC.m
//  InterviewDemo
//
//  Created by jolly on 2019/4/3.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ZWWCase3MasonryVC.h"

@interface ZWWCase3MasonryVC ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewWidthConstraint;
@property (assign, nonatomic) CGFloat maxWidth;

@end

@implementation ZWWCase3MasonryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    //保存最大宽度
    _maxWidth = _containerViewWidthConstraint.constant;
}

- (IBAction)modifyContainerViewWidth:(UISlider *)sender {
    if (sender.value) {
        //改变containerView的宽度
        _containerViewWidthConstraint.constant = sender.value * _maxWidth;
    }
}

# pragma mark - Private methods

- (void) initView {
    UIView *subView = [UIView new];
    subView.backgroundColor = [UIColor redColor];
    
    [_containerView addSubview:subView];
    
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        //上下左贴边
        make.left.equalTo(_containerView.mas_left);
        make.top.equalTo(_containerView.mas_top);
        make.bottom.equalTo(_containerView.mas_bottom);
        
        //宽度为父view的宽度的一半
        make.width.equalTo(_containerView.mas_width).multipliedBy(0.5);
    }];
}

@end
