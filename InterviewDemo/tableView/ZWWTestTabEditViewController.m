//
//  ZWWTestTabEditViewController.m
//  InterviewDemo
//
//  Created by jolly on 2018/11/28.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWTestTabEditViewController.h"

@interface ZWWTestTabEditViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView  *zwwTabView;
@property (nonatomic, strong) NSArray      *dataArr;
@property (nonatomic, assign) BOOL         isAllSelected;
@end

@implementation ZWWTestTabEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.zwwTabView];
    [self.zwwTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    [self.zwwTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(20, 0, 200, 0));
    }];
    
}

- (UITableView *)zwwTabView{
    if (!_zwwTabView) {
        _zwwTabView = [[UITableView alloc]init];
        _zwwTabView.delegate = self;
        _zwwTabView.dataSource = self;
        _zwwTabView.editing = YES;
        _zwwTabView.allowsMultipleSelectionDuringEditing = YES;
    }
    return _zwwTabView;
}

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@"存取款",@"优惠",@"修改资料",@"登录",@"全选"];
    }
    return _dataArr;
}


#pragma delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self changeCellEditImgWitnIndexPath:indexPath];
    
    if (indexPath.row == self.dataArr.count-1) {//全选
        [self selectAllWitnIndexPath:indexPath];
        
    } else {
        
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataArr.count-1) {//全选
        self.isAllSelected = NO;
        for (int i = 0; i < self.dataArr.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.zwwTabView deselectRowAtIndexPath:indexPath animated:YES];
        }
    } else {
        
    }
}

- (void)changeCellEditImgWitnIndexPath:(NSIndexPath *)indexPath{
    NSArray *subviews = [[self.zwwTabView cellForRowAtIndexPath:indexPath] subviews];
    for (id obj in subviews) {
        if ([obj isKindOfClass:[UIControl class]]) {
            for (id subview in [obj subviews]) {
                if ([subview isKindOfClass:[UIImageView class]]) {
                    [subview setValue:[UIColor redColor] forKey:@"tintColor"];
                    break;
                }
            }
        }
    }
}

- (void)selectAllWitnIndexPath:(NSIndexPath *)indexPath{
    
    self.isAllSelected = YES;
    for (int i = 0; i < self.dataArr.count; i++) {
        [self changeCellEditImgWitnIndexPath:indexPath];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        [self.zwwTabView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

@end
