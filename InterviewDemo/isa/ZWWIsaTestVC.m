//
//  ZWWIsaTestVC.m
//  InterviewDemo
//
//  Created by jolly on 2024/1/22.
//  Copyright © 2024 mac. All rights reserved.
//
/**
 指针：内存地址
 指针变量：存储内存地址的变量（描述数据在内存中的位置）
 内存：以字节为单位的连续编址空间，每一个字节单元对应一个独一的编号，这个编号就为内存地址
 定义指针的一般形式：类型*指针变量名*
 */

#import "ZWWIsaTestVC.h"

@interface ZWWIsaTestVC ()

@end

@implementation ZWWIsaTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"指针测试";
}
- (IBAction)testIsa:(id)sender {
    int a = 5;
    int *p0 = &a;
    ZWWLog(@"\n1.指向的对象变量a的地址是=%p\n2.指向的对象变量a的类型是int占用字节数=%d\n3.指向的对象变量a的内容是=%d\n4.指针变量p0本身的地址是=%p\n5.指针变量p0本身的内容是=%p\n6.指针变量p0指向的变量内容是=%d\n",&a, sizeof(a),a,&p0,p0,*p0);
    /*
     1.指向的对象变量a的地址是=0x7ff7bb5e335c
     2.指向的对象变量a的类型是int占用字节数=4
     3.指向的对象变量a的内容是=5
     4.指针变量p0本身的地址是=0x7ff7bb5e3350
     5.指针变量p0本身的内容是=0x7ff7bb5e335c
     6.指针变量p0指向的变量内容是=5
     */
    int arr[] = {4, 20, -3};
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
    //        - '&数组名 + 1' 的跨度：整个数组所有元素所占字节数
    //
    //## 其他结论
    //        - `&num + 1`的跨度：`num`的占用字节数    “最重要”
    
    // 将arr第一个数组元素的地址赋给指针变量p
    int *p = &arr[0];
    // 将arr数组变量当成指针输出
    ZWWLog(@"\narr地址==%p  arr+1地址==%p" , arr,arr+1);
    //arr地址==0x7ff7bb5e337c  arr+1地址==0x7ff7bb5e3380
    
    // 输出指针变量p
    ZWWLog(@"\np指针存储的地址内容==%p  p+1指针存储的地址==%p,arr[1]地址=%p，arr[2]地址=%p，arr[3]地址=%p" , p,p+1,&arr[1],&arr[2]);
    
    int *ptr = (int*)(&arr+1);
    //*(ptr-1)
    ZWWLog(@"\narr地址==%p  &arr+1地址==%p" , arr, &arr+1);
    ZWWLog(@"\n*(arr+1)==%d,*(*(&arr))==%d" , *(arr+1),*(ptr-1));
}



@end
