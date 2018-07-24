//
//  ClassA.h
//  InterviewDemo
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassA : NSObject
-(void)methodA;
@end

@protocol ClassAProtocol <NSObject>
-(void)protocolMethodA;
@end
