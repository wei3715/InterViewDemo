//
//  ZWWTestTabViewCellViewController.m
//  InterviewDemo
//
//  Created by jolly on 2018/10/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWTestTabViewCellViewController.h"
#import "ZWWCell.h"
#import "zwwDataEntity.h"
#import "Common.h"
@interface ZWWTestTabViewCellViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView        *zwwTableView;
@property (nonatomic, strong) ZWWCell            *zwwTempCell;
@property (nonatomic, strong) NSArray            *dataArr;


@end

@implementation ZWWTestTabViewCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _zwwTableView = [UITableView new];
    [self.view addSubview:_zwwTableView];
    [_zwwTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    _zwwTableView.delegate = self;
    _zwwTableView.dataSource = self;
    _zwwTableView.estimatedRowHeight = 80;
    
   
    
//#ifdef IOS_8_NEW_FEATURE_SELF_SIZING
//    //ios8 的Self-sizing特性
//    if ([UIDevice currentDevice].systemVersion.integerValue > 7) {
//       _zwwTableView.rowHeight = UITableViewAutomaticDimension;
//    }
//#endif
    
    //注册cell
     [_zwwTableView registerClass:[ZWWCell class] forCellReuseIdentifier:NSStringFromClass([ZWWCell class])];

    [self generateData];
    
    [_zwwTableView reloadData];
    
}

#pragma delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//#ifdef IOS_8_NEW_FEATURE_SELF_SIZING
//    // iOS 8 的Self-sizing特性
//    return UITableViewAutomaticDimension;
//#else
    
    if (!_zwwTempCell) {
        _zwwTempCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWWCell class])];
        _zwwTempCell.tag = -1000;
    }
    
    //获取对应的数据
    ZWWDataEntity *dataEntity = _dataArr[indexPath.row];
    
    //判断高度是否已经计算过
    if (dataEntity.cellHeight <= 0 ) {
        //填充数据
        [_zwwTempCell setupData:dataEntity]; // 根据当前数据，计算Cell的高度，注意+1
        dataEntity.cellHeight = [_zwwTempCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;
        NSLog(@"Calculate: %ld, height: %g", (long) indexPath.row, dataEntity.cellHeight);
    } else {
        NSLog(@"Get cache: %ld, height: %g", (long) indexPath.row, dataEntity.cellHeight);
    }
    
    return dataEntity.cellHeight;
//#endif
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWWCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWWCell class]) forIndexPath:indexPath];
    [cell setupData:_dataArr[indexPath.row]];
    return cell;
}

// 生成数据
- (void)generateData {
    NSMutableArray *tmpData = [NSMutableArray new];
    
    for (int i = 0; i < 20; i++) {
        ZWWDataEntity *dataEntity = [ZWWDataEntity new];
        dataEntity.avatar = [UIImage imageNamed:[NSString stringWithFormat:@"bluefaces_%d", (i % 4) + 1]];
        dataEntity.title = [NSString stringWithFormat:@"Title: %d", i];
        dataEntity.content = [Common getText:@"content-" withRepeat:i * 2 + 1];
        [tmpData addObject:dataEntity];
    }
    
    _dataArr = tmpData;
}

@end
