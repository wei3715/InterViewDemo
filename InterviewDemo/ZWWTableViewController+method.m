//
//  ZWWTableViewController+method.m
//  MediaTest
//
//  Created by mac on 2018/5/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWTableViewController+method.h"
#import "Model1.h"
@implementation ZWWTableViewController (method)

//1、首先说说深浅copy
//准则
//浅copy: 指针复制，不会创建一个新的对象。
//深copy: 内容复制，会创建一个新的对象。
//此处，不进行过多的解释，从下面的结果分析中，按例子来理解。
//
//2、框架类的深浅copy
//准则
//探究框架类深copy还是浅copy，需要清楚的是该类如何实现的NSCopying和NSMutableCopy的两个方法copyWithZone:和mutableCopyWithZone:。然而OC并不开源，并且本文这里也不会进行源码的推测。
//
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




@end
