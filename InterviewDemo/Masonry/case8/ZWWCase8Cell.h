//
//  ZWWCase8Cell.h
//  InterviewDemo
//
//  Created by jolly on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ZWWDataCase8Entity;
@class ZWWCase8Cell;

@protocol Case8CellDelegate <NSObject>
- (void)case8Cell:(ZWWCase8Cell *)cell switchExpandedStateWithIndexPath:(NSIndexPath *)index;
@end

@interface ZWWCase8Cell : UITableViewCell
@property (weak, nonatomic) id <Case8CellDelegate> delegate;

- (void)setEntity:(ZWWDataCase8Entity *)entity indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
