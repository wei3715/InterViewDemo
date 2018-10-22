//
//  ZWWCell.m
//  InterviewDemo
//
//  Created by jolly on 2018/10/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWCell.h"
#import "ZWWDataEntity.h"
@interface ZWWCell ()

@property (nonatomic, strong) UIImageView *avatarIV;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *contentLB;
@property (nonatomic, weak) ZWWDataEntity *dataEntity;

@end

@implementation ZWWCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.tag = 1000;

    _avatarIV = [UIImageView new];
    [self.contentView addSubview:_avatarIV];
    [_avatarIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.left.top.equalTo(self.contentView).offset(4);
    }];

    //单行
    _titleLB = [UILabel new];
    [self.contentView addSubview:_titleLB];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(22);
        make.top.equalTo(self.contentView).offset(4);
        make.left.equalTo(_avatarIV.mas_right).offset(4);
        make.right.equalTo(self.contentView).offset(-4);
    }];


    // 计算UILabel的preferredMaxLayoutWidth值，多行时必须设置这个值，否则系统无法决定Label的宽度
    CGFloat preferredMaxWidth = KScreenWidth - 44 - 4*3; // 44 = avatar宽度，4 * 3为padding

    //多行
    _contentLB = [UILabel new];
    _contentLB.numberOfLines = 0;
    _contentLB.preferredMaxLayoutWidth = preferredMaxWidth; // 多行时必须设置
    [self.contentView addSubview:_contentLB];
    [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLB.mas_bottom).offset(4);
        make.left.equalTo(_avatarIV.mas_right).offset(4);
        make.right.equalTo(self.contentView).offset(-4);
        make.bottom.equalTo(self.contentView).offset(-4);
    }];

    [_contentLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
//    self.tag = 1000;
//    
//    // Avatar头像
//    _avatarIV = [UIImageView new];
//    [self.contentView addSubview:_avatarIV];
//    [_avatarIV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.and.height.equalTo(@44);
//        make.left.and.top.equalTo(self.contentView).with.offset(4);
//    }];
//    
//    // Title - 单行
//    _titleLB = [UILabel new];
//    [self.contentView addSubview:_titleLB];
//    
//    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@22);
//        make.top.equalTo(self.contentView).with.offset(4);
//        make.left.equalTo(_avatarIV.mas_right).with.offset(4);
//        make.right.equalTo(self.contentView).with.offset(-4);
//    }];
//    
//    // 计算UILabel的preferredMaxLayoutWidth值，多行时必须设置这个值，否则系统无法决定Label的宽度
//    CGFloat preferredMaxWidth = [UIScreen mainScreen].bounds.size.width - 44 - 4 * 3; // 44 = avatar宽度，4 * 3为padding
//    
//    // Content - 多行
//    _contentLB = [UILabel new];
//    _contentLB.numberOfLines = 0;
//    _contentLB.preferredMaxLayoutWidth = preferredMaxWidth; // 多行时必须设置
//    [self.contentView addSubview:_contentLB];
//    
//    [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_titleLB.mas_bottom).with.offset(4);
//        make.left.equalTo(_avatarIV.mas_right).with.offset(4);
//        make.right.equalTo(self.contentView).with.offset(-4);
//        make.bottom.equalTo(self.contentView).with.offset(-4);
//    }];
//    
//    [_contentLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

- (void)setupData:(ZWWDataEntity *)dataEntity{
    _dataEntity = dataEntity;
    _avatarIV.image = dataEntity.avatar;
    _titleLB.text = dataEntity.title;
    _contentLB.text = dataEntity.content;
}

@end
