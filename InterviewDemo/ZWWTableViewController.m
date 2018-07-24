//
//  ZWWTableViewController.m
//  MediaTest
//
//  Created by mac on 2018/5/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWTableViewController.h"
#import "ZWWTableViewController+method.h"
#import "TestClass.h"
#import "ClassA.h"
#import "ClassB.h"
#import "ZWWTestWeakStongViewController.h"
@interface ZWWTableViewController ()

@property (nonatomic, strong) NSArray  *sectionTitleArr;
@property (nonatomic, strong) NSArray  *titleArr;

@property (nonatomic, strong) NSString  *stringStrong;
@property (nonatomic, copy)   NSString  *stringCopy;

@end

@implementation ZWWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sectionTitleArr = @[@"object-c:'多继承'",@"属性修饰词",@"NSArray去重"];
    _titleArr = @[@[@"代理实现多继承",@"02.内存中保存图片"],
                  @[@"框架类的深浅copy",@"自定义类的深浅copy",@"容器对象的深浅copy",@"Block",@"copy&strong修饰的字符串",@"weak&strong"],
                  @[@"NSArray去重"]
                  ];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"baseCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _sectionTitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_titleArr[section]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell" forIndexPath:indexPath];
    cell.textLabel.text = _titleArr[indexPath.section][indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    titleLB.backgroundColor = [UIColor cyanColor];
    [titleLB setTextAlignment:NSTextAlignmentCenter];
    titleLB.text = _sectionTitleArr[section];
    [titleLB setTextColor:[UIColor blackColor]];
    
    return titleLB;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{//object-c:'多继承
            switch (indexPath.row) {
                case 0:{
                    TestClass *c = [[TestClass alloc]init];
                    ClassA *a = [[ClassA alloc]init];
                    ClassB *b = [[ClassB alloc]init];
                    [c printClass:a];
                    [c printClass:b];
                    break;
                }
                case 1:{//沙盒路径
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:{//属性修饰词
            switch (indexPath.row) {
                case 0:{//Copy，MutableCopy
                    [self TestCopy];
                    break;
                }
                case 1:{//自定义类的深浅拷贝
                    [self TestCopy1];
                    break;
                }
                case 2:{//容器对象的深浅copy
                    [self TestCopy201];
                    break;
                }
                case 3:{//block
                    
                    break;
                }
                case 4:{//copy&strong修饰的字符串
                    [self testStrongAndCopyStr];
                    break;
                }
                case 5:{//weak&strong修饰的字符串
                    ZWWTestWeakStongViewController *weakStrongVC = [[ZWWTestWeakStongViewController alloc]init];
                    [self.navigationController pushViewController:weakStrongVC animated:YES];
                    break;
                }
                default:
                    break;
            }

            break;
        }
        case 2:{
            switch (indexPath.row) {
                case 0:{
                    [self deleteSame];
                    break;
                }
                    
                default:
                    break;
            }
        }
        default:
            break;
    }
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
    //结果指针变量地址相同，说明对象地址没有变，只有一份；可以看出，此时无论是strong修饰的字符串还是copy修饰的字符串，都进行了浅Copy.
    
    
    //新创建两个
    NSMutableString *mStrongStr = [NSMutableString stringWithFormat:@"StrongMutable"];
    NSMutableString *mCopyStr = [NSMutableString stringWithFormat:@"CopyMutable"];
    self.stringStrong = mStrongStr;
    self.stringCopy = mCopyStr;
    ZWWLog(@"mStrongStr地址==%p, self.stringStrong地址==%p", mStrongStr,self.stringStrong);
    ZWWLog(@"mCopyStr地址==%p,self.stringCopy地址==%p", mCopyStr,self.stringCopy);
    //分别打印一下四个变量的地址:结果如下:这时就发现了,用strong修饰的字符串依旧进行了浅Copy,而由copy修饰的字符串进行了深Copy,所以mStrongStr与stringStrong指向了同一块内存，而mCopyStr和stringCopy指向的是完全两块不同的内存。
    
    
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
    ZWWLog(@"strong1地址==%p, self.stringStrong地址==%p", strong1,self.stringStrong);
    ZWWLog(@"copy1地址==%p,self.stringCopy地址==%p", copy1,self.stringCopy);
    //分别对在字符串后面进行拼接，当然这个拼接对原字符串没有任何的影响，因为不可变自字符串调用的方法都是有返回值的，原来的值是不会发生变化的.打印如下，对结果没有任何的影响:
    
    
//     再来看一下结果:对mutableStrong进行的操作，由于用strong修饰的stringStrong没有进行深Copy，导致共用了一块内存，当mutableStrong对内存进行了操作的时候，实际上对stringStrong也进行了操作;   相反，用copy修饰的stringCopy进行了深Copy，也就是说stringCopy与mutableCopy用了两块完全不同的内存，所以不管mutableCopy进行了怎么样的变化，原来的stringCopy都不会发生变化.这就在日常中避免了出现一些不可预计的错误。
    //新创建两个NSMutableString对象
    NSMutableString * mutableStrong = [NSMutableString stringWithString:@"StrongMutable"];
    NSMutableString * mutableCopy = [NSMutableString stringWithString:@"CopyMutable"];
    
    //初始化两个字符串
    self.stringStrong = mutableStrong;
    self.stringCopy = mutableCopy;
    
    //两个MutableString进行操作
    [mutableStrong appendString:@"Strong!"];
    [mutableCopy appendString:@"Copy!"];
    ZWWLog(@"mutableStrong地址==%p, self.stringStrong地址==%p", mutableStrong,self.stringStrong);
    ZWWLog(@"mutableCopy地址==%p,self.stringCopy地址==%p", mutableCopy,self.stringCopy);
    
//    这样看来，在不可变对象之间进行转换，strong与copy作用是一样的，但是如果在不可变与可变之间进行操作，那么楼主比较推荐copy,这也就是为什么很多地方用copy，而不是strong修饰NSString,NSArray等存在可变不可变之分的类对象了，避免出现意外的数据操作.


}

@end
