//
//  ZWWTableViewController.m
//  MediaTest
//
//  Created by mac on 2018/5/19.
//  Copyright © 2018年 mac. All rights reserved.
//test

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
#import "TestBlock.h"
#import "AAViewController.h"
#import "ZWWCacheViewController.h"
#import "ZWWTestCopyViewController.h"
#import "ZWWCommonTestTableViewController.h"
#import "ZWWTestXibViewController.h"
#import "ZWWMasonryTableViewController.h"
#import "ZWWLoginViewController.h"
#import "ZWWTestTabEditViewController.h"
@interface ZWWTableViewController ()

@property (nonatomic, strong) NSArray  *sectionTitleArr;
@property (nonatomic, strong) NSArray  *titleArr;


@end

@implementation ZWWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sectionTitleArr = @[@"0.oc实现多继承效果",@"1.属性修饰词",@"2.线程相关",@"3.常见面试小题",@"4.代理",@"5.缓存",@"6.xib测试",@"7.masonry",@"8.UITableView编辑",@"9.测试跳转到设置界面",@"10.杂七杂八"];
    _titleArr = @[@[@"0-0:组合实现多继承",@"0-1:代理实现多继承",@"0-2:类别实现单继承",@"03:消息转发实现多继承"],
                  @[@"1-0:各种类型的深浅copy",@"1-1:Block",@"1-2:weak&strong"],
                  @[@"2-0:信号量",@"2-1:performSelector注意问题"],
                  @[@"3-0:NSArray去重",@"3-1:load,initialize,init对比测试", @"3-2:指针问题",@"3-3:字符常量区"],
                  @[@"4-0:代理className"],
                  @[@"5-0:缓存NSCache"],
                  @[@"6-0:xib测试"],
                  @[@"7-0:masonry测试"],
                  @[@"8-0:UITableView编辑"],
                  @[@"9-0:测试跳转到设置界面"],
                  @[@"10-1:杂七杂八"]
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
    if (indexPath.section == _sectionTitleArr.count-1) {//最后一组
        ZWWCommonTestTableViewController *commonVC = [[ZWWCommonTestTableViewController alloc]init];
        [self.navigationController pushViewController:commonVC animated:YES];
        return;
    }
    
    
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
                    ZWWTestCopyViewController *testCopyVC = [[ZWWTestCopyViewController alloc]init];
                    [self.navigationController pushViewController:testCopyVC animated:YES];
                    break;
                }
                case 1:{//block
                    TestBlock *testBlock = [[TestBlock alloc]init];
                    [testBlock testBlock];
                    break;
                }
                case 2:{//weak&strong修饰的字符串
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
            
            break;
        }
            
            
        case 3:{
            switch (indexPath.row) {
                case 0:{//数组去重
                    [self deleteSame];
                    break;
                }
                case 1:{//多个分类有同名方法，方法执行哪个(执行编译顺序在后面的分类的同名方法)
//                   TestClass *testCls1 = [[TestClass alloc]init];
//                   TestClass *testCls2 = [[TestClass alloc]init];
//                   TestClass *testCls3 = [[TestClass alloc]init];
//                   [testCls1 testCategoryFunc];
                    

                    TestClassSon *testClsSon1 = [[TestClassSon alloc]init];
                    TestClassSon *testClsSon2 = [[TestClassSon alloc]init];
                    TestClassSon *testClsSon3 = [[TestClassSon alloc]init];
                    break;
                }
                case 2:{//指针
                    [self testPointer];
                    break;
                }
                case 3:{//字符常量区
                    [self testOCSting];
                    break;
                }
                    
                default:
                    break;
            }
            break;
        }
            
            
        case 4:{//测试代理的class类型
            AAViewController *aavc = [[AAViewController alloc]init];
            [self.navigationController pushViewController:aavc animated:YES];
            break;
        }
            
        case 5:{//缓存
            ZWWCacheViewController *cacheVC = [[ZWWCacheViewController alloc]init];
            [self.navigationController pushViewController:cacheVC animated:YES];
            break;
        }
        case 6:{//xib
            ZWWTestXibViewController *xibTestVC = [[ZWWTestXibViewController alloc]init];
            [self.navigationController pushViewController:xibTestVC animated:YES];
            break;
        }
        case 7:{//masonry
            ZWWMasonryTableViewController *masonryVC = [[ZWWMasonryTableViewController alloc]init];
            [self.navigationController pushViewController:masonryVC animated:YES];
            break;
        }
        case 8:{//tableview
            ZWWTestTabEditViewController *tabEditVC = [[ZWWTestTabEditViewController alloc]init];
            [self.navigationController pushViewController:tabEditVC animated:YES];
            break;
        }
        case 9:{//跳转到设置界面
//            1、iOS 10以上都是跳转到当前的APP设置页面 iOS 10及以下可以打开特定的设置（wifi，热点，关于本机）页面
// 注：app-Prefs和Prefs有区别，没有iOS 10以下的机子，没办法测试
            NSURL *url = [NSURL URLWithString:@"App-Prefs:root=WIFI"];
//            NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
            // 只打开设置页面
            //    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if (@available(iOS 10.0, *)) {
                // 系统大于10的时候直接打开当前App的设置界面
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
                 //系统小于10 系统的Wi-Fi界面
                [[UIApplication sharedApplication] openURL:url];
            }
            break;
        }
        case 10:{//tableview
            ZWWCommonTestTableViewController *commonVC = [[ZWWCommonTestTableViewController alloc]init];
            [self.navigationController pushViewController:commonVC animated:YES];
            break;
        }
        default:
            break;
    }
}




@end
