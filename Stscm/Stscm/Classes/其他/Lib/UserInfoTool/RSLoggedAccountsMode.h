//
//  RSLoggedAccountsMode.h
//  Stscm
//
//  Created by mac on 2020/9/3.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSLoggedAccountsMode : NSObject<NSCopying>

/**
 accountId = 5;
 accountName = 3;
 accountPermission = "<null>";
 accountRoles = "<null>";
 accountType = company;
 accountUserId = 1;
 accountUserName = "\U7ba1\U7406\U5458";
 currentRole = "<null>";
 relationPhone = 13950800133;
 relationType = main;
 */
@property (nonatomic,assign)NSInteger accountId;

@property (nonatomic,strong)NSString * accountName;

@property (nonatomic,strong)NSString * accountPermission;

@property (nonatomic,strong)NSString * accountRoles;

@property (nonatomic,strong)NSString * accountType;

@property (nonatomic,assign)NSInteger accountUserId;

@property (nonatomic,strong)NSString * accountUserName;

@property (nonatomic,strong)NSString * currentRole;

@property (nonatomic,strong)NSString * relationPhone;

@property (nonatomic,strong)NSString * relationType;



@end

NS_ASSUME_NONNULL_END
