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

//深拷贝(内容复制，会创建一个新的对象)
//- (id)copyWithZone:(NSZone *)zone{
//    //创建新的对象空间
//    Model1 *model = [[Model1 allocWithZone:zone]init];
//
//    //为每个属性创建新的空间，并将内容复制
//    model.name = [self.name mutableCopy];
//    model.age = self.age;
//    return model;
//}

@end
