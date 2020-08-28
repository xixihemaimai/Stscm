//
//  RSNetworkTool.m
//  Stscm
//
//  Created by mac on 2020/7/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSNetworkTool.h"
#import <CommonCrypto/CommonCrypto.h>


@interface RSNetworkTool()<NSXMLParserDelegate>

@end


@implementation RSNetworkTool

/*
 #define URL_YIGODATA_IOS(A,B,C) [NSString stringWithFormat:@ \
 \
 "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns0=\"http:// \
 \
 webservice.mid.myerp.bokesoft.com\" xmlns:q0=\"http://schemas.xmlsoap.org/soap/encoding/\" \
 \
 xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">" \
 \
 "<soapenv:Body>" \
 \
 "<ns0:unsafeInvokeService>" \
 \
 "<sServiceName soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \
 \
 xsi:type=\"xsd:string\">%@</sServiceName>" \
 \
 "<args q0:arrayType=\"xsd:anyType[2]\" soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \
 \
 xsi:type=\"q0:Array\">" \
 \
 "<q0:string>%@</q0:string>" \
 \
 "<q0:string>%@</q0:string>" \
 \
 "</args>" \
 \
 "</ns0:unsafeInvokeService>" \
 \
 "</soapenv:Body>" \
 \
 "</soapenv:Envelope>",A,B,C] \
 \
 */

//MARK: - 这边是请求的部分
+ (void)netWorkToolWebServiceDataUrl:(NSString *)url andType:(NSString *)type withParameters:(id)parameters andURLName:(NSString *)urlName andContentType:(NSString *)contentType withBlock:(AFNetworkingBlock)block{
    RSNetworkTool * networktool = [[RSNetworkTool alloc]init];
    [networktool newReloadWebServiceNetDataUrl:url andType:type withParameters:parameters andURLName:url andContentType:contentType withBlock:^(id  _Nonnull responseObject, BOOL success) {
        if ([urlName isEqualToString:URL_IMAGE_CHECK_IOS] || [urlName isEqualToString:URL_USER_INFO_IOS]) {
            NSLog(@"=------=00000000000000000000000000000000000000000000000000000000");
            if (success) {
                if ([urlName isEqualToString:URL_USER_INFO_IOS]) {
                    NSDictionary * dict = [networktool decryptMethodWithDictionary:responseObject];
                    responseObject = dict;
                }
                block(responseObject,YES);
            }else{
                block(responseObject,false);
            }
        }else{
            if (block) {
                block(responseObject,YES);
            }
        }
    }];
}

//这边要新创建新的一种请求方式，而且可以上传图片和文件，视频，多张图片上传多种方式集合成一种
+ (void)getDifferentTypeWithDataUrlString:(NSString *)url andLogin_token:(nonnull NSString *)Login_token withParameters:(NSDictionary *)parameters andRequest:(NSString *)request andURLName:(NSString *)urlName andVideoUrl:(NSURL *)videoUrl andType:(NSString *)type andArray:(NSMutableArray *)array andImage:(UIImage *)image withBlock:(AFNetworkingBlock)block{
    RSNetworkTool * networktool = [[RSNetworkTool alloc]init];
    [networktool getDifferentTypeWithDataUrlString:url andLogin_token:Login_token withParameters:parameters andRequest:request andURLName:urlName andVideoUrl:videoUrl andType:type andArray:array andImage:image withBlock:^(id  _Nonnull responseObject, BOOL success) {
        if (block) {
            block(responseObject,YES);
        }
    }];
}



//登录的方式需要单独设置一个
+ (void)loginUserUrl:(NSString *)url requestType:(NSString *)request SopaStrPasswordAndCodeType:(NSString *)type andPasswordAndCode:(NSString *)code andPhoneNumber:(NSString *)phoneNumber andPasswordStr:(nonnull NSString *)password andPKey:(NSString *)pKey andUkey:(NSString *)ukey andContentType:(NSString *)contentType andLoginMode:(nonnull NSString *)loginMode andComputerName:(nonnull NSString *)computerName andLoginArea:(nonnull NSString *)loginArea andBlock:(AFNetworkingBlock)block{
    RSNetworkTool * network = [[RSNetworkTool alloc]init];
    //获取当前的时间戳
    NSInteger timeInt = [network getNowTimestamp];
    //NSString * aes = [FSAES128 AES128Encrypt:[NSString stringWithFormat:@"%ld",timeInt] key:@"123456"];
    //保存在本地
    NSString * aes1 = [NSString stringWithFormat:@"%ld",(long)timeInt];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    //拼凑成一个16位的数
    int a = arc4random() % 100000;
    NSString *str = [NSString stringWithFormat:@"%06d", a];
    //const
    NSString * const aes2 = [NSString stringWithFormat:@"%@%@",aes1,str];
    [user setObject:aes2 forKey:@"AES"];
    [user synchronize];
    NSString * loginType = [NSString string];
    //    NSString * passwordStr = [NSString string];
    //    NSString * codeStr = [NSString string];
    if ([type isEqualToString:@"pwd"]) {
        loginType = @"pwd";
        password = [MyMD5 md5:password];
    }else{
        loginType = @"vcode";
    }
//    computerName =@"Simulator";
//    loginArea = @"未知";
    NSString * data = [NSString stringWithFormat:@"{userPhone:'%@',loginType:'%@',aesKey:'%@',password:'%@',verificationCode:'%@',loginMode:'%@',computerName:'%@',loginArea:'%@'}",phoneNumber,loginType,aes2,password,code,loginMode,computerName,loginArea];
//    NSLog(@"=================================================================%@",data);
    //RSA加密
    NSString * dict = [RSAEncryptor encryptString:data publicKey:pKey];
//    NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%@",dict);
//    ukey = @"AF69B3D1-344B-41E2-8416-EA9B734F3EF3";
    NSDictionary * rsaEncryptor = @{@"data":dict,@"uKey":ukey};
    [network newReloadWebServiceNetDataUrl:url andType:request withParameters:rsaEncryptor andURLName:url andContentType:contentType withBlock:^(id  _Nonnull responseObject, BOOL success) {
        if (block) {
            NSDictionary * dict = [network decryptMethodWithDictionary:responseObject];
            NSLog(@"-----------------------%@",dict);
            
            //这边是登录接口的获取用户信息
//            if (responseObject[@"data"][@"loggedAccount"][@"currentRole"] != nil) {
//
//                //UserInfo * userInfo = [UserInfo mj_objectWithKeyValues:responseObject[@"data"]];
//                RSCurrentRole * currentRole = [RSCurrentRole mj_objectWithKeyValues:responseObject[@"data"][@"loggedAccount"][@"currentRole"]];
//
//                RSLoggedAccount * loggedAcount = [[RSLoggedAccount alloc]init];
//
//                loggedAcount.currentRole = currentRole;
//                loggedAcount.accountId = [responseObject[@"data"][@"loggedAccount"][@"accountId"] integerValue];
//                loggedAcount.accountType = responseObject[@"data"][@"loggedAccount"][@"accountType"];
//                loggedAcount.accountName = responseObject[@"data"][@"loggedAccount"][@"accountName"];
//                loggedAcount.relationType = responseObject[@"data"][@"loggedAccount"][@"relationType"];
//                loggedAcount.relationPhone = responseObject[@"data"][@"loggedAccount"][@"relationPhone"];
//                loggedAcount.accountUserId = [responseObject[@"data"][@"loggedAccount"][@"accountUserId"] integerValue];
//                loggedAcount.accountUserName = responseObject[@"data"][@"loggedAccount"][@"accountUserName"];
//
//                userInfo.aesKey = responseObject[@"data"][@"aesKey"];
//                userInfo.loginArea = responseObject[@"data"][@"loginArea"];
//                userInfo.loginMode = responseObject[@"data"][@"loginMode"];
//                userInfo.loginTime = responseObject[@"data"][@"loginTime"];
//                userInfo.loginToken = responseObject[@"data"][@"loginToken"];
//                userInfo.uid = responseObject[@"data"][@"uid"];
//                userInfo.userHeadImageUrl = responseObject[@"data"][@"userHeadImageUrl"];
//                userInfo.userName = responseObject[@"data"][@"userName"];
//                userInfo.userPhone = responseObject[@"data"][@"userPhone"];
//                userInfo.visitor = [responseObject[@"data"][@"visitor"] boolValue];
//                userInfo.passwordSet = [responseObject[@"data"][@"passwordSet"] boolValue];
//                userInfo.loggedAccount = loggedAcount;
//
//                NSLog(@"===========333333333==================================");
//
//            }else if (responseObject[@"data"][@"loggedAccount"] != NULL){
//                //UserInfo * userInfo = [UserInfo mj_objectWithKeyValues:responseObject[@"data"]];
//                RSLoggedAccount * loggedAcount = [[RSLoggedAccount alloc]init];
//                loggedAcount.accountId = [responseObject[@"data"][@"loggedAccount"][@"accountId"] integerValue];
//                loggedAcount.accountType = responseObject[@"data"][@"loggedAccount"][@"accountType"];
//                loggedAcount.accountName = responseObject[@"data"][@"loggedAccount"][@"accountName"];
//                loggedAcount.relationType = responseObject[@"data"][@"loggedAccount"][@"relationType"];
//                loggedAcount.relationPhone = responseObject[@"data"][@"loggedAccount"][@"relationPhone"];
//                loggedAcount.accountUserId = [responseObject[@"data"][@"loggedAccount"][@"accountUserId"] integerValue];
//                loggedAcount.accountUserName = responseObject[@"data"][@"loggedAccount"][@"accountUserName"];
//
//                userInfo.aesKey = responseObject[@"data"][@"aesKey"];
//                userInfo.loginArea = responseObject[@"data"][@"loginArea"];
//                userInfo.loginMode = responseObject[@"data"][@"loginMode"];
//                userInfo.loginTime = responseObject[@"data"][@"loginTime"];
//                userInfo.loginToken = responseObject[@"data"][@"loginToken"];
//                userInfo.uid = responseObject[@"data"][@"uid"];
//                userInfo.userHeadImageUrl = responseObject[@"data"][@"userHeadImageUrl"];
//                userInfo.userName = responseObject[@"data"][@"userName"];
//                userInfo.userPhone = responseObject[@"data"][@"userPhone"];
//                userInfo.visitor = [responseObject[@"data"][@"visitor"] boolValue];
//                userInfo.passwordSet = [responseObject[@"data"][@"passwordSet"] boolValue];
//                userInfo.loggedAccount = loggedAcount;
//                NSLog(@"=============232323232================================");
//            }else{
//                 NSLog(@"=============111111111================================");
            
            [UserInfoContext sharedUserInfoContext].userInfo = [UserInfo mj_objectWithKeyValues:dict];
            
//            [UserInfoContext sharedUserInfoContext].userInfo.aesKey = dict[@"aesKey"];
//            [UserInfoContext sharedUserInfoContext].userInfo.loginArea = dict[@"loginArea"];
//            [UserInfoContext sharedUserInfoContext].userInfo.loginMode = dict[@"loginMode"];
//            [UserInfoContext sharedUserInfoContext].userInfo.loginTime = dict[@"loginTime"];
//            [UserInfoContext sharedUserInfoContext].userInfo.loginToken = dict[@"loginToken"];
//            [UserInfoContext sharedUserInfoContext].userInfo.passwordSet = dict[@"passwordSet"];
//
//            [UserInfoContext sharedUserInfoContext].userInfo.uid = dict[@"uid"];
//            [UserInfoContext sharedUserInfoContext].userInfo.userHeadImageUrl = dict[@"userHeadImageUrl"];
//            [UserInfoContext sharedUserInfoContext].userInfo.userName = dict[@"userName"];
//            [UserInfoContext sharedUserInfoContext].userInfo.userPhone = dict[@"userPhone"];
//            [UserInfoContext sharedUserInfoContext].userInfo.visitor = dict[@"visitor"];
//            }
            
            [Usertilities SetNSUserDefaults:[UserInfoContext sharedUserInfoContext].userInfo];
            
            
            block(responseObject,YES);
        }
    }];
}
//获取当前系统时间的时间戳
#pragma mark - 获取当前时间的 时间戳
- (NSInteger)getNowTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    //NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    //NSLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}

- (void)getDifferentTypeWithDataUrlString:(NSString *)url andLogin_token:(NSString *)Login_token withParameters:(NSDictionary *)parameters andRequest:(NSString *)request andURLName:(NSString *)urlName  andVideoUrl:(NSURL *)videoUrl andType:(NSString *)type andArray:(NSMutableArray *)array andImage:(UIImage *)image withBlock:(AFNetworkingBlock)block{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/css", nil];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Login_token forHTTPHeaderField:@"LOGIN_TOKEN"];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    manager.requestSerializer.timeoutInterval = 30.0f;
    if ([type isEqualToString:@"image"] || [type isEqualToString:@"imageArray"] || [type isEqualToString:@"file"] || [type isEqualToString:@"video"]) {
        [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            if ([type isEqualToString:@"image"]) {
                NSData *imageData = UIImageJPEGRepresentation(image, 1);
                // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                // 要解决此问题，
                // 可以在上传时使用当前的系统事件作为文件名
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
                NSString *dateString = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
                /*
                 *该方法的参数
                 *1. appendPartWithFileData：要上传的照片[二进制流]
                 *2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
                 *3. fileName：要保存在服务器上的文件名
                 *4. mimeType：上传的文件的类型
                 */
                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
            }else if ([type isEqualToString:@"imageArray"]){
                for (int i = 0; i < array.count; i++) {
                    UIImage *image = array[i];
                    NSData *imageData = UIImageJPEGRepresentation(image, 1);
                    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                    // 要解决此问题，
                    // 可以在上传时使用当前的系统事件作为文件名
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    // 设置时间格式
                    [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
                    NSString *dateString = [formatter stringFromDate:[NSDate date]];
                    NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
                    /*
                     *该方法的参数
                     1. appendPartWithFileData：要上传的照片[二进制流]
                     2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
                     3. fileName：要保存在服务器上的文件名
                     4. mimeType：上传的文件的类型
                     */
                    [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
                }
            }else if ([type isEqualToString:@"file"]){
                NSData *imageData = UIImageJPEGRepresentation(image, 1);
                // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                // 要解决此问题，
                // 可以在上传时使用当前的系统事件作为文件名
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
                NSString *dateString = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
                /*
                *该方法的参数
                *1. appendPartWithFileData：要上传的照片[二进制流]
                *2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
                *3. fileName：要保存在服务器上的文件名
                *4. mimeType：上传的文件的类型
                */
                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
            }else if ([type isEqualToString:@"video"] && array.count < 1 && ![videoUrl isEqual:@""]){
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
                NSString *dateString = [formatter stringFromDate:[NSDate date]];
                NSData *imageData = UIImageJPEGRepresentation(image, 1);
                NSData *videoData = [NSData dataWithContentsOfURL:videoUrl];
                // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                // 要解决此问题，
                // 可以在上传时使用当前的系统事件作为文件名
                //NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                // [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
                // NSString *dateString = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
                /*
                 *该方法的参数
                 *1. appendPartWithFileData：要上传的照片[二进制流]
                 *2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
                 *3. fileName：要保存在服务器上的文件名
                 *4. mimeType：上传的文件的类型
                 */
                //图片
                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
                //视频
                [formData appendPartWithFileData:videoData name:@"file" fileName:@"video.mp4"  mimeType:@"video/mp4"];
                //UIImage *image = dataArray[i];
                //NSData *imageData = UIImageJPEGRepresentation(image, 1);
                // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                // 要解决此问题，
                // 可以在上传时使用当前的系统事件作为文件名
                //NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                //[formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
                //NSString *dateString = [formatter stringFromDate:[NSDate date]];
                // NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
                // /*
                // *该方法的参数
                // 1. appendPartWithFileData：要上传的照片[二进制流]
                // 2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
                // 3. fileName：要保存在服务器上的文件名
                // 4. mimeType：上传的文件的类型
                // */
                //[formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
                
                
            }else if ([type isEqualToString:@"video"] && array.count > 0 && [videoUrl isEqual:@""]){
                for (int i = 0; i < array.count; i++) {
                    NSURL *url = array[i];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    // 设置时间格式
                    [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
                    NSString *dateString = [formatter stringFromDate:[NSDate date]];
                    NSData *imageData = UIImageJPEGRepresentation(image, 1);
                    NSData *videoData = [NSData dataWithContentsOfURL:url];
                    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                    // 要解决此问题，
                    // 可以在上传时使用当前的系统事件作为文件名
                    //NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    // 设置时间格式
                    // [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
                    // NSString *dateString = [formatter stringFromDate:[NSDate date]];
                    NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
                    /*
                     *该方法的参数
                     *1. appendPartWithFileData：要上传的照片[二进制流]
                     *2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
                     *3. fileName：要保存在服务器上的文件名
                     *4. mimeType：上传的文件的类型
                     */
                    //图片
                    [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
                    //视频
                    [formData appendPartWithFileData:videoData name:@"file" fileName:@"video.mp4"  mimeType:@"video/mp4"];
                    //UIImage *image = dataArray[i];
                    //NSData *imageData = UIImageJPEGRepresentation(image, 1);
                    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                    // 要解决此问题，
                    // 可以在上传时使用当前的系统事件作为文件名
                    //NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    // 设置时间格式
                    //[formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
                    //NSString *dateString = [formatter stringFromDate:[NSDate date]];
                    // NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
                    // /*
                    // *该方法的参数
                    // 1. appendPartWithFileData：要上传的照片[二进制流]
                    // 2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
                    // 3. fileName：要保存在服务器上的文件名
                    // 4. mimeType：上传的文件的类型
                    // */
                    //[formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
                }
            }
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"success"] boolValue]) {
                NSDictionary * dict = [self decryptMethodWithDictionary:responseObject];
                NSLog(@"========================%@",dict);
                //解密
                responseObject = dict[@"headImageUrl"];
                NSLog(@"++++++++++++++++232323+++++++++++++%@",responseObject);
                block(responseObject,YES);
                jxt_dismissHUD();
            }else{
                NSLog(@"-======================%@",responseObject[@"msg"]);
                jxt_showToastTitle(responseObject[@"msg"], 0.75);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"=====2=33==================%@",error);
            jxt_showToastTitle(@"请求失败", 0.75);
        }];
    }else{
        [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"success"] boolValue]) {
                block(responseObject,YES);
                jxt_dismissHUD();
            }else{
                NSLog(@"-======================%@",responseObject[@"msg"]);
                jxt_showToastTitle(responseObject[@"msg"], 0.75);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"=====2=33==================%@",error);
            jxt_showToastTitle(@"请求失败", 0.75);
        }];
    }
}

- (void)reloadWebServiceNetDataUrl:(NSString *)URLStr  andType:(NSString *)type andParameters:(NSString *)soapStr withBlock:(AFNetworkingBlock)block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    // 设置请求超时时间
    manager.requestSerializer.timeoutInterval = 30.f;
    // 返回NSData
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头，也可以不设置
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"SOAPAction"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error)
     {
        return soapStr;
    }];
    if ([type isEqualToString:@"POST"]) {
        [manager POST:URLStr parameters:soapStr progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            block(responseObject,YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(error,NO);
        }];
    }else{
        [manager GET:URLStr parameters:soapStr progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"-------------------%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"---------32323----------%@",error);
        }];
    }
}
//新的请求方式
- (void)newReloadWebServiceNetDataUrl:(NSString *)url andType:(NSString *)type withParameters:(id)parameters andURLName:(NSString *)urlName andContentType:(NSString *)contentType withBlock:(AFNetworkingBlock)block{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/css", nil];
    if ([type isEqualToString:@"GET"]) {
       [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        if (![contentType isEqualToString:@"JSON"]) {
            [manager.requestSerializer setValue:contentType forHTTPHeaderField:@"LOGIN_TOKEN"];
        }
    }
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    manager.requestSerializer.timeoutInterval = 30.0f;
    //    NSLog(@"----------------------%@",url);
    //    NSLog(@"===================%@",parameters);
    if ([type isEqualToString:@"GET"]) {
        url = [NSString stringWithFormat:@"%@?%@",url,parameters];
        NSLog(@"-===========================%@",url);
    }
    if ([type isEqualToString:@"POST"]) {
        NSURL * newUrl = [NSURL URLWithString:url];
        //创建请求request
        NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:newUrl cachePolicy:0 timeoutInterval:30];
        //设置请求方式为POST
        request.HTTPMethod = @"POST";
        //设置请求内容格式
        if (![URL_LOGOUT_IOS isEqualToString:urlName]) {
            [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        }else{
            //登出接口需要的地方
            [request setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        }
        if (![contentType isEqualToString:@"JSON"]) {
            [request setValue:contentType forHTTPHeaderField:@"LOGIN_TOKEN"];
        }
        NSLog(@"=================================%@",parameters);
        //这是设置请求体，把参数放进请求体(这部分的参数也叫请求参数)
        NSString *paramJsonStr = [self dictionaryToJson:parameters];
        //NSData * data = [paramJsonStr dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = [paramJsonStr dataUsingEncoding:NSUTF8StringEncoding];
        [[manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        }completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if ([responseObject[@"success"] boolValue]) {
                NSLog(@"++++++++++++++++++++++++++++++%@",responseObject);
                block(responseObject,YES);
                jxt_dismissHUD();
            }else{
                if ([urlName isEqualToString:URL_IMAGE_CHECK_IOS]) {
                    block(responseObject,false);
                }
                jxt_showToastTitle(responseObject[@"msg"], 0.75);
            }
            if (error) {
                 NSLog(@"+++++++++++3232++++++++++++");
                jxt_showToastTitle(@"请求失败", 0.75);
                return;
            }
        }] resume];
    }else{
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"-======人===============%@",responseObject);
            if ([responseObject[@"success"] boolValue]) {
                block(responseObject,YES);
                jxt_dismissHUD();
            }else{
                NSLog(@"-======================%@",responseObject[@"msg"]);
                if ([urlName isEqualToString:URL_USER_INFO_IOS]) {
                    block(responseObject,false);
                }
                jxt_showToastTitle(responseObject[@"msg"], 0.75);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"=====2=33==================%@",error);
            jxt_showToastTitle(@"请求失败", 0.75);
            
            if ([urlName isEqualToString:URL_USER_INFO_IOS]) {
                NSString * responseObject = @"";
                block(responseObject,false);
            }
        }];
    }
}
//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    
}
//正在解析
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    if ([elementName isEqualToString:@"unsafeInvokeServiceReturn"]) {
        storingFlag = true;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (storingFlag) {
        if (!currentElementValue) {
            currentElementValue = [[NSMutableString alloc] initWithString:string];
        }
        else {
            [currentElementValue appendString:string];
        }
    }
}
//解析完成
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (storingFlag) {
        NSString *trimmedString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        storingFlag = false;
        //字符串转字典
        NSDictionary * dict = [self dictionaryWithJsonString:trimmedString];
        BOOL issuccess = [dict[@"result"] boolValue];
        if (issuccess) {
        }
    }
}
//结束解析
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
}

//解密的方法
- (NSDictionary *)decryptMethodWithDictionary:(NSDictionary *)dict{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString * const kInitVector = @"16-Bytes--String";
    NSString * data1 = [NSString stringWithFormat:@"%@",dict[@"data"]];
    NSLog(@"=================%@",data1);
    NSString * userData = [FSAES128 decryptAES:data1 key:aes andKInItVector:kInitVector];
    NSLog(@"+++++++++++++++++%@",userData);
    if ([userData length] < 1) {
        //[self userloginOut];
        return nil;
    }else{
        NSData *jsonData = [userData dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"+++++++++++++++++%@",jsonData);
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        return dic;
    }
}

//字符串转字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        //NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//这是我的一个工具类里面的方法，大家可以改成对象方法直接替换调用即可
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if (dic.allKeys.count == 0){
        #ifdef DSDUBUG
        NSLog(@"%@---%s",self.class,__FUNCTION__);
        NSLog(@"您传入的字典为空，无法转换，请确保字典不为空！！！");
        #endif
        return nil;
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



@end
