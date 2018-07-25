//
//  TestClass.m
//  InterviewDemo
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TestClass.h"
#import "ClassA.h"
#import "ClassB.h"
#import <objc/runtime.h>

@interface TestClass()<ClassAProtocol,ClassBProtocol>{
    ClassA *a;
    ClassB *b;
}

@end

@implementation TestClass
- (instancetype)init{
   
    ZWWLog(@"TestClass 中的init方法执行 class：%@",[self class]);
    a = [[ClassA alloc]init];
    b = [[ClassB alloc]init];
   
    return [super init];
    
}

//1.通过组合实现多继承
- (void)methodCA{
    [a methodA];
    //下面执行本类操作
    ZWWLog(@"实现本类自定义操作");
}

-(void)methodCB{
    [b methodB];
    //下面执行本类操作
    ZWWLog(@"实现本类自定义操作");
}

//2.通过代理实现多继承基类的接口
- (void)protocolMethodA{
    //下面执行本类操作
    ZWWLog(@"实现本类自定义操作");
    
}

- (void)protocolMethodB{
    //下面执行本类操作
    ZWWLog(@"实现本类自定义操作");
    
}

- (void)printClass:(id <MyPTLDelegate>)obj{
    [obj printClass];
    //下面执行本类操作
    ZWWLog(@"实现本类自定义操作");
}

//4.通过消息转发
//1.动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(methodA)) {
        //通过添加一个c语言的函数来转发方法的实现
        class_addMethod([self class], sel, (IMP)replaceMethodA, "v@:");
    }
    return YES;
}

void replaceMethodA(id self, SEL _cmd){
    ZWWLog(@"未实现的方法通过动态解析转发为一个c语言的函数%s",__func__);
}

//2.直接消息转发
- (id)forwardingTargetForSelector:(SEL)aSelector{
    if ([a respondsToSelector:aSelector]) {
        return a;
    } else if([b respondsToSelector:aSelector]) {
        return b;
    }
    return nil;
}

//3.标准消息转发
//转发消息前先对方法重新签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    //尝试自行实现方法签名
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    
    //若无法实现，尝试通过多继承得到的方法实现
    if (!signature) {
        //判断该方法是哪个父类的，并通过其创建方法签名
        if ([a respondsToSelector:aSelector]) {
            signature = [a methodSignatureForSelector:aSelector];
        }else if ([b respondsToSelector:aSelector]){
            signature = [b methodSignatureForSelector:aSelector];
        }
    }
    return signature;
}

//为方法签名后，转发消息
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL sel = [anInvocation selector];
    
    //判断哪个类实现了该方法
    if ([a respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:a];
    } else if ([b respondsToSelector:sel]){
        [anInvocation invokeWithTarget:b];
    }
 
}

//测试主类，多个分类同名方法执行顺序
//load方法执行顺序

+ (void)load{
     ZWWLog();
}

+ (void)initialize
{
     ZWWLog(@"TestClass 中的initialize方法执行 class：%@",[self class]);
}

//普通同名方法执行顺序
- (void)testCategoryFunc{
    ZWWLog(@"执行 TestClass 主类方法");
}


@end
