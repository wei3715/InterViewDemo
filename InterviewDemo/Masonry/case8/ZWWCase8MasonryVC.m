//
//  ZWWCase8MasonryVC.m
//  InterviewDemo
//
//  Created by jolly on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ZWWCase8MasonryVC.h"
#import "ZWWCase8Cell.h"
#import "ZWWDataCase8Entity.h"
#import "Common.h"

@interface ZWWCase8MasonryVC () <UITableViewDelegate,UITableViewDataSource,Case8CellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *zwwTableView;
@property (strong, nonatomic) ZWWCase8Cell *templateCell;

@property (nonatomic, strong) NSArray *data;

@end

@implementation ZWWCase8MasonryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _zwwTableView.delegate = self;
    _zwwTableView.dataSource = self;
    [_zwwTableView registerClass:[ZWWCase8Cell class] forCellReuseIdentifier:NSStringFromClass([ZWWCase8Cell class])];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self generateData];
    [_zwwTableView reloadData];
}

#pragma mark - Case8CellDelegate

- (void)case8Cell:(ZWWCase8Cell *)cell switchExpandedStateWithIndexPath:(NSIndexPath *)index {
    // 改变数据
    ZWWDataCase8Entity *case8DataEntity = _data[(NSUInteger) index.row];
    case8DataEntity.expanded = !case8DataEntity.expanded; // 切换展开还是收回
    case8DataEntity.cellHeight = 0; // 重置高度缓存
    
    // **********************************
    // 下面两种方法均可实现高度更新，都尝试下吧
    // **********************************
    
    // 刷新方法1：只会重新计算高度,不会reload cell,所以只是把原来的cell撑大了而已,还是同一个cell实例
    [_zwwTableView beginUpdates];
    [_zwwTableView endUpdates];
    
    // 刷新方法2：先重新计算高度,然后reload,不是原来的cell实例
    //    [_tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
    
    // 让展开/收回的Cell居中，酌情加，看效果决定
    [_zwwTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_templateCell) {
        _templateCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWWCase8Cell class])];
    }
    
    // 获取对应的数据
    ZWWDataCase8Entity *dataEntity = _data[(NSUInteger) indexPath.row];
    
    // 判断高度是否已经计算过
    if (dataEntity.cellHeight <= 0) {
        // 填充数据
        [_templateCell setEntity:dataEntity indexPath:[NSIndexPath indexPathForRow:-1 inSection:-1]]; // 设置-1只是为了方便调试，在log里面可以分辨出哪个cell被调用
        // 根据当前数据，计算Cell的高度，注意+1
        dataEntity.cellHeight = [_templateCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;
        NSLog(@"Calculate height: %ld", (long) indexPath.row);
    } else {
        NSLog(@"Get cache %ld", (long) indexPath.row);
    }
    
    return dataEntity.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZWWCase8Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWWCase8Cell class]) forIndexPath:indexPath];
    [cell setEntity:_data[(NSUInteger) indexPath.row] indexPath:indexPath];
    cell.delegate = self;
    return cell;
}

#pragma mark - Private methods

// 生成数据
- (void)generateData {
    NSMutableArray *tmpData = [NSMutableArray new];
    
    for (int i = 0; i < 20; i++) {
        ZWWDataCase8Entity *dataEntity = [ZWWDataCase8Entity new];
        dataEntity.content = [Common getText:@"case 8 content. " withRepeat:i * 2 + 10];
        [tmpData addObject:dataEntity];
    }
    
    _data = tmpData;
}


@end
