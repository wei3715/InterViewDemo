//
//  AAViewController.h
//  InterviewDemo
//
//  Created by Jolly on 2018/10/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//委托方-定义代理协议
@protocol AAVCDelagate <NSObject>

- (void)iNeedYouHelpMeDoSomethingWithStr:(NSString *)str;

@end

@interface AAViewController : UIViewController

//遵循协议的一个代理变量定义
@property (nonatomic, weak)id <AAVCDelagate> delegate;

@end

