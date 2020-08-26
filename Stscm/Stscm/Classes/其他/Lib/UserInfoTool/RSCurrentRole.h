//
//  RSCurrentRole.h
//  Stscm
//
//  Created by mac on 2020/8/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSCurrentRole : NSObject<NSCopying>

//角色ID
@property (nonatomic,strong)NSString * roleId;
//角色代码
@property (nonatomic,strong)NSString * roleCode;
//角色名称
@property (nonatomic,strong)NSString * roleName;


@end

NS_ASSUME_NONNULL_END
