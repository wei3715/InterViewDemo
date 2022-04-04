//
//  ZWWMainTabVC.m
//  InterviewDemo
//
//  Created by jolly on 2022/4/4.
//  Copyright © 2022 mac. All rights reserved.
//

#import "ZWWMainTabVC.h"
#import "ZWWHomeVC.h"

@interface ZWWMainTabVC ()<UITabBarDelegate, UITabBarControllerDelegate>

@property(nonatomic,strong)NSArray *titleArr;

@end

@implementation ZWWMainTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    self.tabBarController.tabBar.delegate = self;
    self.titleArr = @[@"首页",@"优惠",@"风采",@"我的"];
    // 初始化子控制器
    [self addChildViewControllers];
    //设置tabBarItem文字大小和颜色
      self.tabBar.tintColor = kRGB(223,65,51);
    //    childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3,0);
    [[UITabBarItem appearance]  setTitleTextAttributes:@{NSForegroundColorAttributeName:kRGB(102,102,102),NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    [[UITabBarItem appearance]  setTitleTextAttributes:@{NSForegroundColorAttributeName:kRGB(223,65,51),NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
    
}

- (void)addChildViewControllers{
    ZWWHomeVC *homeVC = [ZWWHomeVC new];
//    DiscountsViewController *discountsVC = [DiscountsViewController new];
//    PresenceViewController *presenceVC = [PresenceViewController new];
//    ETMineViewController *mineVC = [ETMineViewController new];

    [self addChildVc:homeVC title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_s"];
//    [self addChildVc:discountsVC title:@"优惠" image:@"tabbar_discounts_usdt" selectedImage:@"tabbar_discounts_usdt_s"];
//    [self addChildVc:presenceVC title:@"风采" image:@"tabbar_presence" selectedImage:@"tabbar_presence_s"];
//    [self addChildVc:mineVC title:@"我的" image:@"tabbar_mine" selectedImage:@"tabbar_mine_s"];
    
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置子控制器的文字
    childVc.title = title;
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    // 先给外面传进来的小控制器 包装 一个导航控制器
    ZWWBaseNaviViewController *nav = [[ZWWBaseNaviViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

//判断是否跳转
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"%ld",self.selectedIndex);
}

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

@end
