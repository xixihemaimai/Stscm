//
//  RSCurrentRole.m
//  Stscm
//
//  Created by mac on 2020/8/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSCurrentRole.h"

@implementation RSCurrentRole

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.roleId forKey:@"roleId"];
    [aCoder encodeObject:self.roleCode forKey:@"roleCode"];
    [aCoder encodeObject:self.roleName forKey:@"roleName"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.roleId = [aDecoder decodeObjectForKey:@"roleId"];
        self.roleCode = [aDecoder decodeObjectForKey:@"roleCode"];
        self.roleName = [aDecoder decodeObjectForKey:@"roleName"];
    }
    return self;
}
@end
