//
//  ZWWHomeModel.h
//  InterviewDemo
//
//  Created by jolly on 2022/4/4.
//  Copyright © 2022 mac. All rights reserved.
//

#import "ZWWHomeModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ZWWHomeRowModel
@end


@interface ZWWHomeRowModel : ZWWBaseModel

@property (nonatomic, copy) NSString *rowTitle;

@end

@interface ZWWHomeModel : ZWWBaseModel

@property (nonatomic, copy) NSString *sectionTitle;
@property (nonatomic, strong) NSArray <ZWWHomeRowModel> *rowModelArr;

@end

NS_ASSUME_NONNULL_END
