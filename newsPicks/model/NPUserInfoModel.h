//
//  NPUserInfoModel.h
//  newsPicks
//
//  Created by kangxv on 14-8-16.
//  Copyright (c) 2014年 kangxv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPUserInfoModel : NSObject

@property(nonatomic,retain)NSString *uid;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *typeName;
@property(nonatomic,retain)NSString *description;

@property(nonatomic,retain)NSString *company;
@property(nonatomic,retain)NSString *family;
@property(nonatomic,retain)NSString *given;
@property(nonatomic,retain)NSString *position;
@property(nonatomic,retain)NSString *userimage;



@end
