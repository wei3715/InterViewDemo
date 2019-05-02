//
//  ZWWMasonryTableViewController.m
//  InterviewDemo
//
//  Created by jolly on 2018/10/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWMasonryTableViewController.h"
#import "ZWWMasonrySubViewController.h"


@interface ZWWMasonryTableViewController ()

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *vcArr;
@end

@implementation ZWWMasonryTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@{@"title":@"case1",@"subTitle":@"并排Label"},
                     @{@"title":@"case2",@"subTitle":@"动态居中"},
                     @{@"title":@"case3",@"subTitle":@"百分比宽度"},
                     @{@"title":@"case4",@"subTitle":@"变高tableviewCell"},
                     @{@"title":@"case5",@"subTitle":@"top(bottom)LayoutGuide"},
                     @{@"title":@"case6",@"subTitle":@"自定义baseline"},
                     @{@"title":@"case7",@"subTitle":@"Parallax Header"},
                     @{@"title":@"case8",@"subTitle":@"动态展开UITableViewCell"},
                     @{@"title":@"case9",@"subTitle":@"两种方式实现等间距"},
                     @{@"title":@"case10",@"subTitle":@"用优先级保证内容可见"},
                     @{@"title":@"case19",@"subTitle":@"动态隐藏显示View"}
                   
                     ];
    
    self.vcArr = @[@"ZWWCase1MasonryVC",@"ZWWCase2MasonryVC",@"ZWWCase3MasonryVC",@"ZWWCase4MasonryVC",@"ZWWCase5MasonryVC",@"ZWWCase6MasonryVC",@"ZWWCase7MasonryVC",@"ZWWCase8MasonryVC",@"ZWWCase9MasonryVC",@"ZWWCase10MasonryVC",@"ZWWMasonrySubViewController"];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommanCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CommanCellID"];
    }
    cell.textLabel.text = self.dataArr[indexPath.row][@"title"];
    cell.detailTextLabel.text = self.dataArr[indexPath.row][@"subTitle"];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class vcName = NSClassFromString(self.vcArr[indexPath.row]);
    UIViewController *vc = [[vcName alloc]init];
    vc.title = self.dataArr[indexPath.row][@"subTitle"];
     [self.navigationController pushViewController:vc animated:YES];

    
}

@end
