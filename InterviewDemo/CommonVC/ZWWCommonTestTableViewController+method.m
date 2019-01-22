//
//  ZWWCommonTestTableViewController+method.m
//  InterviewDemo
//
//  Created by jolly on 2018/10/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWCommonTestTableViewController+method.h"

@implementation ZWWCommonTestTableViewController (method)
- (void)testRegisterDefaultsFunc{
    
    NSDictionary *colorUser = @{@"color":@"red"};
    [[NSUserDefaults standardUserDefaults]registerDefaults:colorUser];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
//    [[NSUserDefaults standardUserDefaults]setObject:@"blue" forKey:@"color"];
     [[NSUserDefaults standardUserDefaults]setObject:@"purple" forKey:@"color"];
    NSLog(@"取出颜色值==%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"color"]);
}

- (void)testCompare{
    NSString *str1 = @"67.89";
    NSString *str2 = @"172.83";
    //NSOrderedDescending： 参数1>参数2
    if ([(NSNumber *)str1 compare:(NSNumber *)str2] == NSOrderedDescending) {
        NSLog(@"str1  > str2");
    } else {
        NSLog(@"str1 < str2");
    }
}

//测试三元表达式第一个表达式缺省
- (void)testTernaryExpression{
    
    NSString *mood = [self haveMood] ? : @"sad";
    NSLog(@"缺省值是代表直接返回问号表达式的值==%@",mood);
}

- (NSString *)haveMood{
    return @"happy";
}

- (void)testDate{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // HH是24进制，hh是12进制 2018-10-23 10:53:49 :SSS代表毫秒
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
    // formatter.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] autorelease];
    NSString *string = [formatter stringFromDate:nowDate];
    NSLog(@"当前时间==%@", string);
    
    //NSLog(@"时间==%@，=%ld",nowDate,nowDate.timeIntervalSinceNow);
}

- (void)testSeparate{
    NSString *str = @"测试无分割标志d符，是否s可以分割为数组";
    NSArray *messageArr = [str componentsSeparatedByString:@"||"];
    NSLog(@"messageArr[0]==%@,messageArr[1]==%@",[messageArr firstObject],[messageArr lastObject]);
}
@end

