//
//  ZWWTestCopyViewController.m
//  InterviewDemo
//
//  Created by Jolly on 2018/10/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWTestCopyViewController.h"
#import "Model1.h"
#import <objc/runtime.h>

@interface ZWWTestCopyViewController ()

@property (nonatomic, strong) NSString  *stringStrong;
@property (nonatomic, copy)   NSString  *stringCopy;

@end

@implementation ZWWTestCopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//首先说说深浅copy准则:
//浅copy: 指针复制，不会创建一个新的对象,指针与原指针地址相同
//深copy: 内容复制，会创建一个新的对象,指针地址与原对象的指针地址不同。

//1、框架类的深浅copy准则:
//探究框架类深copy还是浅copy，需要清楚的是该类如何实现的NSCopying和NSMutableCopy的两个方法copyWithZone:和mutableCopyWithZone:。然而OC并不开源，并且本文这里也不会进行源码的推测。
//那么，我们应该遵循怎样一个原则呢？如下：(只有对 不可变对象 执行copy  是浅拷贝，其他都是深拷贝;mutableCopy操作之后得到都是可变对象)
//对immutableObject，即不可变对象，执行copy，会得到不可变对象，并且是浅copy。
//对immutableObject，即不可变对象，执行mutableCopy，会得到可变对象，并且是深copy。
//对mutableObject，即可变对象，执行copy，会得到不可变对象，并且是深copy。
//对mutableObject，即可变对象，执行mutableCopy，会得到可变对象，并且是深copy。

//总结
//1- 对一个NSString字符串进行copy不会产生新对象（浅拷贝)
//2- 对一个NSMutableString字符串进行copy会产生新对象（深拷贝)
//3- copy产生的新对象为NSString类型
//4- mutableCopy产生的新对象为NSMutableString类型

//1.框架类深浅拷贝
- (IBAction)testCopy1:(id)sender {
    
    //不可变对象
    NSString *str = @"zww";
    
    NSString *str1 = [str copy];                //浅拷贝
    NSString *str2 = [str mutableCopy];         //深拷贝
    
    NSMutableString *str3 = [str copy];         //浅拷贝
    //crash
    //    [str3 appendString:@"333"];               //对 NSString copy结果为不可变对象
    NSMutableString *str4 = [str mutableCopy];  //深拷贝
    //正常
    [str4 appendString:@"333"];                //对 NSString mutableCopy结果为可变对象
    ZWWLog(@"指针值str=%p,str1=%p",str,str1);
    ZWWLog(@"指针值str=%p,str2=%p",str,str2);
    ZWWLog(@"指针值str=%p,mStr1=%p",str,str3);
    ZWWLog(@"指针值str=%p,mStr2=%p",str,str4);
    NSLog(@"str4==%@",str4);
    
    //可变对象
    NSMutableString *mStr = [NSMutableString stringWithFormat:@"coder"];
    
    NSString *mStr1 = [mStr copy];                    //深拷贝
    NSString *mStr2 = [mStr mutableCopy];             //深拷贝
    NSMutableString *mStr3 = [mStr copy];             //深拷贝
    //    [mStr3 appendString:@"333"]; //crash            //对 NSMutableString copy结果为不可变对象
    NSMutableString *mStr4 = [mStr mutableCopy];      //深拷贝
    [mStr4 appendString:@"444"];                      //对 NSMutableString mutableCopy结果为可变对象
    ZWWLog(@"指针值mStr=%p,mStr1=%p",mStr,mStr1);
    ZWWLog(@"指针值mStr=%p,mStr2=%p",mStr,mStr2);
    ZWWLog(@"指针值mStr=%p,mStr3=%p",mStr,mStr3);
    ZWWLog(@"指针值mStr=%p,mStr4=%p",mStr,mStr4);
    NSLog(@"mStr4==%@",mStr4 );
}
//结果分析
//不可变原始字符串指针==0x1019810c8,copy后指针==0x1019810c8，mutableCopy后指针==0x604000059050
//可变原始字符串指针==0x604000059140,copy后指针==0xa00007265646f635，mutableCopy后指针==0x604000059380

//2.自定义类的深浅拷贝
//准则：对于一个我们自定义的类型，显然比框架类容易操纵的多。此处就拿NSCopying举例（因为从没有自定义过具有可变类型的类，当然，如果有需要的话，也可以实现NSMutableCopying）。自定义的类就和2中的原则没有半毛钱关系了，一切就看你怎么实现NSCopying协议中的copyWithZone:方法。
- (IBAction)testCopy2:(id)sender {
    Model1 *model = [[Model1 alloc]init];
    model.name = @"coder";
    Model1 *copyModel = [model copy];
    ZWWLog(@"指针值model==%p，copyModel==%p",model,copyModel);
    ZWWLog(@"属性地址model.name==%p,copyModel.name==%p",model.name,copyModel.name);
}

//3.容器对象的深浅copy
//单层深拷贝
- (IBAction)testCopy3:(id)sender {
    // 和NSString浅copy的验证步骤一样
    NSArray *arr = [NSArray arrayWithObjects:@"1", nil];
    NSArray *copyArr = [arr copy];
    ZWWLog(@"******************浅copy******************");
    ZWWLog(@"原对象指针arr==%p,copyArr==%p", arr,copyArr);
    
    ZWWLog(@"******************单层深copy******************");
    //这里的单层指的是完成了NSArray对象的深copy，而未对其容器内对象进行处理。
    NSArray *mCopyArr = [arr mutableCopy];
    ZWWLog(@"原对象指针arr==%p,mCopyArr==%p", arr,mCopyArr);
    ZWWLog(@"指针变量地址==%p, arr对象地址==%p", &arr,arr);
    ZWWLog(@"指针变量地址==%p, mCopyArr对象地址==%p",&copyArr, mCopyArr);
    
    //打印arr、copyArr内部元素进行对比
    ZWWLog(@"arr对象首元素地址==%p", arr[0]);
    ZWWLog(@"mCopyArr对象首元素地址==%p", mCopyArr[0]);
    ZWWLog(@"******************双层深copy******************");
    [self TestDoubleDeepCopy];
}
// 结果分析
// 无疑是浅copy(你可能会问，为什么不看一下arr和copyArr内部元素的指针对比？这里并没有必要，最外层对象都没有创建新的，里面不用验证)
//2018-06-15 11:59:44.450604+0800 InterviewDemo[17801:149670] -[ZWWTableViewController(method) TestCopy201] [Line 62] 0x60c000023c20
//2018-06-15 11:59:44.450861+0800 InterviewDemo[17801:149670] -[ZWWTableViewController(method) TestCopy201] [Line 63] 0x60c000023c20


//容器的双层深copy
//已经脱离了三.2中的原则。这里的双层指的是完成了NSArray对象和NSArray容器内对象的深copy（为什么不说完全，是因为无法处理NSArray中还有一个NSArray这种情况）。
- (void)TestDoubleDeepCopy{
    
    // 随意创建一个NSMutableString对象
    NSMutableString *mStr = [NSMutableString stringWithString:@"zww"];
    
    // 随意创建一个包涵NSMutableString的NSMutableArray对象
    NSMutableString *mStr1 = [NSMutableString stringWithString:@"111"];
    NSMutableArray *mArr = [NSMutableArray arrayWithObjects:mStr1, nil];
    
    // 将mutableString和mutableArr放入一个新的NSArray中
    NSArray *testArr = [NSArray arrayWithObjects:mStr, mArr, nil];
    // 通过官方文档提供的方式创建
    NSArray *testArrCopy = [[NSArray alloc] initWithArray:testArr copyItems:YES];
    
    // testArr和testArrCopy指针对比
    ZWWLog(@"原对象指针testArr==%p,testArrCopy==%p", testArr,testArrCopy);
    
    // testArr和testArrCopy中元素指针对比
    // mStr对比
    ZWWLog(@"首元素mStr地址testArr[0]==%p，testArrCopy[0]==%p", testArr[0],testArrCopy[0]);
    
    // mArr对比
    ZWWLog(@"其中元素mArr地址testArr[1]==%p，testArrCopy[1]==%p", testArr[1],testArrCopy[1]);
    
    
    // mArr中的元素对比，即mStr1对比
    ZWWLog(@"其中元素mArr里面包含元素mStr1的地址testArr[1][0]==%p，testArrCopy[1][0]==%p", testArr[1][0],testArrCopy[1][0]);
}

- (IBAction)testStrongAndCopyStr:(id)sender {
    
    //参考CSDN文章：https://blog.csdn.net/wei371522/article/details/81331658
    //情况1:给属性赋NSString类型的值
    NSString *strongStr = @"I am Strong";
    NSString *copyStr = @"I am Copy";
    self.stringStrong = strongStr;
    self.stringCopy = copyStr;
    
    //strongStr是一个指针变量，它指向strongStr对象的地址。&strongStr指的是strongStr这个指针变量所在的地址。
    ZWWLog(@"strongStr地址==%p; self.stringStrong地址==%p",strongStr,self.stringStrong);
    ZWWLog(@"copyStr地址==%p; self.stringCopy地址==%p",copyStr,self.stringCopy);
    
    //两个NSString进行操作（对不可变字符串拼接，是产生两个新的内存）
    NSString *strong1Append =  [strongStr stringByAppendingString:@"+11111"];
    NSString *copy1Append = [copyStr stringByAppendingString:@"+22222"];
    ZWWLog(@"原字符串拼接后strong1Append地址==%p，strong1Append内容==%@，strongStr地址==%p,内容==%@, self.stringStrong地址==%p，内容==%@",strong1Append,strong1Append, strongStr,strongStr,self.stringStrong,self.stringStrong);
    ZWWLog(@"原字符串拼接后copy1Append地址=%p，copy1Append内容==%@，copy1地址==%p,内容==%@,self.stringCopy地址==%p，内容==%@",copy1Append,copy1Append, copyStr,copyStr,self.stringCopy,self.stringCopy);
    
    
    
    
    //情况2:给属性赋NSMutableString类型的值
    NSMutableString *mStrongStr = [NSMutableString stringWithFormat:@"I am MutableStrong"];
    NSMutableString *mCopyStr = [NSMutableString stringWithFormat:@"I am MutableCopy"];
    self.stringStrong = mStrongStr;
    self.stringCopy = mCopyStr;
    ZWWLog(@"mStrongStr地址==%p, self.stringStrong地址==%p", mStrongStr,self.stringStrong);
    ZWWLog(@"mCopyStr地址==%p,self.stringCopy地址==%p", mCopyStr,self.stringCopy);
    
    
    //两个MutableString进行操作（不返回值）
    [mStrongStr appendString:@"+11111"];
    [mCopyStr appendString:@"+22222"];
    ZWWLog(@"mStrongStr地址==%p,内容==%@, self.stringStrong地址==%p,内容==%@", mStrongStr,mStrongStr,self.stringStrong,self.stringStrong);
    ZWWLog(@"mCopyStr地址==%p,内容==%@,self.stringCopy地址==%p,内容==%@", mCopyStr,mCopyStr,self.stringCopy,self.stringCopy);
    
}



@end
