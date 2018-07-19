//
//  Model1.m
//  InterviewDemo
//
//  Created by mac on 2018/6/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "Model1.h"

@implementation Model1

//浅拷贝（指针复制，不会创建一个新的对象）
- (id)copyWithZone:(NSZone *)zone{
    return self;
}

//原始Model指针==0x60c00001a790
//CopyModel指针==0x60c00001a790

//深拷贝(内容复制，会创建一个新的对象)
//- (id)copyWithZone:(NSZone *)zone{
//    Model1 *model = [[Model1 allocWithZone:zone]init];
//    model.a = self.a;
//    return model;
//}

// 原始Model指针==0x600000015a30
// CopyModel指针==0x600000015a60
@end
