//
//  ZWWCase10MasonryVC.m
//  InterviewDemo
//
//  Created by jolly on 2019/4/10.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ZWWCase10MasonryVC.h"

@interface ZWWCase10MasonryVC ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *logLabel;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) MASConstraint *leftConstraint;
@property (nonatomic, strong) MASConstraint *topConstraint;
@end

@implementation ZWWCase10MasonryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _contentView.layer.masksToBounds = YES;
    _contentView.layer.borderWidth = 1.0f;
    _contentView.layer.borderColor = [UIColor redColor].CGColor;
    
    self.tipLabel.text = @"wei371522\niOS";
    [_contentView addSubview:self.tipLabel];
    [_tipLabel sizeToFit];
    
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置边界条件约束，保证内容可见，优先级1000
        make.left.greaterThanOrEqualTo(_contentView.mas_left);
        make.right.lessThanOrEqualTo(_contentView.mas_right);
        make.top.greaterThanOrEqualTo(_contentView.mas_top);
        make.bottom.lessThanOrEqualTo(_contentView.mas_bottom);
        
        _leftConstraint = make.centerX.equalTo(_contentView.mas_left).with.offset(50).priorityHigh(); // 优先级要比边界条件低
        _topConstraint = make.centerY.equalTo(_contentView.mas_top).with.offset(50).priorityHigh(); // 优先级要比边界条件低
        make.width.mas_equalTo(CGRectGetWidth(_tipLabel.frame) + 8);
        make.height.mas_equalTo(CGRectGetHeight(_tipLabel.frame) + 4);
    }];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panWithGesture:)];
    [_contentView addGestureRecognizer:pan];
}

#pragma mark - Pan gesture

- (void)panWithGesture:(UIPanGestureRecognizer *)pan {
    CGPoint touchPoint = [pan locationInView:_contentView];
    _logLabel.text = NSStringFromCGPoint(touchPoint);
    
    _leftConstraint.offset = touchPoint.x;
    _topConstraint.offset = touchPoint.y;
}

#pragma mark - Getter

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = [UIFont systemFontOfSize:20];
        _tipLabel.numberOfLines = 2;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.backgroundColor = [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1];
        _tipLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _tipLabel.layer.borderWidth = 1.0f;
        _tipLabel.layer.masksToBounds = YES;
        _tipLabel.layer.cornerRadius = 2.0f;
    }
    return _tipLabel;
}

@end
