//
//  ZWWCacheViewController.m
//  InterviewDemo
//
//  Created by Jolly on 2018/10/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWCacheViewController.h"
#import <YYKit.h>
#import "UserManager.h"
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

//1 存：存入内存的同时写入磁盘
//2 读：1）先从内存读，有就直接拿来用；
//     2）没有再从磁盘读，有就拿来用，顺便存到内存；
//     3）还没有就返回空。

//1 总缓存（包括磁盘和内存）
- (IBAction)cacheData:(id)sender {
    
    //1.建个小数据表
    YYCache *cache = [YYCache cacheWithName:@"zwwData"];
    //2.存
    [cache setObject:@"小明" forKey:@"name"];
    
    //3.检查读取（直接读取，不存在则则是nil）
    if ([cache containsObjectForKey:@"name"]) {
        NSString *name = (NSString *)[cache objectForKey:@"name"];
        ZWWLog(@"总缓存内容==%@",name);
    }
    
    //删
    [cache removeObjectForKey:@"name"];
    [cache removeAllObjects];

}

//只要内存或只要磁盘存储
- (IBAction)cacheOneTypeData:(id)sender {
    YYCache *cache  = [YYCache cacheWithName:@"zwwData"];
    YYDiskCache *disCache = cache.diskCache;
    
    YYMemoryCache *memeoryCache = cache.memoryCache;
    //diskCache memoryCache 与cache 存取方法一致！
    
    //磁盘存
    [disCache setObject:@"zww" forKey:@"name"];
    
    //内存存
    [memeoryCache setObject:@"180" forKey:@"height"];
    
    //检查读取（直接读取，不存在则w是nil）
    if ([disCache containsObjectForKey:@"name"]) {
        NSString *name = (NSString *)[cache objectForKey:@"name"];
        ZWWLog(@"磁盘读取数据==%@",name);
    }
    
    if ([memeoryCache containsObjectForKey:@"height"]) {
        NSString *height = (NSString *)[cache objectForKey:@"height"];
        ZWWLog(@"内存读取数据==%@",height);
    }
    
    //磁盘删
    [disCache removeObjectForKey:@"name"];
    [disCache removeAllObjects];
    
    //内存删缓存
    [memeoryCache removeObjectForKey:@"height"];
    [memeoryCache removeAllObjects];
}

//实际使用
- (IBAction)useYYCache:(id)sender {
    
    //使用
    NSDictionary *userInfo = @{@"name":@"张三",
                               @"gender":@"男",
                               @"age":@"18"};
    
    [[UserManager sharedUserManager] updateUserInfo:userInfo];
    
    ZWWLog(@"%@",[UserManager sharedUserManager].userModel.name);
    ZWWLog(@"%@",[UserManager sharedUserManager].userModel.gender);
    ZWWLog(@"%zi",[UserManager sharedUserManager].userModel.age);
}


- (IBAction)printBundlePath:(id)sender {
    NSString *bundlePath = [NSBundle mainBundle];
    ZWWLog(@"[NSBundle mainBundle]的路径===%@",bundlePath);
}
- (IBAction)printSanboxPath:(id)sender {
    NSString *path = NSHomeDirectory();//主目录
    NSLog(@"NSHomeDirectory的路径=====%@",path);
    NSString *userName = NSUserName();//与上面相同
    NSString *rootPath = NSHomeDirectoryForUser(userName);
    NSLog(@"NSHomeDirectoryForUser的路径====%@",rootPath);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
    NSLog(@"NSDocumentDirectory的路径===%@",documentsDirectory);
}

@end
