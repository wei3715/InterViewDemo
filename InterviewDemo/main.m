//
//  main.m
//  InterviewDemo
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        int arr[] = {4, 20 , 10 , -3, 34};
        //常考问题
        
//## 指针p的加减法运算
//        - 指针p + N
//        - p里面存储的地址值 + N * 指针所指向类型的占用字节数
//        - 指针p - N
//        - p里面存储的地址值 - N * 指针所指向类型的占用字节数
//
//
//## 数组名
//        - 存储的是`数组首元素`的地址
//        - 等价于:一个指向`数组首元素`的指针
//        - `数组名 + 1` 的跨度：`数组首元素`的占用字节数
//
//
//## 其他结论
//        - `&num + 1`的跨度：`num`的占用字节数    “最重要”
        
        int *ptr = (int*)(&arr+1);
        ZWWLog(@"%d,%d" , *(arr+1),*(ptr-1));
        // 将arr第一个数组元素的地址赋给指针变量p
        int *p = &arr[0];
        // 将arr数组变量当成指针输出
        ZWWLog(@"%p  %p" , arr,arr+1);
        // 输出指针变量p
        ZWWLog(@"%p  %p" , p,p+1);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
