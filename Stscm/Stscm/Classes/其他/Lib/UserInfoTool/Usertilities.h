//
//  Usertilities.h
//  Stscm
//
//  Created by mac on 2020/8/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Usertilities : NSObject
//单例-> NSUserDefaults
+(void)SetNSUserDefaults:(UserInfo *)userInfo;
//NSUserDefaults-> 单例
+(UserInfo *)GetNSUserDefaults;

+ (void)clearLocalUserModel;
@end

NS_ASSUME_NONNULL_END
