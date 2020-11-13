//
//  RSUserInfoTool.h
//  Stscm
//
//  Created by mac on 2020/9/3.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"


#import "RSLoggedAccount.h"
#import "RSCurrentRole.h"
#import "RSLoggedAccountsMode.h"


NS_ASSUME_NONNULL_BEGIN

@interface RSUserInfoTool : NSObject
/**用户信息的结构*/
+ (void)initWithUserToolUserInfo:(UserInfo *)userInfo ResponseObject:(id)responseObject;

@end

NS_ASSUME_NONNULL_END
