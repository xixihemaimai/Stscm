//
//  RSLoginViewController.m
//  Stscm
//
//  Created by mac on 2020/7/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSLoginViewController.h"
/**主界面*/
#import "RSMainViewController.h"


@interface RSLoginViewController ()
{
    UIButton * _passwordBtn;
    
    UIButton * _codeBtn;
    
    UILabel * _codeName;
    
    UIButton * _button;
}

@property (nonatomic,strong) RJTextField * account;

@property (nonatomic,strong) RJTextField * password;

@property (nonatomic,strong) UIButton * choiceBtn;

@end

@implementation RSLoginViewController

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRegisterUIView:self.view andTitle:@"登录"];
    self.emptyView.hidden = YES;
    [self setUi];
}

- (void)setUi{
    UIButton * passwordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwordBtn setTitle:@"密码登录" forState:UIControlStateNormal];
    [passwordBtn setTitleColor:[UIColor colorButtonNormalWithDyColorChangObject] forState:UIControlStateNormal];
    passwordBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [passwordBtn setTitleColor:[UIColor colorButtonSelectWithDyColorChangObject] forState:UIControlStateSelected];
    [self.view addSubview:passwordBtn];
    [passwordBtn addTarget:self action:@selector(changPassworkAction:) forControlEvents:UIControlEventTouchUpInside];
    passwordBtn.selected = YES;
    _passwordBtn = passwordBtn;
    
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorButtonNormalWithDyColorChangObject];
    [self.view addSubview:midView];
    
    UIButton * codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [codeBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
    [codeBtn setTitleColor:[UIColor colorButtonNormalWithDyColorChangObject] forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [codeBtn setTitleColor:[UIColor colorButtonSelectWithDyColorChangObject] forState:UIControlStateSelected];
    [codeBtn addTarget:self action:@selector(changCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeBtn];
    codeBtn.selected = NO;
    _codeBtn = codeBtn;
    
    passwordBtn.sd_layout
    .leftSpaceToView(self.view, 35)
    .topSpaceToView(self.view, 166)
    .widthIs(50)
    .heightIs(16.5);
    
    midView.sd_layout
    //    .topEqualToView(passwordBtn)
    //    .bottomEqualToView(passwordBtn)
    .leftSpaceToView(passwordBtn, 6)
    .topSpaceToView(self.view, 170)
    .heightIs(8.5)
    .widthIs(0.5);
    
    codeBtn.sd_layout
    .leftSpaceToView(midView, 6)
    .topEqualToView(passwordBtn)
    .bottomEqualToView(passwordBtn)
    .widthIs(65);
    
    UILabel * name = [[UILabel alloc]init];
    name.text = @"手机号";
    name.textAlignment = NSTextAlignmentLeft;
    name.textColor = [UIColor colorLabelWithDyColorChangObject];
    name.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:name];
    
    RJTextField * account = [[RJTextField alloc]init];
    account.placeholder = @"请输入手机号";
    account.maxLength = 11;
    account.errorStr = @"超出字数限制";
    account.type = @"vcode";
    account.textField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:account];
    _account = account;
    
    UILabel * codeName = [[UILabel alloc]init];
    codeName.text = @"密码";
    codeName.textAlignment = NSTextAlignmentLeft;
    codeName.textColor = [UIColor colorLabelWithDyColorChangObject];
    codeName.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:codeName];
    _codeName = codeName;
    
    RJTextField * password = [[RJTextField alloc]init];
    password.placeholder = @"请输入密码";
    password.maxLength = 18;
    password.errorStr = @"超出字数限制";
    password.type = @"pwd";
    password.textField.keyboardType = UIKeyboardTypeASCIICapable;
    password.textField.secureTextEntry = YES;
    [self.view addSubview:password];
    _password = password;
    
    account.textColor = [UIColor colorLabelWithDyColorChangObject];
    password.textColor = [UIColor colorLabelWithDyColorChangObject];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.userInteractionEnabled = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[UIColor colorWithHexColorStr:@"#9B9B9B"] forState:UIControlStateNormal];
    if (_passwordBtn.selected == YES) {
        [button setImage:[UIImage imageNamed:@"关眼睛"] forState:UIControlStateNormal];
        [button setTitle:@"" forState:UIControlStateNormal];
    }
    
    [self.view addSubview:button];
    _button = button;

    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FCC828"]];
    [loginBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    NSDictionary * underAttribtDic  = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor colorWithRed:252/255.0 green:200/255.0 blue:40/255.0 alpha:1.0]};
    NSMutableAttributedString * underAttr = [[NSMutableAttributedString alloc] initWithString:@"没有账号,去注册" attributes:underAttribtDic];
    UIButton * accountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [accountBtn setAttributedTitle:underAttr forState:UIControlStateNormal];
    accountBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [accountBtn addTarget:self action:@selector(jumpRegisterAction:) forControlEvents:UIControlEventTouchUpInside];
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
    .topSpaceToView(passwordBtn, 53.5)
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
    
    loginBtn.sd_layout
    .rightEqualToView(password)
    .leftEqualToView(password)
    .topSpaceToView(password, 48.5)
    .heightIs(49);
    
    loginBtn.layer.cornerRadius = 27;
    loginBtn.layer.masksToBounds = YES;
    
    button.sd_layout
    .rightSpaceToView(self.view, 35)
    .topSpaceToView(codeName, 20)
    .widthIs(70)
    .heightIs(20);
    
    accountBtn.sd_layout
    .leftEqualToView(loginBtn)
    .rightEqualToView(loginBtn)
    .topSpaceToView(loginBtn, 21.5)
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
}

- (void)buttonAction:(UIButton *)btn{
    if (_passwordBtn.selected == YES) {
        // 密码
        btn.selected = !btn.selected;
        if (btn.selected) {
            [btn setImage:[UIImage imageNamed:@"眼睛"] forState:UIControlStateNormal];
            _password.textField.secureTextEntry = NO;
        }else{
            [btn setImage:[UIImage imageNamed:@"关眼睛"] forState:UIControlStateNormal];
            _password.textField.secureTextEntry = YES;
        }
    }else{
        //验证码
        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (![self isTrueMobile:_account.textField.text]) {
            [SVProgressHUD setMinimumDismissTimeInterval:0.3];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:@"请输入正确的电话号码"];
        }else{
            //此处可以先调接口，成功后再调此方法
            [self messageTimeUbutton:btn];
            NSString * phoneNumber = [NSString stringWithFormat:@"phoneNumber=%@",_account.textField.text];
            //这边要对发短信
            [RSNetworkTool netWorkToolWebServiceDataUrl:URL_CODE_SEND_IOS andType:@"GET" withParameters:phoneNumber andURLName:URL_CODE_SEND_IOS andContentType:@"JSON" withBlock:^(id  _Nonnull responseObject, BOOL success) {
                NSLog(@"---------------%@",responseObject);
            }];
        }
    }
}
//FIXME:是否同意需要隐私按键
- (void)choiceAction:(UIButton *)choiceBtn{
    choiceBtn.selected = !choiceBtn.selected;
}

- (void)changPassworkAction:(UIButton *)btn{
    btn.selected = YES;
    _codeBtn.selected = NO;
    _codeName.text = @"密码";
//    _account.textField.text = @"";
    _password.textField.text = @"";
    _password.textField.keyboardType = UIKeyboardTypeDefault;
    _password.placeholder = @"请输入密码";
    _password.maxLength = 18;
    _password.errorStr = @"超出字数限制";
    _password.type = @"pwd";
    _password.textField.secureTextEntry = YES;
    [_button setImage:[UIImage imageNamed:@"关眼睛"] forState:UIControlStateNormal];
    [_button setTitle:@"" forState:UIControlStateNormal];
}

- (void)changCodeAction:(UIButton *)btn{
    btn.selected = YES;
    _passwordBtn.selected = NO;
    _codeName.text = @"验证码";
//    _account.textField.text = @"";
    _password.textField.text = @"";
    _password.placeholder = @"请输入验证码";
    _password.maxLength = 6;
    _password.errorStr = @"超出字数限制";
    _password.textField.keyboardType = UIKeyboardTypePhonePad;
    _password.type = @"vcode";
    [_button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_button setTitle:@"获取验证码" forState:UIControlStateNormal];
}
//MARK:登录的
- (void)loginAction:(UIButton *)loginBtn{
    RSWeakself
    NSString * type = [NSString string];
    if (_passwordBtn.selected == YES) {
        //密码登录
        //手机号
        if (![self isTrueMobile:_account.textField.text]) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
            return;
        }
        //密码
        if(![self validatePassword:_password.textField.text])
        {
            jxt_showToastMessage(@"请设置注册密码", 0.75);
            return;
        }
        if (_password.textField.text.length<6)
        {
            jxt_showToastMessage(@"请设置6-18位密码", 0.75);
            return;
        }
        if (_password.textField.text.length>18)
        {
            jxt_showToastMessage(@"请设置6-18位密码", 0.75);
            return;
        }
        //是否同意隐私政策
        if (_choiceBtn.selected != YES) {
            [SVProgressHUD showErrorWithStatus:@"请同意隐私政策"];
            return;
        }
        type = @"pwd";
    }else{
        //验证码登录
        //手机号
        if (![self isTrueMobile:_account.textField.text]) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
            return;
        }
        //验证码
        if (_password.textField.text.length < 6 || _password.textField.text.length > 6) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确验证码"];
            return;
        }
        //是否同意隐私政策
        if (_choiceBtn.selected != YES) {
            [SVProgressHUD showErrorWithStatus:@"请同意隐私政策"];
            return;
        }
        type = @"vcode";
    }
    
     NSString * code = [NSString string];
     NSString * pwd = [NSString string];
    if ([type isEqualToString:@"pwd"]) {
        pwd = _password.textField.text;
        code = @"";
    }else{
        pwd = @"";
        code = _password.textField.text;
    }
    
    NSString* deviceName = [self getDeviceName];
    NSLog(@"设备名称: %@",deviceName );
    
    NSLog(@"------------111143434------------------------%@",self.placeMark);
    if (self.placeMark == nil) {
        self.placeMark = @"未知";
    }
    [self reloadUdid:^(BOOL isValue,NSString * PublickKeyTemp,NSString * Ukey) {
        if (isValue && PublickKeyTemp.length > 0) {
            jxt_showLoadingHUDTitleMessage(@"正在执行登录中", nil);
            NSLog(@"-----------------------%@",PublickKeyTemp);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [RSNetworkTool loginUserUrl:URL_LOGIN_IOS requestType:@"POST" SopaStrPasswordAndCodeType:type andPasswordAndCode:code andPhoneNumber:weakSelf.account.textField.text andPasswordStr:pwd andPKey:PublickKeyTemp andUkey:Ukey andContentType:@"JSON" andLoginMode:@"0" andComputerName:deviceName andLoginArea:self.placeMark andBlock:^(id  _Nonnull responseObject, BOOL success) {
                     NSLog(@"-----11111--------------%@",responseObject);
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        jxt_dismissHUD();
                        //登录之后要获取用户信息，然后在跳转到下面的界面
                        //改变根控制器
                        RSMainViewController * mainVc = [[RSMainViewController alloc]init];
                        AppDelegate * appdelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
                        appdelegate.window.rootViewController = mainVc;
                    });
                }];
            });
        }else{
            jxt_showToastTitle(@"登录失败", 0.75);
        }
    }];
}

- (void)reloadUdid:(void(^)(BOOL isValue,NSString * PublickKeyTemp,NSString * Ukey))Obtain{
    //设备的唯一标识号
    NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString * uKey = [NSString stringWithFormat:@"uKey=%@",udid];
    [RSNetworkTool netWorkToolWebServiceDataUrl:URL_KEY_GET_IOS andType:@"GET" withParameters:uKey andURLName:URL_KEY_GET_IOS andContentType:@"JSON" withBlock:^(id  _Nonnull responseObject, BOOL success) {
        NSLog(@"============323232==================%@",responseObject);
//        NSLog(@"==============================%@",self.PublickKeyTemp);
        if (Obtain) {
          Obtain(true,responseObject[@"data"][@"pKey"],responseObject[@"data"][@"uKey"]);
        }
    }];
}
//FIXME:返回到注册界面
- (void)jumpRegisterAction:(UIButton *)backBtn{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
