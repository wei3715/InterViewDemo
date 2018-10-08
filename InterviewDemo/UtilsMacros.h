//
//  UtilsMacros.h
//  MediaTest
//
//  Created by mac on 2018/5/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

#ifdef DEBUG
#define ZWWLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define ZWWLog(...)
#endif


#define kWeakSelf(type)     __weak typeof(type) weak##type = type;
#define KScreenWidth        [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight       [[UIScreen mainScreen] bounds].size.height
#define KLocalMP4Url        @"http://cloud.video.taobao.com/play/u/2712925557/p/1/e/6/t/1/40050769.mp4"

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}
#endif /* UtilsMacros_h */
