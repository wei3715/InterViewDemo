//
//  ClassB.h
//  InterviewDemo
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ClassB : NSObject
-(void)methodB;
@end

@protocol ClassBProtocol <NSObject>
-(void)protocolMethodB;
@end
