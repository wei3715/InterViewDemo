//
//  ZWWTestWeakStongVC.m
//  InterviewDemo
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWTestWeakStongVC.h"
#import "Person.h"
#import "ZWWCustomView.h"

@interface ZWWTestWeakStongVC ()

@property (nonatomic, strong) ZWWCustomView *customView;

@end

@implementation ZWWTestWeakStongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testWeakAndStrong];
    [self creatUI];
}

//验证使用weak的作用
- (void)creatUI{
    ZWWCustomView *customView = [[ZWWCustomView alloc]init];
    ZWWLog(@"1: retainCount=%ld",CFGetRetainCount((__bridge CFTypeRef)customView));
    customView.frame=CGRectMake(50, 100, 200, 200);
    customView.backgroundColor=[UIColor redColor];
    
    UILabel *msgLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    msgLabel.text=@"这是一个视图";
    [customView addSubview:msgLabel];
    
    //添加到视图
    //此时已经有一个self.view这个强指针指向该内存对象
    [self.view addSubview:customView];
    ZWWLog(@"2: retainCount=%ld",CFGetRetainCount((__bridge CFTypeRef)customView));
    //retainCount=2
    
    //添加一个指针指向该内存
    self.customView = customView;
    ZWWLog(@"2(3): retainCount=%ld",CFGetRetainCount((__bridge CFTypeRef)customView));
    //retainCount = 2,strong修饰时retainCount=3
    
    //添加按钮
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 80)];
    [btn setTitle:@"移除子视图" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

//weak&strong
//赋值给weak变量后这块内存会马上被释放；而分配给strong变量的会等到这个变量的生命周期结束后，这块内存才被释放(不用关键字weak修饰的变量默认为strong变量)。
- (void)testWeakAndStrong{
    //weak
    __weak Person *zhangSan = [[Person alloc]init];
    zhangSan.name = @"张三";
    
    //strong
    Person *liSi = [[Person alloc]init];
    liSi.name = @"李四";
    
    //无法打印weak修饰的zhangSan的reatainCount
    ZWWLog(@"weak对象内存地址==%p,strong对象内存地址==%p,retainCount=%ld",zhangSan, liSi,CFGetRetainCount((__bridge CFTypeRef)liSi));
    ZWWLog(@"weak对象属性值地址==%@,strong对象属性值地址==%@",zhangSan.name,liSi.name);
    
    __weak Person *wangWu;
    [self testWeakAndStrong1WithPerson:wangWu];
    
    //这时候 person这块内存只有一个weak指针wangWu，strong指针sunLiu已经失效
    ZWWLog(@"weak对象属内存地址==%@,weak对象属性值地址==%@",wangWu,wangWu.name);
    
    //测试常量区
//    NSString *str1 = @"222";
//    ZWWLog(@"常量区的变量值果然不可以改变%@ %p retainCount=%ld",str1,str1, CFGetRetainCount((__bridge CFTypeRef)str1));
//    str1 = @"333";
//    ZWWLog(@"常量区的变量值果然不可以改变%@ %p,retainCount=%ld",str1,str1,CFGetRetainCount((__bridge CFTypeRef)str1));
}
// weak对象内存地址==0x0,strong对象内存地址==0x604000012910
// weak对象属性值地址==(null),strong对象属性值地址==李四
// weak对象属内存地址==(null),weak对象属性值地址==(null)


- (void)testWeakAndStrong1WithPerson:(Person *)p{
    //strong：sunLiu只在该函数内有效
    Person *sunLiu = [[Person alloc]init];
    sunLiu.name = @"孙六";
    
    /*先将分配好的内存赋值给一个strong变量,然后再将这个strong变量赋值给一个weak变量，这样两个Person的地址都一样，显然name属性也一样.这样就好比先用结实的绳子拴住牛，这样牛就不会跑了，然后再用一根弱小的绳子拴住这头牛，这样顺着这根弱小的绳子也能找到这头牛。很明显如果当我们把结实的绳子弄断时，弱小的绳子自然也拉不住这头牛了*/
    p = sunLiu;
    
    //此时：person这块内存有一个strong指针sunLiu，和一个weak指针wangWu
    ZWWLog(@"weak对象内存地址==%p,strong对象内存地址==%p",p,sunLiu);
    ZWWLog(@"weak对象属性值地址==%@,strong对象属性值地址==%@",p.name,sunLiu.name);
}
// weak对象内存地址==0x60c0000110f0,strong对象内存地址==0x60c0000110f0
// weak对象属性值地址==孙六,strong对象属性值地址==孙六


//那么用weak修饰变量还有什么作用呢？
/*我想要的效果是：点击按钮移除子视图，并且程序以后的运行永远也不会用到这个view。这里我想到有两种方式拿到这个view，然后从父控件中移除它：
第一种：这种方式显然能实现这样的要求，我们能看到打印结果，在子视图被移除父控制器之后对象也被销毁了。然而这不是我们最常用的方式，有可能父控件上有很多子视图，这样效率很低，而且代码不简洁。
第二种：我们给控制器增加一个属性，指向我们的子视图。这个属性有两种可能，一种是strong，一种是weak。我们先来试试strong。*/
-(void)btnClick{
    ZWWLog(@"3: retainCount=%ld,当前线程==%@",CFGetRetainCount((__bridge CFTypeRef)self.customView),[NSThread currentThread]);
    
    //第一种方式
//    for (UIView *subView in self.view.subviews) {
//        if ([subView isKindOfClass:[ZWWCustomView class]]) {
//            [subView removeFromSuperview];
//        }
//    }
    
     //第二种方式：
    //这个时候self.view这个强指针断掉
    [self.customView removeFromSuperview];
    
    ZWWLog(@"点击了移除子视图按钮");
    ZWWLog(@"retainCount=%ld",CFGetRetainCount((__bridge CFTypeRef)self.customView));
}
//strong修饰时：没有打印对象被销毁，weak修饰时：打印了对象被销毁
//为什么我们没有添加strong属性的时候分配出来的内存没有被释放，仍然能通过for循环找到它？需要注意的是：当一个视图A被添加到另一个视图B时，A就被B的subViews强引用了（有一个结实的绳子拉着它了），所以我们再用一个强属性去拉着它的话，自然要两条绳子都断了，它才会被释放。

- (void)testBlockWeakStrong{
    int a = 5;
    void(^ablock)(int a) = ^(int a){
        NSLog(@"a==%d",a);
    };
    ablock(4);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
