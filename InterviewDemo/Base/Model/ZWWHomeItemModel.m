//
//  ZWWHomeItemModel.m
//  InterviewDemo
//
//  Created by jolly on 2022/4/4.
//  Copyright © 2022 mac. All rights reserved.
//

#import "ZWWHomeItemModel.h"

@implementation ZWWHomeItemModel
- (instancetype )initWithTitle:(NSString *)title  pushVCName:(NSString *)vcName{
    if (self = [super init]) {
        _title = title;
        _pushVCName = vcName;
    }
    return self;
}

+ (instancetype )modelWithTitle:(NSString *)title pushVCName:(NSString *)vcName{
    ZWWHomeItemModel *model= [[ZWWHomeItemModel alloc]initWithTitle:title pushVCName:vcName];
    return model;
}

@end
