//
//  ZWWHomeVC.m
//  InterviewDemo
//
//  Created by jolly on 2022/4/4.
//  Copyright © 2022 mac. All rights reserved.
//

#import "ZWWHomeVC.h"
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
#import "ZWWTestScollviewXib.h"
#import "ZWWHomeModel.h"
#import "ZWWHomeItemModel.h"
#import "ZWWViewLayerVC.h"
//test
@interface ZWWHomeVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray  <ZWWHomeModel *> *dataArr;

@end

@implementation ZWWHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [super viewDidLoad];
    
    self.title = @"探索验证";
    _dataArr = [NSMutableArray new];
    NSArray *sectionTitleArr = @[@"oc实现多继承效果",@"属性修饰词",@"线程相关",@"常见面试小题",@"代理",@"缓存",@"xib测试",@"masonry",@"UITableView编辑",@"测试跳转到设置界面",@"测试scrollview 的xib适配",@"RunLoop",@"定时器",@"杂七杂八"];
    NSArray *rowArr = @[
        @[@{@"title":@"组合实现多继",@"pushVCName":@""},@{@"title":@"组合实现多继",@"pushVCName":@""},@{@"title":@"组合实现多继",@"pushVCName":@""},@{@"title":@"组合实现多继",@"pushVCName":@""}],
        @[@{@"title":@"各种类型的深浅copy",@"pushVCName":@"ZWWTestCopyViewController"},@{@"title":@"Block",@"pushVCName":@""},@{@"title":@"weak&strong",@"pushVCName":@"ZWWTestWeakStongViewController"}],
        @[@{@"title":@"信号量",@"pushVCName":@""},@{@"title":@"performSelector注意问题",@"pushVCName":@"ZWWTestThreadViewController"}],
        @[@{@"title":@"UIView&CALayer",@"pushVCName":@"ZWWViewLayerVC"},@{@"title":@"NSArray去重",@"pushVCName":@""},@{@"title":@"load,initialize,init对比测试",@"pushVCName":@""},@{@"title":@"指针问题",@"pushVCName":@""},@{@"title":@"字符常量区",@"pushVCName":@""}],
        @[@{@"title":@"代理className",@"pushVCName":@"AAViewController"}],
        @[@{@"title":@"缓存NSCache",@"pushVCName":@"ZWWCacheViewController"}],
        @[@{@"title":@"xib测试",@"pushVCName":@"ZWWTestXibViewController"}],
        @[@{@"title":@"masonry测试",@"pushVCName":@"ZWWMasonryTableViewController"}],
        @[@{@"title":@"UITableView编辑",@"pushVCName":@"ZWWTestTabEditViewController"}],
        @[@{@"title":@"测试跳转到设置界面",@"pushVCName":@""}],
        @[@{@"title":@"scrollview 的xib适配",@"pushVCName":@"ZWWTestScollviewXib"}],
        @[@{@"title":@"NSTimer创建",@"pushVCName":@"ZWWTimerViewController"},@{@"title":@"obsver",@"pushVCName":@"ZWWObserverViewController"},@{@"title":@"runLoop使用案例",@"pushVCName":@""}],
        @[@{@"title":@"定时器",@"pushVCName":@""}],
        @[@{@"title":@"杂七杂八",@"pushVCName":@"ZWWCommonTestTableViewController"}]
    ];
    
    NSMutableArray *tempDataArr = [NSMutableArray new];
    for (NSInteger i = 0; i<sectionTitleArr.count; i++) {
        NSString *str = sectionTitleArr[i];
        
        ZWWHomeModel *sectionModel = [[ZWWHomeModel alloc]init];
        sectionModel.sectionTitle = str;
        
        NSMutableArray *rowMArr = [NSMutableArray new];
        NSArray *rowTempArr = rowArr[i];
        for (NSDictionary *dic in rowTempArr) {
            
            ZWWHomeItemModel *rowModel = [ZWWHomeItemModel modelWithTitle:dic[@"title"] pushVCName:dic[@"pushVCName"]];
            [rowMArr addObject:rowModel];
            sectionModel.rowModelArr = [rowMArr mutableCopy];
        }
        [tempDataArr addObject:sectionModel];
    }
    _dataArr = [tempDataArr mutableCopy];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"baseCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZWWHomeModel *model = _dataArr[section];
    return model.rowModelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell" forIndexPath:indexPath];
    ZWWHomeModel *model = _dataArr[indexPath.section];
    ZWWHomeItemModel *rowModel = model.rowModelArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd-%zd:%@",indexPath.section,indexPath.row,rowModel.title];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    titleLB.backgroundColor = [UIColor cyanColor];
    [titleLB setTextAlignment:NSTextAlignmentCenter];
    
    ZWWHomeModel *sectionModel = _dataArr[section];
    titleLB.text = [NSString stringWithFormat:@"%zd-%@",section,sectionModel.sectionTitle];
    [titleLB setTextColor:[UIColor blackColor]];
    
    return titleLB;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWWHomeModel *model = _dataArr[indexPath.section];
    ZWWHomeItemModel *itemModel = model.rowModelArr[indexPath.row];
    NSString *vcName = itemModel.pushVCName;
    
    Class class = NSClassFromString(vcName);
    UIViewController *vc = [[class alloc] init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
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
//                        [self testSignal];
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
//                        [self deleteSame];
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
//                        [self testPointer];
                        break;
                    }
                    case 3:{//字符常量区
//                        [self testOCSting];
                        break;
                    }
                        
                    default:
                        break;
                }
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
            default:
                break;
        }
    }
}

@end
