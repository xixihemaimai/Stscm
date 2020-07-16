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





//网络请求的方法---包括上拉，下来，直接请求的部分，登录部分需要不一样的东西




//密码进行md5的加密----注册,登录，修改密码部分
-(NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}



//加密
- (NSString *)encryptAES:(NSString *)content key:(NSString *)key andKInItVector:(NSString * const)kInitVector{
    size_t const kKeySize = kCCKeySizeAES128;
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    //NSData * contentData = [self dataForHexString:content];
    NSUInteger dataLength = contentData.length;
    // 为结束符'\\0' +1
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // 密文长度 <= 明文长度 + BlockSize
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,  // 系统默认使用 CBC，然后指明使用 PKCS7Padding
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          encryptedBytes,
                                          encryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        // 对加密后的数据进行 base64 编码
        
       // return [[NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        NSData * data = [NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize];
        return [self hexStringFromData:data];
       
    }
    free(encryptedBytes);
    return nil;
}



//解密
- (NSString *)decryptAES:(NSString *)content key:(NSString *)key andKInItVector:(NSString * const)kInitVector{
    size_t const kKeySize = kCCKeySizeAES128;
    // 把 base64 String 转换成 Data
    //NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData * contentData = [self dataForHexString:content];
    NSUInteger dataLength = contentData.length;
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t decryptSize = dataLength + kCCBlockSizeAES128;
    void *decryptedBytes = malloc(decryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          decryptedBytes,
                                          decryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        return [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:decryptedBytes length:actualOutSize] encoding:NSUTF8StringEncoding];
            }
    free(decryptedBytes);
    return nil;
}


// 普通字符串转换为十六进
- (NSString *)hexStringFromData:(NSData *)data {
    Byte *bytes = (Byte *)[data bytes];
    // 下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for(int i=0; i<[data length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i] & 0xff]; //16进制数
        newHexStr = [newHexStr uppercaseString];

        if([newHexStr length] == 1) {
            newHexStr = [NSString stringWithFormat:@"0%@",newHexStr];
        }

        hexStr = [hexStr stringByAppendingString:newHexStr];

    }
    return hexStr;
}
//
//
//
////十六进制转Data
////十六进制转Data
- (NSData*)dataForHexString:(NSString*)hexString
{
    if (hexString == nil) {
        return nil;
    }
    const char* ch = [[hexString lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* data = [NSMutableData data];
    while (*ch) {
        if (*ch == ' ') {
            continue;
        }
        char byte = 0;
        if ('0' <= *ch && *ch <= '9') {
            byte = *ch - '0';
        }else if ('a' <= *ch && *ch <= 'f') {
            byte = *ch - 'a' + 10;
        }else if ('A' <= *ch && *ch <= 'F') {
            byte = *ch - 'A' + 10;
        }
        ch++;
        byte = byte << 4;
        if (*ch) {
            if ('0' <= *ch && *ch <= '9') {
                byte += *ch - '0';
            } else if ('a' <= *ch && *ch <= 'f') {
                byte += *ch - 'a' + 10;
            }else if('A' <= *ch && *ch <= 'F'){
                byte += *ch - 'A' + 10;
            }
            ch++;
        }
        [data appendBytes:&byte length:1];
    }
    return data;
}


//MARK: - 这边是请求的部分
//这边是获取单页的UITableview的数据
+ (void)reloadWebServiceNetDataUrl:(NSString *)URLStr andParameters:(NSString *)soapStr withBlock:(AFNetworkingBlock)block{
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
    [manager POST:URLStr parameters:soapStr progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(error,NO);
    }];
}


//新的请求方式
- (void)newReloadWebServiceNetDataUrl:(NSString *)url withParameters:(NSDictionary *)parameters andURLName:(NSString *)urlName withBlock:(AFNetworkingBlock)block{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    manager.requestSerializer.timeoutInterval = 30.0f;
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        block(responseObject,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        block(error,NO);
    }];
}



//这边要进行设置进入解析步骤的方法---这种需要的是加密和解密的部分




//这边是直接新的请求方式的部分
//- (void)directPostWebNewData:(NSString *)urlStr;



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
//    NSString * userData = [FSAES128 decryptAES:data1 key:aes andKInItVector:kInitVector];
    NSString * userData = [self decryptAES:data1 key:aes andKInItVector:kInitVector];
    if ([userData length] < 1) {
//        [self userloginOut];
//        [SVProgressHUD showErrorWithStatus:@"登录失效"];
//        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//        [user removeObjectForKey:@"OAUSERMODEL"];
//        [user removeObjectForKey:@"AES"];
//        [user synchronize];
//        AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//        appdelegate.window.rootViewController = loginVc;
        return nil;
    }else{
        NSData *jsonData = [userData dataUsingEncoding:NSUTF8StringEncoding];
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


@end
