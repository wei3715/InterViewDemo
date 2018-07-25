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

@property (nonatomic, strong) NSString  *stringStrong;
@property (nonatomic, copy)   NSString  *stringCopy;


@end

@implementation ZWWTableViewController (method)

//关联上属性
- (void)setStringCopy:(NSString *)stringCopy{
    objc_setAssociatedObject(self, @selector(stringCopy), stringCopy, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)stringCopy{
    return objc_getAssociatedObject(self, @selector(stringCopy));
}

- (void)setStringStrong:(NSString *)stringStrong{
    objc_setAssociatedObject(self, @selector(stringStrong), stringStrong, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)stringStrong{
   return objc_getAssociatedObject(self, @selector(stringStrong));
}

- (void)testStrongAndCopyStr{
    //初始化两个字符串
    NSString *strongStr = @"aa";
    NSString *copyStr = @"bb";
    self.stringStrong = strongStr;
    self.stringCopy = copyStr;
    
    //strongStr是一个指针变量，它指向strongStr对象的地址。&strongStr指的是strongStr这个指针变量所在的地址。
    ZWWLog(@"strongStr地址==%p, self.stringStrong地址==%p", strongStr,self.stringStrong);
    ZWWLog(@"copyStr地址==%p,self.stringCopy地址==%p", copyStr,self.stringCopy);
    //结果：
    //strongStr地址==0x105d554c0, self.stringStrong地址==0x105d554c0
    //copyStr地址==0x105d554e0,self.stringCopy地址==0x105d554e0
    //结果分析：
    //指针变量地址相同，说明对象地址没有变，只有一份；可以看出，此时无论是strong修饰的字符串还是copy修饰的字符串，都进行了浅Copy.
    
    
    //新创建两个
    NSMutableString *mStrongStr = [NSMutableString stringWithFormat:@"StrongMutable"];
    NSMutableString *mCopyStr = [NSMutableString stringWithFormat:@"CopyMutable"];
    self.stringStrong = mStrongStr;
    self.stringCopy = mCopyStr;
    ZWWLog(@"mStrongStr地址==%p, self.stringStrong地址==%p", mStrongStr,self.stringStrong);
    ZWWLog(@"mCopyStr地址==%p,self.stringCopy地址==%p", mCopyStr,self.stringCopy);
    //结果：
    //mStrongStr地址==0x60400025ab80, self.stringStrong地址==0x60400025ab80
    //mCopyStr地址==0x60400025ac40,self.stringCopy地址==0x6040000351e0
    
    
    //结果分析：用strong修饰的字符串依旧进行了浅Copy,而由copy修饰的字符串进行了深Copy,所以mStrongStr与stringStrong指向了同一块内存，而mCopyStr和stringCopy指向的是完全两块不同的内存。
    
    
    //*******作用*******
    
    //新创建两个NSString对象
    NSString * strong1 = @"I am Strong!";
    NSString * copy1 = @"I am Copy!";
    
    //初始化两个字符串
    self.stringStrong = strong1;
    self.stringCopy = copy1;
    
    //两个NSString进行操作
    [strong1 stringByAppendingString:@"11111"];
    [copy1 stringByAppendingString:@"22222"];
    ZWWLog(@"strong1地址==%p,内容==%@, self.stringStrong地址==%p，内容==%@", strong1,strong1,self.stringStrong,self.stringStrong);
    ZWWLog(@"copy1地址==%p,内容==%@,self.stringCopy地址==%p，内容==%@", copy1,copy1,self.stringCopy,self.stringCopy);
    
    //结果
    //strong1地址==0x105d555c0,内容==I am Strong!, self.stringStrong地址==0x105d555c0，内容==I am Strong!
    //copy1地址==0x105d555e0,内容==I am Copy!,self.stringCopy地址==0x105d555e0，内容==I am Copy!
    //结果分析：
    //分别对在字符串后面进行拼接，当然这个拼接对原字符串没有任何的影响，因为不可变自字符串调用的方法都是有返回值的，原来的值是不会发生变化的.打印如下，对结果没有任何的影响:
    
    
    //新创建两个NSMutableString对象
    NSMutableString * mutableStrong = [NSMutableString stringWithString:@"StrongMutable"];
    NSMutableString * mutableCopy = [NSMutableString stringWithString:@"CopyMutable"];
    
    //初始化两个字符串
    self.stringStrong = mutableStrong;
    self.stringCopy = mutableCopy;
    
    //两个MutableString进行操作
    [mutableStrong appendString:@"Strong!"];
    [mutableCopy appendString:@"Copy!"];
    ZWWLog(@"mutableStrong地址==%p,内容==%@, self.stringStrong地址==%p,内容==%@", mutableStrong,mutableStrong,self.stringStrong,self.stringStrong);
    ZWWLog(@"mutableCopy地址==%p,内容==%@,self.stringCopy地址==%p,内容==%@", mutableCopy,mutableCopy,self.stringCopy,self.stringCopy);
    //结果：
    //mutableStrong地址==0x60000044f000,内容==StrongMutableStrong!, self.stringStrong地址==0x60000044f000,内容==StrongMutableStrong!
    // mutableCopy地址==0x600000447740,内容==CopyMutableCopy!,self.stringCopy地址==0x60000022d4a0,内容==CopyMutable
    
    //结果分析：
    //     再来看一下结果:对mutableStrong进行的操作，由于用strong修饰的stringStrong没有进行深Copy，导致共用了一块内存，当mutableStrong对内存进行了操作的时候，实际上对stringStrong也进行了操作;   相反，用copy修饰的stringCopy进行了深Copy，也就是说stringCopy与mutableCopy用了两块完全不同的内存，所以不管mutableCopy进行了怎么样的变化，原来的stringCopy都不会发生变化.这就在日常中避免了出现一些不可预计的错误。
    
    
    // 总对比结果分析：
    
    //    这样看来，在不可变对象之间进行转换，strong与copy作用是一样的，但是如果在不可变与可变之间进行操作，那么楼主比较推荐copy,这也就是为什么很多地方用copy，而不是strong修饰NSString,NSArray等存在可变不可变之分的类对象了，避免出现意外的数据操作.
    
    
}


//1、首先说说深浅copy
//准则
//浅copy: 指针复制，不会创建一个新的对象。
//深copy: 内容复制，会创建一个新的对象。

//2、框架类的深浅copy
//准则
//探究框架类深copy还是浅copy，需要清楚的是该类如何实现的NSCopying和NSMutableCopy的两个方法copyWithZone:和mutableCopyWithZone:。然而OC并不开源，并且本文这里也不会进行源码的推测。
//那么，我们应该遵循怎样一个原则呢？如下：(只有对 不可变对象 执行copy  是浅拷贝，其他都是深拷贝;mutableCopy操作之后得到都是可变对象)
//对immutableObject，即不可变对象，执行copy，会得到不可变对象，并且是浅copy。
//对immutableObject，即不可变对象，执行mutableCopy，会得到可变对象，并且是深copy。
//对mutableObject，即可变对象，执行copy，会得到不可变对象，并且是深copy。
//对mutableObject，即可变对象，执行mutableCopy，会得到可变对象，并且是深copy。

- (void)TestCopy{
    //不可变对象
    NSString *str = @"zww";
    
    NSString *str1 = [str copy];
    NSString *str2 = [str mutableCopy];
    ZWWLog(@"不可变原始字符串指针==%p,copy后指针==%p，mutableCopy后指针==%p",str,str1,str2);
    
    //可变对象
    NSMutableString *mStr = [NSMutableString stringWithFormat:@"coder"];
    NSMutableString *mStr1 = [mStr copy];
    NSMutableString *mStr2 = [mStr mutableCopy];
    ZWWLog(@"可变原始字符串指针==%p,copy后指针==%p，mutableCopy后指针==%p",mStr,mStr1,mStr2);
}

//结果分析
//不可变原始字符串指针==0x1019810c8,copy后指针==0x1019810c8，mutableCopy后指针==0x604000059050
//可变原始字符串指针==0x604000059140,copy后指针==0xa00007265646f635，mutableCopy后指针==0x604000059380

//准则
//对于一个我们自定义的类型，显然比框架类容易操纵的多。此处就拿NSCopying举例（因为从没有自定义过具有可变类型的类，当然，如果有需要的话，也可以实现NSMutableCopying）。自定义的类就和2中的原则没有半毛钱关系了，一切就看你怎么实现NSCopying协议中的copyWithZone:方法。
- (void)TestCopy1{
    Model1 *model = [[Model1 alloc]init];
    Model1 *copyModel = [model copy];
    ZWWLog(@"原始Model指针==%p",model);
    ZWWLog(@"CopyModel指针==%p",copyModel);
}


- (void)TestCopy201{
    // 和NSString浅copy的验证步骤一样
    NSArray *arr = [NSArray arrayWithObjects:@"1", nil];
    NSArray *copyArr = [arr copy];
    ZWWLog(@"******************浅copy******************");
    ZWWLog(@"原本对象地址==%p", arr);
    ZWWLog(@"copy后对象地址==%p", copyArr);
    ZWWLog(@"******************单层深copy******************");
    
    [self TestCopy202];
    ZWWLog(@"******************双层深copy******************");
    [self TestCopy203];
}

// 结果分析
// 无疑是浅copy(你可能会问，为什么不看一下arr和copyArr内部元素的指针对比？这里并没有必要，最外层对象都没有创建新的，里面不用验证)
//2018-06-15 11:59:44.450604+0800 InterviewDemo[17801:149670] -[ZWWTableViewController(method) TestCopy201] [Line 62] 0x60c000023c20
//2018-06-15 11:59:44.450861+0800 InterviewDemo[17801:149670] -[ZWWTableViewController(method) TestCopy201] [Line 63] 0x60c000023c20


//准则
//容器的单层深copy，符合三.2中的原则（只是深copy变成了单层深copy）。这里的单层指的是完成了NSArray对象的深copy，而未对其容器内对象进行处理。
- (void)TestCopy202{
    
    NSArray *arr = [NSArray arrayWithObjects:@"1",@"2", nil];
    NSArray *copyArr = [arr mutableCopy];
    
//    0x7ffeeecefc38->0x60400002dd6->0x100f12188
    
    ZWWLog(@"指针变量地址==%p, arr对象地址==%p", &arr,arr);
    ZWWLog(@"指针变量地址==%p, copyArr对象地址==%p",&copyArr, copyArr);
    
    //打印arr、copyArr内部元素进行对比
    ZWWLog(@"arr对象首元素地址==%p", arr[0]);
    ZWWLog(@"copyArr对象首元素地址==%p", copyArr[0]);
}

//容器的双层深copy已经脱离了三.2中的原则。这里的双层指的是完成了NSArray对象和NSArray容器内对象的深copy（为什么不说完全，是因为无法处理NSArray中还有一个NSArray这种情况）。
- (void)TestCopy203{
    
    // 随意创建一个NSMutableString对象
    NSMutableString *mutableString = [NSMutableString stringWithString:@"1"];
    
    // 随意创建一个包涵NSMutableString的NSMutableArray对象
    NSMutableString *mutalbeString1 = [NSMutableString stringWithString:@"1"];
    NSMutableArray *mutableArr = [NSMutableArray arrayWithObjects:mutalbeString1, nil];
    
    // 将mutableString和mutableArr放入一个新的NSArray中
    NSArray *testArr = [NSArray arrayWithObjects:mutableString, mutableArr, nil];
    // 通过官方文档提供的方式创建
    NSArray *testArrCopy = [[NSArray alloc] initWithArray:testArr copyItems:YES];
    
    // testArr和testArrCopy指针对比
    ZWWLog(@"%p", testArr);
    ZWWLog(@"%p", testArrCopy);
    
    // testArr和testArrCopy中元素指针对比
    // mutableString对比
    ZWWLog(@"%p", testArr[0]);
    ZWWLog(@"%p", testArrCopy[0]);
    // mutableArr对比
    ZWWLog(@"%p", testArr[1]);
    ZWWLog(@"%p", testArrCopy[1]);
    
    // mutableArr中的元素对比，即mutalbeString1对比
    ZWWLog(@"%p", testArr[1][0]);
    ZWWLog(@"%p", testArrCopy[1][0]);
    
}

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
    
    //NSSet去重的数组没有进行排序
    NSSet *set = [NSSet setWithArray:arr];
    ZWWLog(@"NSSet去重结果==%@",set);
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
    for (id obj in arr) {
        [mDic setObject:obj forKey:obj];
    }
     ZWWLog(@"NSMutableDictionary去重结果==%@",[mDic allValues]);
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

@end
