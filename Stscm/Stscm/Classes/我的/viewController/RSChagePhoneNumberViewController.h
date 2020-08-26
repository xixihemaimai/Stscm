//
//  RSChagePhoneNumberViewController.h
//  Stscm
//
//  Created by mac on 2020/8/11.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSBaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface RSChagePhoneNumberViewController : RSBaseViewController

//0.修改昵称 1.是请输入原手机号 2.请输入新手机号 3.请输入验证码  4.修改密码
@property (nonatomic,assign)NSInteger phoneType;
//+区号 
@property (nonatomic,strong)NSString * areaStr;
//电话号码，是用来输入新手机号到验证码的地方需要的
@property (nonatomic,strong)NSString * phoneStr;




@end

NS_ASSUME_NONNULL_END
