//
//  RSLoginViewController.m
//  Stscm
//
//  Created by mac on 2020/7/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSLoginViewController.h"

@interface RSLoginViewController ()
{
    UIButton * _passwordBtn;
    
    UIButton * _codeBtn;
    
    UILabel * _codeName;
    
    RJTextField * _account;
    
    RJTextField * _password;
    
    UIButton * _button;
    
}



@end

@implementation RSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRegisterUIView:self.view andTitle:@"登录"];
    self.emptyView.hidden = YES;
    //    self.tableview.hidden = YES;
    
    [self setUi];
    
}

- (void)setUi{
    
    UIButton * passwordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwordBtn setTitle:@"密码登录" forState:UIControlStateNormal];
    [passwordBtn setTitleColor:[UIColor colorWithHexColorStr:@"#9B9B9B"] forState:UIControlStateNormal];
    passwordBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [passwordBtn setTitleColor:[UIColor colorWithHexColorStr:@"#2E2E2E"] forState:UIControlStateSelected];
    [self.view addSubview:passwordBtn];
    [passwordBtn addTarget:self action:@selector(changPassworkAction:) forControlEvents:UIControlEventTouchUpInside];
    passwordBtn.selected = YES;
    _passwordBtn = passwordBtn;
    
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#9B9B9B"];
    [self.view addSubview:midView];
    
    
    UIButton * codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [codeBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
    [codeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#9B9B9B"] forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [codeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#2E2E2E"] forState:UIControlStateSelected];
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
    name.textColor = [UIColor colorWithHexColorStr:@"#393939"];
    name.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:name];
    
    
    RJTextField * account = [[RJTextField alloc]init];
    account.placeholder = @"请输入手机号";
    account.maxLength = 11;
    account.errorStr = @"超出字数限制";
    account.type = @"phone";
    account.textField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:account];
    _account = account;
    
    
    
    UILabel * codeName = [[UILabel alloc]init];
    codeName.text = @"密码";
    codeName.textAlignment = NSTextAlignmentLeft;
    codeName.textColor = [UIColor colorWithHexColorStr:@"#393939"];
    codeName.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:codeName];
    _codeName = codeName;
    
    RJTextField * password = [[RJTextField alloc]init];
    password.placeholder = @"请输入密码";
    password.maxLength = 18;
    password.errorStr = @"超出字数限制";
    password.type = @"password";
    password.textField.keyboardType = UIKeyboardTypeASCIICapable;
    password.textField.secureTextEntry = YES;
    [self.view addSubview:password];
    _password = password;
    
    
    
    
    
    UIButton * button = [[SmsButtonHandle sharedSmsBHandle]buttonWithTitle:@"获取验证码" action:@selector(buttonAction:) superVC:self];
    [button setTitle:@"" forState:UIControlStateNormal];
    
    
    if (_passwordBtn.selected == YES) {
        [button setImage:[UIImage imageNamed:@"关眼睛"] forState:UIControlStateNormal];
        
    }
    
    [self.view addSubview:button];
    _button = button;
    
    
    
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FCC828"]];
    [loginBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:loginBtn];
    
    
    
    NSDictionary * underAttribtDic  = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor colorWithRed:252/255.0 green:200/255.0 blue:40/255.0 alpha:1.0]};
    NSMutableAttributedString * underAttr = [[NSMutableAttributedString alloc] initWithString:@"没有账号,去注册" attributes:underAttribtDic];
    UIButton * accountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [accountBtn setAttributedTitle:underAttr forState:UIControlStateNormal];
    accountBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:accountBtn];
    
    
    UIButton * choiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [choiceBtn setImage:[UIImage imageNamed:@"未选"] forState:UIControlStateNormal];
    [choiceBtn setImage:[UIImage imageNamed:@"选择备份"] forState:UIControlStateSelected];
    [self.view addSubview:choiceBtn];
    
    
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
    
    
}


- (void)buttonAction:(UIButton *)btn{
    
    if (_passwordBtn.selected == YES) {
        
        btn.selected = !btn.selected;
        if (btn.selected) {
            [btn setImage:[UIImage imageNamed:@"眼睛"] forState:UIControlStateNormal];
            _password.textField.secureTextEntry = NO;
            
        }else{
            [btn setImage:[UIImage imageNamed:@"关眼睛"] forState:UIControlStateNormal];
            _password.textField.secureTextEntry = YES;
        }
    }else{
        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        //[button setImage:[UIImage imageNamed:@"关眼睛"] forState:UIControlStateNormal]
        NSLog(@"按钮事件");
        //此处可以先调接口，成功后再调此方法
        [[SmsButtonHandle sharedSmsBHandle] startTimer];
    }
}


- (void)changPassworkAction:(UIButton *)btn{
    btn.selected = YES;
    _codeBtn.selected = NO;
    _codeName.text = @"密码";
    _account.textField.text = @"";
    _password.textField.text = @"";
    _password.placeholder = @"请输入密码";
    _password.maxLength = 18;
    _password.errorStr = @"超出字数限制";
    _password.type = @"passwork";
    _password.textField.secureTextEntry = YES;
    [_button setImage:[UIImage imageNamed:@"关眼睛"] forState:UIControlStateNormal];
    [_button setTitle:@"" forState:UIControlStateNormal];
    
}


- (void)changCodeAction:(UIButton *)btn{
    btn.selected = YES;
    _passwordBtn.selected = NO;
    _codeName.text = @"验证码";
    
    _account.textField.text = @"";
    _password.textField.text = @"";
    _password.placeholder = @"请输入验证码";
    _password.maxLength = 6;
    _password.errorStr = @"超出字数限制";
    _password.type = @"phone";
    [_button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_button setTitle:@"获取验证码" forState:UIControlStateNormal];

}


@end
