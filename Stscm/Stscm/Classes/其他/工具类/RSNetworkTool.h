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



//网路请求




@end

NS_ASSUME_NONNULL_END
