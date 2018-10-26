//
//  ZWWBaseNaviViewController.m
//  InterviewDemo
//
//  Created by jolly on 2018/10/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWBaseNaviViewController.h"

@interface ZWWBaseNaviViewController ()<UINavigationBarDelegate,UIGestureRecognizerDelegate>

@end

@implementation ZWWBaseNaviViewController

+(void)initialize{
    
    //设置背景色
    UINavigationBar *naviBar = [UINavigationBar appearance];
    [naviBar setBarTintColor:[UIColor redColor]];
    
    //设置导航栏字体色
    NSMutableDictionary  *mDic = [NSMutableDictionary new];
    mDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    mDic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     //设置手势代理
    self.interactivePopGestureRecognizer.delegate = self;
    
}

//手势代理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return self.topViewController.preferredStatusBarUpdateAnimation;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}

- (NSArray*)popToRootViewControllerAnimated:(BOOL)animated {
    return [super popToRootViewControllerAnimated:animated];
}

/**
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated
{
    id vc = [self getCurrentViewControllerClass:ClassName];
    if(vc != nil && [vc isKindOfClass:[UIViewController class]])
    {
        [self popToViewController:vc animated:animated];
        return YES;
    }
    
    return NO;
}

/*!
 *  获得当前导航器显示的视图
 *
 *  @param ClassName 要获取的视图的名称
 *
 *  @return 成功返回对应的对象，失败返回nil;
 */
-(instancetype)getCurrentViewControllerClass:(NSString *)ClassName
{
    Class classObj = NSClassFromString(ClassName);
    
    NSArray * szArray =  self.viewControllers;
    for (id vc in szArray) {
        if([vc isMemberOfClass:classObj])
        {
            return vc;
        }
    }
    
    return nil;
}


/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置导航栏按钮
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
        [button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    [super pushViewController:viewController animated:animated];
}



#pragma mark ————— 屏幕旋转 —————
- (BOOL)shouldAutorotate
{
    //也可以用topViewController判断VC是否需要旋转
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //也可以用topViewController判断VC支持的方向
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}


//自定义方法
- (void)back{
    [self popViewControllerAnimated:YES];
}
@end
