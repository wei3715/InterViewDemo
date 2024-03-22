//
//  TestBlock.m
//  InterviewDemo
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 mac. All rights reserved.
//
/*
 block声明:
 void(^block)(int a,int b)
 返回值类型-block名称-参数列表
 returentype (^blockName)(parammeterType)
 block定义:
 void(^block)(int a,int b)= ^(int a,int b){do something};
 返回值（void的话可省略）block名称-参数列表
 returntype(^blockName)(parametTypes)=^returntype(parammeters){};
 使用场景：
 1.做为本地变量
 returntype(^blockName)(parametTypes)=^returntype(parammeters){
 ......
 };
 2.做为property
 @property (nonatomic, copy)returentype (^blockName)(parammeterTypes);
 3.做为方法的参数
 -(void)doWithBlock(returntype(^)(parammeterType))blockName;
 4.做为方法参数被调用时
 [someObject doWithBlock:^returntype(parammeters){
 ......
 }];
 5.typedef声明block
 typedef returntype(^blockName)(parammeterTypes);
 blockName blockname = ^returntype(parammeters){
 ...
 };
 @property (nonatomic, copy) blockName blockname;

 
 */

#import "TestBlock.h"
typedef void(^Ablock)(id testData);
typedef void(^Bblock)(id data, Ablock testBlock);

@interface TestBlock()

@property (nonatomic, copy) Bblock byBlock;

@end

@implementation TestBlock

//void (^GlobalBlock)(void(^)(void)) = ^{
//     NSLog(@"外层全局Block：_NSConcreteGlobalBlock");
//    void(^insideGlobalBlock)(void)=^{
//         NSLog(@"内层全局Block：_NSConcreteGlobalBlock");
//    };
//
//};


- (void)testBlock{
//    GlobalBlock();
    
    int val = 10;
    int *p = &val;
    NSLog(@"block外 指针值=%p,参数地址==%p",p,&val);
    
    void(^StackBlock)(int *p) = ^(int *p){
        //通过指针改变局部变量的值（指针传递，访问的是同一块内存，所以可以改变val的值）
        //如果直接通过变量名访问，是值传递，只是block外val的一个副本，所以改变不会影响原来val的值
        NSLog(@"指针值=%p,参数地址==%p",p,&val);
        //打印：指针值=0x7ffee2784a4c,参数地址==0x600001267aa0
        //这里&val地址和外部变量val的地址不同，所以可以证明block内部访问的局部变量是局部变量的副本而非原来的局部变量
        
        
        
        (*p)=(*p)+1; //*p = 12,外部val = 12
        NSLog(@"block内改变后值*p==%d，val==%d",*p,val);
        
        //打印结果：block内改变后值*p==12，val==10
        //证明：*p内外部一直访问的是同一块内存，参数是指针传递，val变量名访问block内部外部不是一个变量
    };
    
    val++;  //*p = 11,val = 11
    StackBlock(p);
    NSLog(@"block外改变后值==%d",val); //val = 12
    
    //嵌套block
    [self testActionWithBlock:^(id data, Ablock testBlock) {
        NSLog(@"第一层block参数==%@",data);
        if (testBlock) {
            testBlock(@"第二层block");
        }
    }];
}


- (void)testActionWithBlock:(Bblock)block{
    NSLog(@"测试block嵌套调用");
    _byBlock = block;
    
    NSString *striData = @"BlockTestB say hello to VC";
    _byBlock(striData, ^(id testData){
        NSLog(@"BlockTestB get response from VC: %@",testData);
    });
}


//测试block访问外部变量
//C语言中变量一般可以分为一下5种：
//自动变量
//函数参数 （block中不用考虑）
//静态变量
//静态全局变量
//全局变量

//全局变量
int global_i = 1;

//静态全局变量
static int static_global_j = 2;

- (void)testBlockArg {
    //静态变量
    static int static_k = 3;
    //自动变量
    int val = 4;
    
    void (^myBlock)(void) = ^{
        global_i ++;
        static_global_j ++;
        static_k ++;
        NSLog(@"Block中 global_i = %d,static_global_j = %d,static_k = %d,val = %d",global_i,static_global_j,static_k,val);
    };
    
    global_i ++;
    static_global_j ++;
    static_k ++;
    val ++;
    NSLog(@"Block外 global_i = %d,static_global_j = %d,static_k = %d,val = %d",global_i,static_global_j,static_k,val);
    
    myBlock();
}

//所以：想让block内部可以改变外部变量的值，方法有两种
//1:传递变量地址（变量指针）
//2.添加__block修饰变量，修改变量的作用域
- (void)testBlock1{
    
    NSMutableString * str = [[NSMutableString alloc]initWithString:@"Hello,"];
    void(^block)(void) = ^(void){
        [str appendString:@"World!"];
    };
    
    block();
}
@end
