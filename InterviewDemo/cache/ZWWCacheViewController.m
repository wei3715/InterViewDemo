//
//  ZWWCacheViewController.m
//  InterviewDemo
//
//  Created by Jolly on 2018/10/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWCacheViewController.h"

@interface ZWWCacheViewController ()<NSCacheDelegate>

@property (nonatomic, strong) NSCache  *cache;

@end

@implementation ZWWCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSCache *)cache{
    if (!_cache) {
        _cache = [[NSCache alloc]init];
        //设置成本为5，当存储数据超过总成本数，NSCache会自动回收对象
        _cache.totalCostLimit = 5;
        
        //设置代理，代理方法一般不会用到，一般是进行测试的时候用
        _cache.delegate = self;
    }
    return _cache;
}

//添加缓存
- (IBAction)testNSCache:(id)sender {
    for (int i = 0; i<10; i++) {
        NSString *str = [NSString stringWithFormat:@"存储内容%@",@(i)];
        //设置成本数为1
        [self.cache setObject:str forKey:@(i) cost:1];
        ZWWLog(@"存储数据%@==%@",@(i),str);
    }
}

//检查缓存
- (IBAction)checkCache:(id)sender {
    for (int i = 0; i<10; i++) {
        NSString *str = [self.cache objectForKey:@(i)];
        if (str) {
            ZWWLog(@"取出缓存中存储的数据==%@",str);
        }
    }
}

//清理缓存
- (IBAction)deleteCache:(id)sender {
    [self.cache removeAllObjects];
    ZWWLog(@"清理缓存");
}

//实现代理
#pragma mark - NSCacheDelegate
//即将回收对象的时候进行调用，实现代理方法之前要遵守NSCacheDelegate协议

- (void)cache:(NSCache *)cache willEvictObject:(id)obj{
    ZWWLog(@"回收--%@",obj);
}

@end
