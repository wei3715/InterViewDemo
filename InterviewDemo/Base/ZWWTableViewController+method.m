//
//  ZWWTableViewController+method.m
//  MediaTest
//
//  Created by mac on 2018/5/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWTableViewController+method.h"
#import "Model1.h"
#import <objc/runtime.h>
@interface ZWWTableViewController ()

@end

@implementation ZWWTableViewController (method)

//关联上属性
//- (void)setStringCopy:(NSString *)stringCopy{
//    objc_setAssociatedObject(self, @selector(stringCopy), stringCopy, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (NSString *)stringCopy{
//    return objc_getAssociatedObject(self, @selector(stringCopy));
//}

//
- (void)testSignal{
    //crate的value表示，最多几个资源可访问
    //如果为2，那么肯定最后执行任务3；如果为1，那么肯定先执行完任务1，再任务2，再任务3
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(3);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //任务1
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(1);
        NSLog(@"complete task 1");
        dispatch_semaphore_signal(semaphore);
    });
    //任务2
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(1);
        NSLog(@"complete task 2");
        dispatch_semaphore_signal(semaphore);
    });
    //任务3
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 3");
        sleep(1);
        NSLog(@"complete task 3");
        dispatch_semaphore_signal(semaphore);
    });
}

- (void)deleteSame{
    NSArray *arr = @[@"111",@"222",@"333",@"222"];
    ZWWLog(@"原数组==%@", arr);
    //NSSet去重的数组没有进行排序
    NSSet *set = [NSSet setWithArray:arr];
    ZWWLog(@"NSSet去重结果==%@",set);
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
    for (id obj in arr) {
        [mDic setObject:obj forKey:obj];
    }
     ZWWLog(@"NSMutableDictionary去重结果==%@",[mDic allValues]);
    
    //去重无序，valueForKeyPath还有很多很实用很强大的功能
    NSArray *afterArr = [arr valueForKeyPath:@"@distinctUnionOfObjects.self"];
     ZWWLog(@"valueForKeyPath去重结果%@", afterArr);
}

- (void)testPointer{
    int arr[] = {4, 20 , 10 , -3, 34};
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
    
    int *ptr = (int*)(&arr+1);
    //*(ptr-1)
    ZWWLog(@"arr地址==%p  &arr+1地址==%p" , arr, &arr+1);
    ZWWLog(@"*(arr+1)==%d,*(*(&arr))==%d" , *(arr+1),*(ptr-1));
    // 将arr第一个数组元素的地址赋给指针变量p
    int *p = &arr[0];
    // 将arr数组变量当成指针输出
    ZWWLog(@"arr地址==%p  arr+1地址==%p" , arr,arr+1);
    // 输出指针变量p
    ZWWLog(@"p指针地址==%p  p+1指针地址%p" , p,p+1);
}

//测试字符常量区
- (void)testOCSting{
    NSString *str1 = @"zww";
    NSLog(@"str1的内存地址==%p",str1);
    [self testOCSting01];
}
- (void)testOCSting01{
    NSString *str2 = @"zww";
    NSLog(@"str2的内存地址==%p",str2);
}
//结论：
/*发现str1的内存地址和str2的内存地址完全一样！！！ 因为它们存放在字符常量区
字符常量区的工作原理：创建一个字符串常量时，先从字符常量区查找看有没有相同内容的内存，会先去找有没有同样内容的字符串，有的话直接共用这块内存，没有的话再开辟新的内存放入变量值
字符串常量是不可变的，一旦改变就会生成一个新的变量，开辟一个新的内存*/

@end
