//
//  UserInfoContext.h
//  userInfo
//
//  Created by mac on 2020/8/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserInfoContext : NSObject

@property(nonatomic,strong) UserInfo *userInfo;


+(UserInfoContext*)sharedUserInfoContext;

+(void)clear;

@end


NS_ASSUME_NONNULL_END
