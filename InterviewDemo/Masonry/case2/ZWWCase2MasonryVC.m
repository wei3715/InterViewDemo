//
//  ZWWCase2MasonryVC.m
//  InterviewDemo
//
//  Created by jolly on 2019/4/3.
//  Copyright © 2019年 mac. All rights reserved.
//  有时间xib直接循环布局试下

#import "ZWWCase2MasonryVC.h"
static const CGFloat IMAGE_SIZE = 32;

@interface ZWWCase2MasonryVC ()

@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) NSMutableArray *imageViews;
@property (strong, nonatomic) NSMutableArray *widthConstraints;
@property (strong, nonatomic) NSArray *imageNames;

@end

@implementation ZWWCase2MasonryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _imageViews = [NSMutableArray new];
    _widthConstraints = [NSMutableArray new];
    _imageNames = @[@"bluefaces_1", @"bluefaces_2", @"bluefaces_3", @"bluefaces_4"];
    
    [self initContainerView];
    [self initViews];
}

- (IBAction)showOrHideImage:(UISwitch *)sender {
    NSUInteger index = (NSUInteger) sender.tag;
    MASConstraint *width = _widthConstraints[index];
    
    if (sender.on) {
        width.equalTo(@(IMAGE_SIZE));
    } else {
        width.equalTo(@0);
    }
}

#pragma mark - Private methods

- (void)initContainerView {
    _containerView = [UIView new];
    [self.view addSubview:_containerView];
    
    _containerView.backgroundColor = [UIColor grayColor];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        //只设置高度，宽度由子View决定
        make.height.equalTo(@(IMAGE_SIZE));
        //水平居中
        make.centerX.equalTo(self.view.mas_centerX);
        //距离父View顶部200点
        make.top.equalTo(self.view.mas_top).offset(200);
    }];
}

- (void)initViews {
    //循环创建、添加imageView
    for (NSUInteger i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageNames[i]]];
        [_imageViews addObject:imageView];
        [_containerView addSubview:imageView];
    }
    
    //设定大小
    CGSize imageViewSize = CGSizeMake(IMAGE_SIZE, IMAGE_SIZE);
    
    //分别设置每个imageView的宽高、左边、垂直中心约束，注意约束的对象
    //每个View的左边约束和左边的View的右边相等=。=，有点绕口...
    
    UIImageView __block *lastView = nil;
    MASConstraint __block *widthConstraint = nil;
    NSUInteger arrayCount = _imageViews.count;
  
    [_imageViews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            //宽高固定
            widthConstraint = make.width.equalTo(@(imageViewSize.width));
            make.height.equalTo(@(imageViewSize.height));
            //左边约束
            make.left.equalTo(lastView ? lastView.mas_right : imageView.superview.mas_left);
            //垂直中心对齐
            make.centerY.equalTo(imageView.superview.mas_centerY);
            //设置最右边的imageView的右边与父view的最右对齐
            if (idx == arrayCount - 1) {
                make.right.equalTo(imageView.superview.mas_right);
            }
            
            [_widthConstraints addObject:widthConstraint];
            lastView = imageView;
        }];
    }];
}
@end
