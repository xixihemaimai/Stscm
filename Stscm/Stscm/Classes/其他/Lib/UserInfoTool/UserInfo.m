//
//  UserInfo.m
//  userInfo
//
//  Created by mac on 2020/8/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.aesKey forKey:@"aesKey"];
    [aCoder encodeObject:self.loginArea forKey:@"loginArea"];
    [aCoder encodeObject:self.loginMode forKey:@"loginMode"];
    [aCoder encodeObject:self.loginTime forKey:@"loginTime"];
    [aCoder encodeObject:self.loginToken forKey:@"loginToken"];
    [aCoder encodeBool:self.passwordSet forKey:@"passwordSet"];
    [aCoder encodeObject:self.userHeadImageUrl forKey:@"userHeadImageUrl"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.userPhone forKey:@"userPhone"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeBool:self.visitor forKey:@"visitor"];
    [aCoder encodeObject:self.loggedAccount forKey:@"loggedAccount"];
    [aCoder encodeObject:self.loggedAccounts forKey:@"loggedAccounts"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.aesKey = [aDecoder decodeObjectForKey:@"aesKey"];
        self.loginArea = [aDecoder decodeObjectForKey:@"loginArea"];
        self.loginMode = [aDecoder decodeObjectForKey:@"loginMode"];
        self.loginTime = [aDecoder decodeObjectForKey:@"loginTime"];
        self.loginToken = [aDecoder decodeObjectForKey:@"loginToken"];
        
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.userHeadImageUrl = [aDecoder decodeObjectForKey:@"userHeadImageUrl"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.userPhone = [aDecoder decodeObjectForKey:@"userPhone"];
        self.passwordSet = [aDecoder decodeObjectForKey:@"passwordSet"];
        self.visitor = [aDecoder decodeBoolForKey:@"visitor"];
        self.loggedAccount = [aDecoder decodeObjectForKey:@"loggedAccount"];
        self.loggedAccounts = [aDecoder decodeObjectForKey:@"loggedAccounts"];
    }
    return self;
}


@end
