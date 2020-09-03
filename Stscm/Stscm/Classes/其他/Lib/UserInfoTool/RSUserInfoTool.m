//
//  RSUserInfoTool.m
//  Stscm
//
//  Created by mac on 2020/9/3.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSUserInfoTool.h"

@implementation RSUserInfoTool

+ (void)initWithUserToolUserInfo:(UserInfo *)userInfo ResponseObject:(id)responseObject{
    userInfo.aesKey = responseObject[@"aesKey"];
    userInfo.loginArea = responseObject[@"loginArea"];
    userInfo.loginMode = responseObject[@"loginMode"];
    userInfo.loginTime = responseObject[@"loginTime"];
    userInfo.loginToken = responseObject[@"loginToken"];
    userInfo.passwordSet = responseObject[@"passwordSet"];
    userInfo.uid = responseObject[@"uid"];
    userInfo.userHeadImageUrl = responseObject[@"userHeadImageUrl"];
    userInfo.userName = responseObject[@"userName"];
    userInfo.userPhone = responseObject[@"userPhone"];
    userInfo.visitor = responseObject[@"visitor"];
    
    RSLoggedAccount * loggedAccount = [[RSLoggedAccount alloc]init];
    loggedAccount.accountId = [responseObject[@"loggedAccount"][@"accountId"] integerValue];
    loggedAccount.accountName = responseObject[@"loggedAccount"][@"accountName"];
    loggedAccount.accountPermission = responseObject[@"loggedAccount"][@"accountPermission"];
    loggedAccount.accountType = responseObject[@"loggedAccount"][@"accountType"];
    
    loggedAccount.accountUserId = [responseObject[@"loggedAccount"][@"accountUserId"] integerValue];
    loggedAccount.accountUserName = responseObject[@"loggedAccount"][@"accountUserName"];
    loggedAccount.relationPhone = responseObject[@"loggedAccount"][@"relationPhone"];
    loggedAccount.relationType = responseObject[@"loggedAccount"][@"relationType"];
    
    RSCurrentRole * current = [[RSCurrentRole alloc]init];
    current = [RSCurrentRole mj_objectWithKeyValues:responseObject[@"loggedAccount"][@"currentRole"]];
    loggedAccount.currentRole = current;
    userInfo.loggedAccount = loggedAccount;
    //数组
    userInfo.loggedAccount.currentRoles = [RSCurrentRole mj_objectArrayWithKeyValuesArray:responseObject[@"loggedAccount"][@"accountRoles"]];
    userInfo.loggedAccounts = [RSLoggedAccountsMode mj_objectArrayWithKeyValuesArray:responseObject[@"loggedAccounts"]];
    [UserInfoContext sharedUserInfoContext].userInfo = userInfo;
    [Usertilities SetNSUserDefaults:[UserInfoContext sharedUserInfoContext].userInfo];
}

@end
