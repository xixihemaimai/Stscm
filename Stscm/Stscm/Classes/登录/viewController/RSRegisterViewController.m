//
//  RSRegisterViewController.m
//  Stscm
//
//  Created by mac on 2020/7/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSRegisterViewController.h"

#import "RSPasswordViewController.h"

#import "RSLoginViewController.h"


@interface RSRegisterViewController ()

@property (nonatomic,strong) RJTextField * account;

@property (nonatomic,strong) RJTextField * password;

@property (nonatomic,strong) UIButton * choiceBtn;

@property(strong,nonatomic)UIButton * againBtn;

@end

@implementation RSRegisterViewController

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRegisterUIView:self.view andTitle:@"注册"];
    self.emptyView.hidden = YES;
    [self setUi];
//    NSString * number = @"123.4444";
//    NSLog(@"=========================%@",[number yxy_stringByAdding:@"0.00000"]);
}
//创建界面
- (void)setUi{
    UILabel * name = [[UILabel alloc]init];
    name.text = @"手机号";
    name.textAlignment = NSTextAlignmentLeft;
    name.textColor = [UIColor colorLabelWithDyColorChangObject];
    name.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:name];
    
    RJTextField * account = [[RJTextField alloc]init];
    account.maxLength = 11;
    
    [self.view addSubview:account];
    _account = account;
    
    UILabel * codeName = [[UILabel alloc]init];
    codeName.text = @"验证码";
    codeName.textAlignment = NSTextAlignmentLeft;
    codeName.textColor = [UIColor colorLabelWithDyColorChangObject];
    codeName.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:codeName];
    
    RJTextField * password = [[RJTextField alloc]init];
    password.maxLength = 6;
    [self.view addSubview:password];
    _password = password;
    
    account.placeholder = @"请输入手机号";
    password.placeholder = @"请输入验证码";
    
    account.maxLength = 11;
    account.errorStr = @"超出字数限制";
    account.type = @"phone";
    
    password.maxLength = 6;
    password.errorStr = @"超出字数限制";
    password.type = @"phone";
    
    account.textField.keyboardType = UIKeyboardTypePhonePad;
    password.textField.keyboardType = UIKeyboardTypePhonePad;
    
    account.textColor = [UIColor colorLabelWithDyColorChangObject];
    password.textColor = [UIColor colorLabelWithDyColorChangObject];
    
    UIButton * againBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [againBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    againBtn.userInteractionEnabled = YES;
    [againBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    againBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [againBtn setTitleColor:[UIColor colorButtonNormalWithDyColorChangObject] forState:UIControlStateNormal];
    [self.view addSubview:againBtn];
    _againBtn = againBtn;
    
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FCC828"]];
    [registerBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
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
    
    registerBtn.sd_layout
    .rightEqualToView(password)
    .leftEqualToView(password)
    .topSpaceToView(password, 48.5)
    .heightIs(49);
    
    registerBtn.layer.cornerRadius = 27;
    registerBtn.layer.masksToBounds = YES;
    
    againBtn.sd_layout
    .rightSpaceToView(self.view, 35)
    .topSpaceToView(codeName, 20)
    .widthIs(70)
    .heightIs(20);
    
    accountBtn.sd_layout
    .leftEqualToView(registerBtn)
    .rightEqualToView(registerBtn)
    .topSpaceToView(registerBtn, 39)
    .heightIs(20);
    
    choiceBtn.sd_layout
    .leftSpaceToView(self.view, 72)
    .bottomSpaceToView(self.view, 33)
    .widthIs(20)
    .heightEqualToWidth();
    
    choiceLabel.sd_layout
    .leftSpaceToView(choiceBtn, 0)
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
    
    name.text = @"手机号";
    codeName.text = @"验证码";
    againBtn.hidden = NO;
}

//FIXME:获取验证码的按键
- (void)buttonAction:(UIButton *)sender{
    NSLog(@"----------------%@",_account.textField.text);
    NSLog(@"按钮事件");
    if (![self isTrueMobile:_account.textField.text]) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的电话号码"];
        jxt_showToastMessage(@"请输入正确的手机号", 0.75);
    }else{
        //此处可以先调接口，成功后再调此方法
        [self messageTimeUbutton:sender];
        RSWeakself
        NSString * phone = [NSString string];
        [RSNetworkTool netWorkToolWebServiceDataUrl:URL_IMAGE_GET_IOS andType:@"GET" withParameters:phone andURLName:URL_IMAGE_GET_IOS andContentType:@"JSON" withBlock:^(id  _Nonnull responseObject, BOOL success) {
                    NSLog(@"=========================%@",responseObject);
                    //这边是获取图片和位置
                    //这边是成功之后的值
                    MockVerifyView *verifyView = [[MockVerifyView alloc] init];
                    verifyView.bigImage = [self baseWith64EncodedString:responseObject[@"data"][@"bigImage"]];
                    verifyView.smallImage = [self baseWith64EncodedString:responseObject[@"data"][@"smallImage"]];
                    verifyView.Y = [responseObject[@"data"][@"yStart"] doubleValue];
                    verifyView.verifyId = responseObject[@"data"][@"verifyId"];
                    [verifyView showView];
                    //这边需要把返回的vcode值传回来在进行发送短信
                    verifyView.mockBlock = ^(NSString * accesskey) {
                    NSString * phoneNumber = [NSString stringWithFormat:@"phoneNumber=%@&accessKey=%@",weakSelf.account.textField.text,accesskey];
                    [RSNetworkTool netWorkToolWebServiceDataUrl:URL_CODE_SEND_IOS andType:@"GET" withParameters:phoneNumber andURLName:URL_CODE_SEND_IOS andContentType:@"JSON" withBlock:^(id  _Nonnull responseObject, BOOL success) {
                       NSLog(@"---------------%@",responseObject);
                    }];
               };
           }];
//        NSString * phoneNumber = [NSString stringWithFormat:@"phoneNumber=%@",_account.textField.text];
//        //这边要对发短信
//        [RSNetworkTool netWorkToolWebServiceDataUrl:URL_CODE_SEND_IOS andType:@"GET" withParameters:phoneNumber andURLName:URL_CODE_SEND_IOS andContentType:@"JSON" withBlock:^(id  _Nonnull responseObject, BOOL success) {
//            NSLog(@"---------------%@",responseObject);
//        }];
    }
}
//FIXME:是否同意需要隐私按键
- (void)choiceAction:(UIButton *)choiceBtn{
    choiceBtn.selected = !choiceBtn.selected;
}


//FIXME:跳转到登录界面
- (void)jumpLoginAction:(UIButton *)jumpLoginBtn{
//    if ([[self backViewController]isKindOfClass:[RSLoginViewController class]]){
//          //上一个控制器为注册页面
//          NSLog(@"++++++++++++++++++++++++++++++++++");
//          [self.navigationController popViewControllerAnimated:YES];
//      }else{
//          NSLog(@"-----------------------------------------");
          RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
          [self.navigationController pushViewController:loginVc animated:YES];
//      }
}



//FIXME:注册方法
- (void)registerAction:(UIButton *)registerBtn{
    //电话号码验证
    if (![self isTrueMobile:_account.textField.text]) {
        jxt_showToastMessage(@"请输入正确的电话号码", 0.75);
        return;
    }
    if (_password.textField.text.length < 6 || _password.textField.text.length > 6) {
        jxt_showToastMessage(@"请输入正确验证码", 0.75);
        return;
    }
    if (_choiceBtn.selected != YES) {
        jxt_showToastMessage(@"请同意隐私政策", 0.75);
        
        return;
    }
    NSString * phoneNumber = [NSString stringWithFormat:@"phoneNumber=%@&verificationCode=%@",_account.textField.text,_password.textField.text];
    //这边要对发短信
    [RSNetworkTool netWorkToolWebServiceDataUrl:URL_CODE_CHECK_IOS andType:@"GET" withParameters:phoneNumber andURLName:URL_CODE_CHECK_IOS  andContentType:@"JSON" withBlock:^(id  _Nonnull responseObject, BOOL success) {
        RSPasswordViewController * passwordVc = [[RSPasswordViewController alloc]init];
        passwordVc.phoneStr = self.account.textField.text;
        passwordVc.codeStr = self.password.textField.text;
        [self.navigationController pushViewController:passwordVc animated:YES];
    }];
}
@end
