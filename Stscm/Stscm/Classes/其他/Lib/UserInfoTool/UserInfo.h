//
//  UserInfo.h
//  userInfo
//
//  Created by mac on 2020/8/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RSLoggedAccount;
@interface UserInfo : NSObject<NSCopying>


/**AES加密码*/
//aesKey
@property (nonatomic,strong)NSString * aesKey;
/**当前账套*/
//loggedAccount
/**当前账号账套列表*/
//loggedAccounts
/**登录地点*/
//loginArea
@property (nonatomic,strong)NSString * loginArea;
/**登录模式 0 APP 1 WEB*/
//loginMode
@property (nonatomic,strong)NSNumber * loginMode;
/**登录时间*/
//loginTime
@property (nonatomic,strong)NSNumber * loginTime;
/**登录标识*/
//loginToken
@property (nonatomic,strong)NSString * loginToken;
/**是否设置密码*/
//passwordSet
@property (nonatomic,assign)BOOL passwordSet;
/**用户uid*/
//uid
@property (nonatomic,strong)NSString * uid;
/**用户头像*/
//userHeadImageUrl
@property (nonatomic,strong)NSString * userHeadImageUrl;
/**用户名称*/
//userName
@property (nonatomic,strong)NSString * userName;
/**用户手机*/
//userPhone
@property (nonatomic,strong)NSString * userPhone;
/**是否游客*/
//visitor
@property (nonatomic,assign)BOOL visitor;
//当前账套
@property (nonatomic,strong)RSLoggedAccount * loggedAccount;

@end

NS_ASSUME_NONNULL_END
