//
//  UserInfoContext.m
//  userInfo
//
//  Created by mac on 2020/8/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UserInfoContext.h"


@implementation UserInfoContext
@synthesize userInfo;

static UserInfoContext *sharedUserInfoContext = nil;
 
static dispatch_once_t token;

+(UserInfoContext*)sharedUserInfoContext{
    dispatch_once(&token, ^{
        if(sharedUserInfoContext == nil){
            sharedUserInfoContext = [[self alloc] init];
        }
    });
    return sharedUserInfoContext;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if(sharedUserInfoContext == nil){
            sharedUserInfoContext = [super allocWithZone:zone];
        }
    });
    return sharedUserInfoContext;
}

- (instancetype)init{
    self = [super init];
    if(self){
        //实例化这个Models
        sharedUserInfoContext.userInfo = [[UserInfo alloc] init];
    }
    return self;
}

- (id)copy{
    return self;
}

- (id)mutableCopy{
    return self;
}

+(void)clear{
    sharedUserInfoContext = nil;
    token = 0l;
}

@end
