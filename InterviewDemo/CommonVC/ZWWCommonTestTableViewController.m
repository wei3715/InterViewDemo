//
//  ZWWCommonTestTableViewController.m
//  InterviewDemo
//
//  Created by Jolly on 2018/10/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWCommonTestTableViewController.h"
#import "ZWWTestDelegateView.h"
@interface ZWWCommonTestTableViewController ()

@property (nonatomic, strong) NSArray  *sectionTitleArr;
@property (nonatomic, strong) NSArray  *titleArr;

@end

@implementation ZWWCommonTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sectionTitleArr = @[@"常见小问题测试",@"待扩展"];
    _titleArr = @[@[@"compare结果",@"三元表达式第一个表达式缺省",@"测试自定义View 的init&initWithFrame先后顺序"],
                  @[@"待扩展"]
                  ];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"commonCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return _sectionTitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleArr[section]count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commonCell" forIndexPath:indexPath];
    cell.textLabel.text = _titleArr[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    [self testCompare];
                    break;
                }
                case 1:{
                    [self testTernaryExpression];
                    break;
                }
                case 2:{
                    //initWithFrame-->init
                    ZWWTestDelegateView *customView0 = [[ZWWTestDelegateView alloc]init];
                    
                    //initWithFrame
                    ZWWTestDelegateView *customView1 = [[ZWWTestDelegateView alloc]initWithFrame:CGRectZero];
                    break;
                }
                    
                default:
                    break;
            }
        }
            
            break;
            
        default:
            break;
    }
}

- (void)testCompare{
    NSString *str1 = @"2.1.0";
    NSString *str2 = @"2.1.1";
    //NSOrderedDescending： 参数1>参数2
    if ([str1 compare:str2] == NSOrderedDescending) {
        NSLog(@"str1  > str2");
    } else {
        NSLog(@"str1 < str2");
    }
}

//测试三元表达式第一个表达式缺省
- (void)testTernaryExpression{

    NSString *mood = [self haveMood] ? : @"sad";
    NSLog(@"缺省值是代表直接返回问号表达式的值==%@",mood);
}

- (NSString *)haveMood{
    return @"happy";
}
@end
