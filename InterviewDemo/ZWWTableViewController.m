//
//  ZWWTableViewController.m
//  MediaTest
//
//  Created by mac on 2018/5/19.
//  Copyright © 2018年 mac. All rights reserved.
//

//下面导入的文件的+load的方法都会默认执行，不需要主动调用
#import "ZWWTableViewController.h"
#import "ZWWTableViewController+method.h"
#import "TestClass.h"
#import "TestClassSon.h"
#import "TestClass+Method.h"
#import "TestClass+method1.h"
#import "ClassA.h"
#import "ClassB.h"
#import "ZWWTestWeakStongViewController.h"
#import "ZWWTestThreadViewController.h"
@interface ZWWTableViewController ()

@property (nonatomic, strong) NSArray  *sectionTitleArr;
@property (nonatomic, strong) NSArray  *titleArr;


@end

@implementation ZWWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sectionTitleArr = @[@"oc实现多继承效果",@"属性修饰词",@"线程相关",@"常见面试小题"];
    _titleArr = @[@[@"组合实现多继承",@"代理实现多继承",@"类别实现单继承",@"消息转发实现多继承"],
                  @[@"框架类的深浅copy",@"自定义类的深浅copy",@"容器对象的深浅copy",@"Block",@"copy&strong修饰的字符串",@"weak&strong"],
                  @[@"信号量",@"performSelector注意问题"],
                  @[@"NSArray去重",@"主类和多个分类有同名方法执行顺序",@"init和initialize", @"指针问题"]
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
        case 0:{//oc:'多继承
            switch (indexPath.row) {
                case 0:{//通过组合实现"多继承"效果
                    TestClass *testCls = [[TestClass alloc]init];
                    [testCls methodCA];
                    [testCls methodCB];
                    break;
                }
                case 1:{//通过代理实现"多继承"效果
                    TestClass *testCls = [[TestClass alloc]init];
                    ClassA *a = [[ClassA alloc]init];
                    ClassB *b = [[ClassB alloc]init];
                    [testCls printClass:a];
                    [testCls printClass:b];
                    break;
                }
                case 2:{//通过类别实现"单继承"效果
                    TestClass *testCls = [[TestClass alloc]init];
                    testCls.addr = @"类别添加属性";
                    ZWWLog(@"类别添加的变量==%@",testCls.addr);
                    break;
                }
                case 3:{//通过消息转发实现“多继承"效果
                    TestClass *testCls = [[TestClass alloc]init];
                    [testCls performSelector:@selector(methodA) withObject:nil];
                    
                    // 通过类型强转来实现
                    [(ClassA *)testCls methodA];
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
                case 0:{//信号量
                    [self testSignal];
                    break;
                }
                case 1:{//performSelector
                    ZWWTestThreadViewController *testThreadVC = [[ZWWTestThreadViewController alloc]init];
                    [self.navigationController pushViewController:testThreadVC animated:YES];
                    break;
                }
                default:
                    break;
            }
        }
        case 3:{
            switch (indexPath.row) {
                case 0:{//数组去重
                    [self deleteSame];
                    break;
                }
                case 1:{//多个分类有同名方法，方法执行哪个
                   TestClass *testCls = [[TestClass alloc]init];
                   [testCls testCategoryFunc];
                    break;
                }
                case 2:{//多个分类有同名方法，方法执行哪个
//                   TestClass *testCls1 = [[TestClass alloc]init];
//                   TestClass *testCls2 = [[TestClass alloc]init];
//                   TestClass *testCls3 = [[TestClass alloc]init];
//+[TestClass initialize] [Line 131] TestClass 中的initialize方法执行 class：TestClass
//-[TestClass init] [Line 25] TestClass 中的init方法执行 class：TestClass
//-[TestClass init] [Line 25] TestClass 中的init方法执行 class：TestClass
//-[TestClass init] [Line 25] TestClass 中的init方法执行 class：TestClass
                    
                    TestClassSon *testClsSon1 = [[TestClassSon alloc]init];
                    TestClassSon *testClsSon2 = [[TestClassSon alloc]init];
//+[TestClass initialize] [Line 128] TestClass 中的initialize方法执行 class：TestClass
//+[TestClassSon initialize] [Line 19] //如过子类不实现initialize方法，这里调用的还是父类的initialize
//-[TestClassSon init] [Line 25]
//-[TestClass init] [Line 24] TestClass 中的init方法执行 class：TestClassSon
//-[TestClassSon init] [Line 25]
//-[TestClass init] [Line 24] TestClass 中的init方法执行 class：TestClassSon

                    break;
                }
                case 3:{//指针
                    [self testPointer];
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


@end
