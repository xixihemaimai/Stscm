//
//  RSLoggedAccount.m
//  Stscm
//
//  Created by mac on 2020/8/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSLoggedAccount.h"

@implementation RSLoggedAccount


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.accountId forKey:@"accountId"];
    [aCoder encodeObject:self.accountType forKey:@"accountType"];
    [aCoder encodeObject:self.accountName forKey:@"accountName"];
    [aCoder encodeObject:self.relationType forKey:@"relationType"];
    [aCoder encodeObject:self.relationPhone forKey:@"relationPhone"];
    [aCoder encodeInteger:self.accountUserId forKey:@"accountUserId"];
    [aCoder encodeObject:self.accountUserName forKey:@"accountUserName"];
    [aCoder encodeObject:self.currentRole forKey:@"currentRole"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.accountId = [aDecoder decodeIntegerForKey:@"accountId"];
        self.accountType = [aDecoder decodeObjectForKey:@"accountType"];
        self.accountName = [aDecoder decodeObjectForKey:@"accountName"];
        self.relationType = [aDecoder decodeObjectForKey:@"relationType"];
        self.relationPhone = [aDecoder decodeObjectForKey:@"relationPhone"];
        self.accountUserId = [aDecoder decodeIntegerForKey:@"accountUserId"];
        self.accountUserName = [aDecoder decodeObjectForKey:@"accountUserName"];
        self.currentRole = [aDecoder decodeObjectForKey:@"currentRole"];
    }
    return self;
}

@end
