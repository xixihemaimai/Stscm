//
//  RSPasswordViewController.m
//  Stscm
//
//  Created by mac on 2020/7/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSPasswordViewController.h"

#import "RSMainViewController.h"

#import "RSLoginViewController.h"

@interface RSPasswordViewController ()

@property (nonatomic,strong) RJTextField * account;

@property (nonatomic,strong) RJTextField * password;

@property (nonatomic,strong) UIButton * choiceBtn;

@end

@implementation RSPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setRegisterUIView:self.view andTitle:@"注册"];
    self.emptyView.hidden = YES;
    //    self.tableview.hidden = YES;
    [self setUi];
}

- (void)setUi{
    
    UILabel * name = [[UILabel alloc]init];
    name.text = @"手机号";
    name.textAlignment = NSTextAlignmentLeft;
    name.textColor = [UIColor colorWithHexColorStr:@"#393939"];
    name.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:name];
       
       
    RJTextField * account = [[RJTextField alloc]init];
    [self.view addSubview:account];

    
    UILabel * codeName = [[UILabel alloc]init];
    codeName.text = @"验证码";
    codeName.textAlignment = NSTextAlignmentLeft;
    codeName.textColor = [UIColor colorWithHexColorStr:@"#393939"];
    codeName.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:codeName];
    _account = account;
       
    RJTextField * password = [[RJTextField alloc]init];
    [self.view addSubview:password];

    account.textField.keyboardType = UIKeyboardTypePhonePad;
    password.textField.keyboardType = UIKeyboardTypePhonePad;
    _password = password;
    
    
    account.placeholder = @"请输入密码";
    password.placeholder = @"请再次输入密码";
                
    account.maxLength = 18;
    account.errorStr = @"超出字数限制";
                
    password.maxLength = 18;
    password.errorStr = @"超出字数限制";
     

//    UIButton * button = [[SmsButtonHandle sharedSmsBHandle]buttonWithTitle:@"获取验证码" action:@selector(buttonAction) superVC:self];
//    [self.view addSubview:button];
    
    
    UILabel * alertLabel = [[UILabel alloc]init];
    alertLabel.text = @"*为了您的数据安全,请设置密码";
    alertLabel.textColor = [UIColor colorWithHexColorStr:@"#9B9B9B"];
    alertLabel.font = [UIFont systemFontOfSize:14];
    alertLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:alertLabel];
    
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FCC828"]];
    [loginBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton * jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jumpBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [jumpBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FCC828"] forState:UIControlStateNormal];
    [jumpBtn addTarget:self action:@selector(jumpAction:) forControlEvents:UIControlEventTouchUpInside];
    jumpBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:jumpBtn];
    
    NSDictionary * underAttribtDic  = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor colorWithRed:252/255.0 green:200/255.0 blue:40/255.0 alpha:1.0]};
    NSMutableAttributedString * underAttr = [[NSMutableAttributedString alloc] initWithString:@"已有账号，去登录" attributes:underAttribtDic];
    UIButton * accountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [accountBtn setAttributedTitle:underAttr forState:UIControlStateNormal];
    accountBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [accountBtn addTarget:self action:@selector(jumpLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:accountBtn];
    
    
    UIButton * choiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [choiceBtn setImage:[UIImage imageNamed:@"未选"] forState:UIControlStateNormal];
    [choiceBtn setImage:[UIImage imageNamed:@"选择备份"] forState:UIControlStateSelected];
    [choiceBtn addTarget:self action:@selector(choiceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choiceBtn];
    _choiceBtn = choiceBtn;
    
    UILabel * choiceLabel = [[UILabel alloc]init];
    choiceLabel.text = @"登录和注册即同意";
    choiceLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    choiceLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:choiceLabel];
    
    UIButton * userDelegate = [UIButton buttonWithType:UIButtonTypeCustom];
    [userDelegate setTitle:@"用户协议" forState:UIControlStateNormal];
    [userDelegate setTitleColor:[UIColor colorWithHexColorStr:@"#FCC828"] forState:UIControlStateNormal];
    userDelegate.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:userDelegate];
    
    UILabel * andLabel = [[UILabel alloc]init];
    andLabel.text = @"和";
    andLabel.textColor = [UIColor colorWithHexColorStr:@"#FCC828"];
    andLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:andLabel];
    
    UIButton * privateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [privateBtn setTitle:@"隐私政策" forState:UIControlStateNormal];
    [privateBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FCC828"] forState:UIControlStateNormal];
    privateBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:privateBtn];
    
    name.sd_layout
    .leftSpaceToView(self.view, 35)
    .topSpaceToView(self.view, 245)
    .rightSpaceToView(self.view, 35)
    .heightIs(20);
    
    account.sd_layout
    .leftSpaceToView(self.view, 23)
    .rightEqualToView(name)
    .topSpaceToView(name, 8.5)
    .heightIs(34.5);
    
    codeName.sd_layout
    .leftEqualToView(name)
    .rightEqualToView(account)
    .topSpaceToView(account, 21)
    .heightIs(20);
    
    password.sd_layout
    .leftSpaceToView(self.view, 23)
    .rightEqualToView(codeName)
    .topSpaceToView(codeName, 8.5)
    .heightIs(34.5);
    
    alertLabel.sd_layout
    .leftEqualToView(name)
    .rightEqualToView(name)
    .topSpaceToView(password, 3.5)
    .heightIs(20);
    
    
    loginBtn.sd_layout
    .rightEqualToView(password)
    .leftEqualToView(password)
    .topSpaceToView(password, 48.5)
    .heightIs(49);
    
    loginBtn.layer.cornerRadius = 27;
    loginBtn.layer.masksToBounds = YES;
    
//    button.sd_layout
//    .rightSpaceToView(self.view, 35)
//    .topSpaceToView(codeName, 20)
//    .widthIs(70)
//    .heightIs(20);
    
    jumpBtn.sd_layout
    .leftEqualToView(loginBtn)
    .rightEqualToView(loginBtn)
    .topSpaceToView(loginBtn, 4)
    .heightIs(24);
    
    accountBtn.sd_layout
    .leftEqualToView(jumpBtn)
    .rightEqualToView(jumpBtn)
    .topSpaceToView(jumpBtn, 21.5)
    .heightIs(20);
    
    choiceBtn.sd_layout
    .leftSpaceToView(self.view, 72)
    .bottomSpaceToView(self.view, 37)
    .widthIs(12)
    .heightEqualToWidth();
    
    choiceLabel.sd_layout
    .leftSpaceToView(choiceBtn, 5)
    .bottomSpaceToView(self.view, 35)
    .heightIs(16.5)
    .widthIs(100);
    
    userDelegate.sd_layout
    .leftSpaceToView(choiceLabel, 0)
    .topEqualToView(choiceLabel)
    .bottomEqualToView(choiceLabel)
    .widthIs(50);
    
    andLabel.sd_layout
    .topEqualToView(userDelegate)
    .bottomEqualToView(userDelegate)
    .leftSpaceToView(userDelegate, 0)
    .widthIs(15);
    
    privateBtn.sd_layout
    .topEqualToView(andLabel)
    .bottomEqualToView(andLabel)
    .leftSpaceToView(andLabel, 0)
    .widthIs(50)
    .heightIs(16.5);
    
    name.text = @"密码";
    codeName.text = @"确认密码";
    accountBtn.hidden = NO;
    jumpBtn.hidden = NO;
    alertLabel.hidden = NO;
//    button.hidden = YES;
    
}


//FIXME:是否同意需要隐私按键
- (void)choiceAction:(UIButton *)choiceBtn{
    choiceBtn.selected = !choiceBtn.selected;
}

//跳过
- (void)jumpAction:(UIButton *)jumpBtn{
    //用手机号，
     [self registerNetWorkType:@"vcode"];
    //用验证码获取
}

//FIXME:跳转到登录界面
- (void)jumpLoginAction:(UIButton *)jumpLoginBtn{
    RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
    [self.navigationController pushViewController:loginVc animated:YES];
}


//FIXME:注册方法
- (void)loginAction:(UIButton *)loginBtn{
    
    if(![self validatePassword:_account.textField.text])
    {
        jxt_showToastMessage(@"请设置注册密码", 0.75);
        return;
    }
    if (_account.textField.text.length<6)
    {
        jxt_showToastMessage(@"请设置6-18位密码", 0.75);
        return;
    }
    if (_account.textField.text.length>18)
    {
        jxt_showToastMessage(@"请设置6-18位密码", 0.75);
        return;
    }
    //确认密码
    if(![self validatePassword:_password.textField.text])
    {
        jxt_showToastMessage(@"请设置确认注册密码", 0.75);
        return;
    }
    if (_password.textField.text.length<6)
    {
        jxt_showToastMessage(@"请设置6-18位密码", 0.75);
        return;
    }
    if (_password.textField.text.length>20)
    {
        jxt_showToastMessage(@"请设置6-18位密码", 0.75);
        return;
    }
    if(![_account.textField.text isEqualToString:_password.textField.text])
    {
        jxt_showToastMessage(@"密码不一致", 0.75);
        return;
    }
    if (_choiceBtn.selected != YES) {
        [SVProgressHUD showErrorWithStatus:@"请同意隐私政策"];
        return;
    }
    
    //这边是密码获取
    [self registerNetWorkType:@"pwd"];

}


- (void)registerNetWorkType:(NSString *)type{
    NSDictionary * phoneNumber = [NSDictionary dictionary];
    if ([type isEqualToString:@"password"]) {
        //phoneNumber = [NSString stringWithFormat:@"phoneNumber=%@&verificationCode=%@&password=%@",self.phoneStr,self.codeStr,[MyMD5 md5:_account.textField.text]];
        phoneNumber = @{@"phoneNumber":self.phoneStr,
        @"verificationCode":self.codeStr,
        @"password":[MyMD5 md5:_account.textField.text]
        };
        
    }else{
//       phoneNumber = [NSString stringWithFormat:@"phoneNumber=%@&verificationCode=%@",self.phoneStr,self.codeStr];
        phoneNumber = @{@"phoneNumber":self.phoneStr,
        @"verificationCode":self.codeStr
        };
    }
    RSWeakself
    NSString * code = [NSString string];
    NSString * pwd = [NSString string];
    if ([type isEqualToString:@"pwd"]) {
        pwd = _account.textField.text;
        code = self.codeStr;
    }else{
        pwd = @"";
        code = self.codeStr;
    }
    [RSNetworkTool netWorkToolWebServiceDataUrl:URL_SUBMIT_IOS andType:@"POST" withParameters:phoneNumber andURLName:URL_SUBMIT_IOS andContentType:@"JSON" withBlock:^(id  _Nonnull responseObject, BOOL success) {
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           //设备的唯一标识号
           NSString * udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
           NSString * ukey = [NSString stringWithFormat:@"uKey=%@",udid];
           [RSNetworkTool netWorkToolWebServiceDataUrl:URL_KEY_GET_IOS andType:@"GET" withParameters:ukey andURLName:URL_KEY_GET_IOS  andContentType:@"JSON" withBlock:^(id  _Nonnull responseObject, BOOL success) {
                jxt_showLoadingHUDTitleMessage(@"正在执行登录中", nil);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [RSNetworkTool loginUserUrl:URL_LOGIN_IOS requestType:@"POST" SopaStrPasswordAndCodeType:type andPasswordAndCode:code andPhoneNumber:weakSelf.phoneStr andPasswordStr:pwd andPKey:responseObject[@"data"][@"pKey"] andContentType:@"JSON" andBlock:^(id  _Nonnull responseObject, BOOL success) {
                        NSLog(@"----33333---------------%@",responseObject);
                        jxt_dismissHUD();
                    }];
                });
           }];
        });
    }];
}



@end
