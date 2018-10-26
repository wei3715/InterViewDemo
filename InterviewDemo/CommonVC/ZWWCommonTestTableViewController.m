//
//  ZWWCommonTestTableViewController.m
//  InterviewDemo
//
//  Created by Jolly on 2018/10/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWCommonTestTableViewController.h"
#import "ZWWTestDelegateView.h"
#import "ZWWCommonTestTableViewController+method.h"
@interface ZWWCommonTestTableViewController ()

@property (nonatomic, strong) NSArray  *sectionTitleArr;
@property (nonatomic, strong) NSArray  *titleArr;

@end

@implementation ZWWCommonTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sectionTitleArr = @[@"常见小问题测试",@"待扩展"];
    _titleArr = @[@[@"compare结果",@"三元表达式第一个表达式缺省",@"测试自定义View 的init&initWithFrame先后顺序",@"测试registerDefaults",@"测试日期格式"],
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
                case 3:{
                    [self testRegisterDefaultsFunc];
                    break;
                }
                case 4:{
                    [self testDate];
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


@end
