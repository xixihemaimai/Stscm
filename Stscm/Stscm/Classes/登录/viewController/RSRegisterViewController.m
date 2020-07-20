//
//  RSRegisterViewController.m
//  Stscm
//
//  Created by mac on 2020/7/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSRegisterViewController.h"

@interface RSRegisterViewController ()

@end

@implementation RSRegisterViewController

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
    
       
    RJTextField * password = [[RJTextField alloc]init];
    [self.view addSubview:password];
    
//    account.placeholder = @"请输入手机号";
//    account.maxLength = 11;
//    account.errorStr = @"超出字数限制";
    account.type = @"phone";
    account.textField.keyboardType = UIKeyboardTypePhonePad;
          
          
//    password.placeholder = @"请输入验证码";
//    password.maxLength = 6;
//    password.errorStr = @"超出字数限制";
    password.type = @"phone";
    password.textField.keyboardType = UIKeyboardTypePhonePad;
    
     if ([self.type isEqualToString:@"phone"]) {
         NSLog(@"=------------------------------------------------------");
         account.placeholder = @"请输入手机号";
         password.placeholder = @"请输入验证码";
         
         account.maxLength = 11;
         account.errorStr = @"超出字数限制";
         account.type = @"phone";
         
         password.maxLength = 6;
         password.errorStr = @"超出字数限制";
         password.type = @"phone";
     }else{
         NSLog(@"=++++++++++++++++++++++++++++++++++++++++++++++++++++++");
         account.placeholder = @"请输入密码";
         password.placeholder = @"请再次输入密码";
                
         account.maxLength = 18;
         account.errorStr = @"超出字数限制";
         account.type = @"phone";
                
         password.maxLength = 18;
         password.errorStr = @"超出字数限制";
         password.type = @"phone";
     }

    UIButton * button = [[SmsButtonHandle sharedSmsBHandle]buttonWithTitle:@"获取验证码" action:@selector(buttonAction) superVC:self];
    [self.view addSubview:button];
    
    
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
    [self.view addSubview:loginBtn];
    
    UIButton * jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jumpBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [jumpBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FCC828"] forState:UIControlStateNormal];
    jumpBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:jumpBtn];
    
    NSDictionary * underAttribtDic  = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor colorWithRed:252/255.0 green:200/255.0 blue:40/255.0 alpha:1.0]};
    NSMutableAttributedString * underAttr = [[NSMutableAttributedString alloc] initWithString:@"已有账号，去登录" attributes:underAttribtDic];
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
    
    button.sd_layout
    .rightSpaceToView(self.view, 35)
    .topSpaceToView(codeName, 20)
    .widthIs(70)
    .heightIs(20);
    
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
    
    if ([self.type isEqualToString:@"phone"]) {
        
        name.text = @"手机号";
        codeName.text = @"验证码";
        
        
        
        accountBtn.hidden = YES;
        jumpBtn.hidden = YES;
        alertLabel.hidden = YES;
        button.hidden = NO;
        
    }else{
        name.text = @"密码";
        codeName.text = @"确认密码";
        
       
        accountBtn.hidden = NO;
        jumpBtn.hidden = NO;
        alertLabel.hidden = NO;
        button.hidden = YES;
        
        
        
    }
    
    
}

- (void)buttonAction{
    NSLog(@"按钮事件");
    //此处可以先调接口，成功后再调此方法
    [[SmsButtonHandle sharedSmsBHandle] startTimer];
}



@end
