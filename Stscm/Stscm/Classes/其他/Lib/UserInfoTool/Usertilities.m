//
//  Usertilities.m
//  Stscm
//
//  Created by mac on 2020/8/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import "Usertilities.h"

@implementation Usertilities

//存储单例Models(UserInfo)到NSUserDefaults
+(void)SetNSUserDefaults:(UserInfo *)userInfo{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"usermodel"];
    [defaults synchronize];
}
//读取NSUserDefaults存储内容return到单例Modesl(UserInfo)中
+(UserInfo *)GetNSUserDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [defaults objectForKey:@"usermodel"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (void)clearLocalUserModel{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"usermodel"];
    [defaults synchronize];
}
@end
