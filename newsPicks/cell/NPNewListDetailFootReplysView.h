//
//  NPNewListDetailFootReplysView.h
//  newsPicks
//
//  Created by yunqi on 14-7-23.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NPlistReplyModel;
@protocol NPNewListDetailFootReplysViewDelegate<NSObject>
@optional
-(void)NPNewListDetailFootReplysViewClickUser:(NPlistReplyModel *)reply;
@end
@interface NPNewListDetailFootReplysView : UIView
{
    NSMutableArray *replyList;
}
@property(nonatomic,assign)id<NPNewListDetailFootReplysViewDelegate>delegate;
-(void)restSubView:(NSArray *)list count:(NSString *)count;
@end
