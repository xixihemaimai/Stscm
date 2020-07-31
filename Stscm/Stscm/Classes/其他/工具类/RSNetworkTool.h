//
//  RSNetworkTool.h
//  Stscm
//
//  Created by mac on 2020/7/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSNetworkTool : NSObject
{
    NSMutableString *currentElementValue;  //用于存储元素标签的值
    
    BOOL storingFlag; //查询标签所对应的元素是否存在
}


typedef void(^AFNetworkingBlock)(id responseObject,BOOL success);


//验证码和获取UUID的请求方式
+ (void)netWorkToolWebServiceDataUrl:(NSString *)url andType:(NSString *)type withParameters:(NSString *)parameters andURLName:(NSString *)urlName withBlock:(AFNetworkingBlock)block;

//获取登录的请求方式
+ (void)loginUserUrl:(NSString *)url requestType:(NSString *)request SopaStrPasswordAndCodeType:(NSString *)type andPasswordAndCode:(NSString *)code andPhoneNumber:(NSString *)phoneNumber andPKey:(NSString *)pKey andBlock:(AFNetworkingBlock)block;

@end

NS_ASSUME_NONNULL_END
