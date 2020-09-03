//
//  RSLoggedAccount.h
//  Stscm
//
//  Created by mac on 2020/8/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RSCurrentRole;
@interface RSLoggedAccount : NSObject<NSCopying>
//账套ID
@property (nonatomic,assign)NSInteger accountId;
//账套类型
@property (nonatomic,strong)NSString * accountType;
//账套名称
@property (nonatomic,strong)NSString * accountName;
//关联类型
@property (nonatomic,strong)NSString * relationType;
//关联手机
@property (nonatomic,strong)NSString * relationPhone;
//关联内部用户ID
@property (nonatomic,assign)NSInteger accountUserId;
//关联内部用户名称
@property (nonatomic,strong)NSString * accountUserName;
//当前登录角色
@property (nonatomic,strong)RSCurrentRole * currentRole;
//用户下的角色列表
@property (nonatomic,strong)NSArray<RSCurrentRole *> * currentRoles;
//账套权限类
@property (nonatomic,strong)NSString * accountPermission;


@end

NS_ASSUME_NONNULL_END
