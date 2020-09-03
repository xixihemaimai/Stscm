//
//  RSLoggedAccountsMode.m
//  Stscm
//
//  Created by mac on 2020/9/3.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSLoggedAccountsMode.h"

@implementation RSLoggedAccountsMode

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.accountId forKey:@"accountId"];
    [aCoder encodeObject:self.accountName forKey:@"accountName"];
    [aCoder encodeObject:self.accountPermission forKey:@"accountPermission"];
    [aCoder encodeObject:self.accountRoles forKey:@"accountRoles"];
    [aCoder encodeObject:self.accountType forKey:@"accountType"];
    [aCoder encodeInteger:self.accountUserId forKey:@"accountUserId"];
    [aCoder encodeObject:self.accountUserName forKey:@"accountUserName"];
    [aCoder encodeObject:self.currentRole forKey:@"currentRole"];
    [aCoder encodeObject:self.relationPhone forKey:@"relationPhone"];
    [aCoder encodeObject:self.relationType forKey:@"relationType"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.accountId = [aDecoder decodeIntegerForKey:@"accountId"];
        self.accountName = [aDecoder decodeObjectForKey:@"accountName"];
        self.accountPermission = [aDecoder decodeObjectForKey:@"accountPermission"];
        self.accountRoles = [aDecoder decodeObjectForKey:@"accountRoles"];
        self.accountType = [aDecoder decodeObjectForKey:@"accountType"];
        self.accountUserId = [aDecoder decodeIntegerForKey:@"accountUserId"];
        self.accountUserName = [aDecoder decodeObjectForKey:@"accountUserName"];
        self.currentRole = [aDecoder decodeObjectForKey:@"currentRole"];
        self.relationPhone = [aDecoder decodeObjectForKey:@"relationPhone"];
        self.relationType = [aDecoder decodeObjectForKey:@"relationType"];
    }
    return self;
}


@end
