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


/// 验证码和获取UUID的请求方式
/// @param url 网址路径
/// @param type 请求方式
/// @param parameters 参数
/// @param urlName 网址路径
/// @param contentType 不一样的contentType
/// @param block 回调
+ (void)netWorkToolWebServiceDataUrl:(NSString *)url andType:(NSString *)type withParameters:(id)parameters andURLName:(NSString *)urlName andContentType:(NSString *)contentType withBlock:(AFNetworkingBlock)block;



/// 登录获取用户数据
/// @param url 网址路径
/// @param request 请求方式
/// @param type 是密码登录还是验证码登录
/// @param code 验证码
/// @param phoneNumber 手机号
/// @param password 密码
/// @param pKey 公钥
/// @param contentType 不一样的contentType
/// @param block 回调
+ (void)loginUserUrl:(NSString *)url requestType:(NSString *)request SopaStrPasswordAndCodeType:(NSString *)type andPasswordAndCode:(NSString *)code andPhoneNumber:(NSString *)phoneNumber andPasswordStr:(nonnull NSString *)password andPKey:(NSString *)pKey andUkey:(NSString *)ukey andContentType:(NSString *)contentType andLoginMode:(NSString *)loginMode andComputerName:(NSString *)computerName andLoginArea:(NSString *)loginArea andBlock:(AFNetworkingBlock)block;

    
/// 获取登录的请求方式
/// @param url 网址路径
/// @param Login_token 登录token值
/// @param parameters 参数
/// @param request 请求的方式
/// @param urlName 网址路径用来比较的
/// @param videoUrl 视频的网络地址
/// @param type 文件，图片，视频，多种图片，
/// @param array 图片，视频，多种图片，多种视频
/// @param image 图片
/// @param block  回调
+ (void)getDifferentTypeWithDataUrlString:(NSString *)url andLogin_token:(NSString *)Login_token withParameters:(NSDictionary *)parameters andRequest:(NSString *)request andURLName:(NSString *)urlName  andVideoUrl:(NSURL *)videoUrl andType:(NSString *)type andArray:(NSMutableArray *)array andImage:(UIImage *)image withBlock:(AFNetworkingBlock)block;

@end

NS_ASSUME_NONNULL_END
