//
//  ZWWMasonryTableViewController.m
//  InterviewDemo
//
//  Created by jolly on 2018/10/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWMasonryTableViewController.h"
#import "ZWWMasonrySubViewController.h"
#import "ZWWTestTabViewCellViewController.h"
@interface ZWWMasonryTableViewController ()

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ZWWMasonryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"动态隐藏显示View",@"变高tableviewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CommanCellID"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommanCellID" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZWWMasonrySubViewController *masonrySubVC = [[ZWWMasonrySubViewController alloc] initWithNibName:@"ZWWMasonrySubViewController" bundle:nil];
        [self.navigationController pushViewController:masonrySubVC animated:YES];
    } else if (indexPath.row == 1){
        ZWWTestTabViewCellViewController *testTabCellVC = [[ZWWTestTabViewCellViewController alloc] init];
        [self.navigationController pushViewController:testTabCellVC animated:YES];
    }
    
}

@end
