//
//  AAViewController.h
//  InterviewDemo
//
//  Created by Jolly on 2018/10/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AAVCDelagate <NSObject>

- (void)run;

@end

@interface AAViewController : UIViewController

@property (nonatomic, weak)id <AAVCDelagate> delegate;

@end

