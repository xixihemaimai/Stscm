//
//  RSChagePhoneNumberViewController.m
//  Stscm
//
//  Created by mac on 2020/8/11.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSChagePhoneNumberViewController.h"

#import "XWCountryCodeController.h"

//注册的界面
#import "RSRegisterViewController.h"


@interface RSChagePhoneNumberViewController ()

@property (nonatomic,strong)UITextField * phoneTextfield;

@property (nonatomic,strong)UITextField * passwordTextfield;

@property (nonatomic,strong)UIButton * areaBtn;

@property (nonatomic,strong)UILabel * areaLabel;

@property (nonatomic,strong)UILabel * phoneNumberLabel;

@property (nonatomic,strong)UIButton * nextBtn;

@property (nonatomic,assign)NSInteger i;


@end

@implementation RSChagePhoneNumberViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.emptyView.hidden = YES;
    self.tableview.hidden = YES;
    self.i = 0;
    //清除导航栏下面横线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    if (self.phoneType == 1) {
        [self setPhoneNumberCustomUI];
    }else if (self.phoneType == 2){
        [self setNewPhoneNumberCustomUI];
    }else if(self.phoneType == 3){
        NSString * phone = [self.phoneStr stringByReplacingCharactersInRange:NSMakeRange(self.phoneStr.length - 9, 4)  withString:@"****"];
        NSLog(@"===================%@",self.phoneStr);
        [self setPhoneNumberCodeUI:phone];
    }else if (self.phoneType == 4){
        NSString * phoneTotal = [self.phoneStr stringByReplacingCharactersInRange:NSMakeRange(self.phoneStr.length - 8, 4)  withString:@"****"];
        NSString * phone = [NSString stringWithFormat:@"%@ ",[phoneTotal substringToIndex:3]];
        NSString * mid = [NSString stringWithFormat:@"%@ ",[phoneTotal substringWithRange:NSMakeRange(3, 4)]];
        NSString * str = [NSString stringWithFormat:@"%@ ",[phoneTotal substringWithRange:NSMakeRange(7, 4)]];
        phoneTotal = [NSString stringWithFormat:@"%@%@%@",phone,mid,str];
        NSLog(@"===================%@",self.phoneStr);
        [self setChagePasswordCustomUI:phoneTotal];
    }
}

- (void)setPhoneNumberCustomUI{
    //这边设置标题栏
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#2e2e2e"];
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.text = @"请输入原手机号";
    [self.view addSubview:titleLabel];
    //简介栏
    UILabel * briefLabel = [[UILabel alloc]init];
    briefLabel.textColor = [UIColor colorWithHexColorStr:@"#9B9B9B"];
    briefLabel.font = [UIFont systemFontOfSize:12];
    briefLabel.text = @"通过安全环境检查可以换绑";
    [self.view addSubview:briefLabel];
    //电话号码区
    UIView * inputView = [[UIView alloc]init];
    inputView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    [self.view addSubview:inputView];
    
    UIButton * areaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [areaBtn setTitle:@"+86" forState:UIControlStateNormal];
    [areaBtn setTitleColor: [UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    areaBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [areaBtn addTarget:self action:@selector(choiceAreaNumberAction:) forControlEvents:UIControlEventTouchUpInside];
    areaBtn.tag = 1;
    [inputView addSubview:areaBtn];
    _areaBtn = areaBtn;
    
    UIImageView * downImage = [[UIImageView alloc]init];
    downImage.image = [UIImage imageNamed:@"Shape"];
    [inputView addSubview:downImage];
    
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#979797"];
    [inputView addSubview:midView];
    
    UITextField * phoneTextfield = [[UITextField alloc]init];
    phoneTextfield.placeholder = @"请输入电话号码";
    phoneTextfield.tag = 1;
//    phoneTextfield.delegate = self;
    phoneTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    phoneTextfield.font = [UIFont systemFontOfSize:17];
    [inputView addSubview:phoneTextfield];
    [phoneTextfield addTarget:self action:@selector(textFieldEditChanged:)forControlEvents:UIControlEventEditingChanged];
    _phoneTextfield = phoneTextfield;
    
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"system- defeated"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:deleteBtn];
    
    //按键
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    nextBtn.tag = 1;
    [nextBtn addTarget:self action:@selector(nextAndCompleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D8D8DA"]];
    [self.view addSubview:nextBtn];
    _nextBtn = nextBtn;
    
    titleLabel.sd_layout
    .leftSpaceToView(self.view, 33.5)
    .rightSpaceToView(self.view, 33.5)
    .topSpaceToView(self.navigationController.navigationBar, 56)
    .heightIs(34);
    
    
    briefLabel.sd_layout
    .leftEqualToView(titleLabel)
    .rightEqualToView(titleLabel)
    .topSpaceToView(titleLabel, 2.5)
    .heightIs(16.5);
    
    inputView.sd_layout
    .leftEqualToView(briefLabel)
    .rightSpaceToView(self.view, 36.5)
    .topSpaceToView(briefLabel, 18.5)
    .heightIs(40);
    
    areaBtn.sd_layout
    .centerYEqualToView(inputView)
    .leftSpaceToView(inputView, 12.5)
    .heightIs(24)
    .widthIs(40);
    
    downImage.sd_layout
    .centerYEqualToView(areaBtn)
    .leftSpaceToView(areaBtn, 3.5)
    .widthIs(10.22)
    .heightIs(4.88);
    
    midView.sd_layout
    .centerYEqualToView(inputView)
    .topSpaceToView(inputView, 13)
    .bottomSpaceToView(inputView, 13)
    .widthIs(0.5)
    .leftSpaceToView(downImage, 10);
    
    phoneTextfield.sd_layout
    .centerYEqualToView(inputView)
    .leftSpaceToView(midView, 10)
    .topSpaceToView(inputView, 0)
    .bottomSpaceToView(inputView, 0)
    .widthRatioToView(inputView, 0.5);
    
    deleteBtn.sd_layout
    .centerYEqualToView(inputView)
    .rightSpaceToView(inputView, 15)
    .widthIs(20)
    .heightEqualToWidth();
    
    nextBtn.sd_layout
    .leftSpaceToView(self.view, 35)
    .rightSpaceToView(self.view, 35)
    .topSpaceToView(inputView, 30)
    .heightIs(49);
    
    nextBtn.layer.cornerRadius = 27;
    nextBtn.layer.masksToBounds = YES;
}

- (void)setNewPhoneNumberCustomUI{
    //这边设置标题栏
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#2e2e2e"];
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.text = @"请输入新手机号";
    [self.view addSubview:titleLabel];
    //简介栏
    UILabel * briefLabel = [[UILabel alloc]init];
    briefLabel.textColor = [UIColor colorWithHexColorStr:@"#9B9B9B"];
    briefLabel.font = [UIFont systemFontOfSize:12];
    briefLabel.text = @"换绑新手机号之后，可以用新的手机号及当前密码登录";
    [self.view addSubview:briefLabel];
    //电话号码区
    UIView * inputView = [[UIView alloc]init];
    inputView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    [self.view addSubview:inputView];
    
    UIButton * areaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [areaBtn setTitle:@"+86" forState:UIControlStateNormal];
    areaBtn.tag = 2;
    [areaBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    areaBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [areaBtn addTarget:self action:@selector(choiceAreaNumberAction:) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:areaBtn];
    _areaBtn = areaBtn;
    
    UIImageView * downImage = [[UIImageView alloc]init];
    downImage.image = [UIImage imageNamed:@"Shape"];
    [inputView addSubview:downImage];
    
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#979797"];
    [inputView addSubview:midView];
    
    UITextField * phoneTextfield = [[UITextField alloc]init];
    phoneTextfield.placeholder = @"请输入电话号码";
    phoneTextfield.tag = 2;
//    phoneTextfield.delegate = self;
    phoneTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    phoneTextfield.font = [UIFont systemFontOfSize:17];
    [inputView addSubview:phoneTextfield];
    [phoneTextfield addTarget:self action:@selector(textFieldEditChanged:)forControlEvents:UIControlEventEditingChanged];
    _phoneTextfield = phoneTextfield;
    
//    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [deleteBtn setImage:[UIImage imageNamed:@"system- defeated"] forState:UIControlStateNormal];
//    [inputView addSubview:deleteBtn];
    
    //按键
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    nextBtn.tag = 2;
    [nextBtn addTarget:self action:@selector(nextAndCompleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D8D8DA"]];
    [self.view addSubview:nextBtn];
     _nextBtn = nextBtn;
    
    titleLabel.sd_layout
    .leftSpaceToView(self.view, 33.5)
    .rightSpaceToView(self.view, 33.5)
    .topSpaceToView(self.navigationController.navigationBar, 56)
    .heightIs(34);
    
    
    briefLabel.sd_layout
    .leftEqualToView(titleLabel)
    .rightEqualToView(titleLabel)
    .topSpaceToView(titleLabel, 2.5)
    .heightIs(16.5);
    
    inputView.sd_layout
    .leftEqualToView(briefLabel)
    .rightSpaceToView(self.view, 36.5)
    .topSpaceToView(briefLabel, 18.5)
    .heightIs(40);
    
    areaBtn.sd_layout
    .centerYEqualToView(inputView)
    .leftSpaceToView(inputView, 12)
    .heightIs(24)
    .widthIs(50);
    
    downImage.sd_layout
    .centerYEqualToView(areaBtn)
    .leftSpaceToView(areaBtn, 3.5)
    .widthIs(10.22)
    .heightIs(4.88);
    
    midView.sd_layout
    .centerYEqualToView(inputView)
    .topSpaceToView(inputView, 13)
    .bottomSpaceToView(inputView, 13)
    .widthIs(0.5)
    .leftSpaceToView(downImage, 10);
    
    phoneTextfield.sd_layout
    .centerYEqualToView(inputView)
    .leftSpaceToView(midView, 10)
    .topSpaceToView(inputView, 0)
    .bottomSpaceToView(inputView, 0)
    .widthRatioToView(inputView, 0.5);
    
    nextBtn.sd_layout
    .leftSpaceToView(self.view, 35)
    .rightSpaceToView(self.view, 35)
    .topSpaceToView(inputView, 30)
    .heightIs(49);
    
    nextBtn.layer.cornerRadius = 27;
    nextBtn.layer.masksToBounds = YES;
}

- (void)setPhoneNumberCodeUI:(NSString *)phone{
    //这边设置标题栏
    UILabel * titleCodeLabel = [[UILabel alloc]init];
    titleCodeLabel.textColor = [UIColor colorWithHexColorStr:@"#2e2e2e"];
    titleCodeLabel.font = [UIFont systemFontOfSize:24];
    titleCodeLabel.text = @"请输入验证码";
    [self.view addSubview:titleCodeLabel];
    
    UILabel * briefCodeLabel = [[UILabel alloc]init];
    briefCodeLabel.textColor = [UIColor colorWithHexColorStr:@"#9B9B9B"];
    briefCodeLabel.font = [UIFont systemFontOfSize:12];
    briefCodeLabel.text = @"已向原手机";
    [self.view addSubview:briefCodeLabel];
    
    
    UILabel * areaLabel = [[UILabel alloc]init];
    areaLabel.text = self.areaStr;
    areaLabel.textColor = [UIColor colorWithHexColorStr:@"#FCC828"];
    areaLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:areaLabel];
    _areaLabel = areaLabel;
    
    UILabel * phoneNumberLabel = [[UILabel alloc]init];
    phoneNumberLabel.text = phone;
    phoneNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#FCC828"];
    phoneNumberLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:phoneNumberLabel];
    _phoneNumberLabel = phoneNumberLabel;
    
    UILabel * codeLabel = [[UILabel alloc]init];
    codeLabel.textColor = [UIColor colorWithHexColorStr:@"#9B9B9B"];
    codeLabel.font = [UIFont systemFontOfSize:12];
    codeLabel.text = @"发送验证码";
    [self.view addSubview:codeLabel];
    
    UITextField * phoneTextfield = [[UITextField alloc]init];
    phoneTextfield.placeholder = @"输入验证码";
    phoneTextfield.tag = 3;
//    phoneTextfield.delegate = self;
    phoneTextfield.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    [self.view addSubview:phoneTextfield];
    UIView * leftview = [[UIView alloc]init];
    phoneTextfield.leftView = leftview;
    phoneTextfield.leftViewMode = UITextFieldViewModeAlways;
    [phoneTextfield addTarget:self action:@selector(textFieldEditChanged:)forControlEvents:UIControlEventEditingChanged];
    _phoneTextfield = phoneTextfield;
    
    UIButton * sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendCodeBtn.userInteractionEnabled = YES;
    [sendCodeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F9F9F9"]];
    sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [sendCodeBtn addTarget:self action:@selector(sendCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [sendCodeBtn setTitleColor:[UIColor colorButtonNormalWithDyColorChangObject] forState:UIControlStateNormal];
    [self.view addSubview:sendCodeBtn];
    
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    nextBtn.tag = 3;
    [nextBtn addTarget:self action:@selector(nextAndCompleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D8D8DA"]];
    [self.view addSubview:nextBtn];
     _nextBtn = nextBtn;
    
    titleCodeLabel.sd_layout
    .leftSpaceToView(self.view, 33.5)
    .rightSpaceToView(self.view, 33.5)
    .topSpaceToView(self.navigationController.navigationBar, 56)
    .heightIs(34);
    
    briefCodeLabel.sd_layout
    .leftEqualToView(titleCodeLabel)
    .widthIs(65)
    .topSpaceToView(titleCodeLabel, 2.5)
    .heightIs(16.5);
    
    areaLabel.sd_layout
    .topEqualToView(briefCodeLabel)
    .bottomEqualToView(briefCodeLabel)
    .leftSpaceToView(briefCodeLabel, 0)
    .widthIs(25);
    
    phoneNumberLabel.sd_layout
    .topEqualToView(areaLabel)
    .bottomEqualToView(areaLabel)
    .leftSpaceToView(areaLabel, 5)
    .widthIs(85);
    
    codeLabel.sd_layout
    .leftSpaceToView(phoneNumberLabel, 0)
    .topEqualToView(phoneNumberLabel)
    .bottomEqualToView(phoneNumberLabel)
    .widthIs(70);
    
    phoneTextfield.sd_layout
    .leftEqualToView(briefCodeLabel)
    .topSpaceToView(briefCodeLabel, 18.5)
    .widthRatioToView(self.view, 0.6)
    .heightIs(40);
    
    leftview.sd_layout
    .widthIs(15.5);
    
    sendCodeBtn.sd_layout
    .topEqualToView(phoneTextfield)
    .bottomEqualToView(phoneTextfield)
    .leftSpaceToView(phoneTextfield, 4)
    .rightSpaceToView(self.view, 15);
    
    nextBtn.sd_layout
    .leftSpaceToView(self.view, 35)
    .rightSpaceToView(self.view, 35)
    .topSpaceToView(phoneTextfield, 30)
    .heightIs(49);
       
    nextBtn.layer.cornerRadius = 27;
    nextBtn.layer.masksToBounds = YES;
}

//修改密码界面
- (void)setChagePasswordCustomUI:(NSString *)phone{
    
    //这边设置标题栏
    UILabel * titleCodeLabel = [[UILabel alloc]init];
    titleCodeLabel.textColor = [UIColor colorWithHexColorStr:@"#2e2e2e"];
    titleCodeLabel.font = [UIFont systemFontOfSize:24];
    if ([UserInfoContext sharedUserInfoContext].userInfo.passwordSet == 0) {
        titleCodeLabel.text = @"设置密码";
    }else{
        titleCodeLabel.text = @"修改密码";
    }
    [self.view addSubview:titleCodeLabel];
    
    UILabel * briefCodeLabel = [[UILabel alloc]init];
    briefCodeLabel.textColor = [UIColor colorWithHexColorStr:@"#9B9B9B"];
    briefCodeLabel.font = [UIFont systemFontOfSize:12];
    briefCodeLabel.text = @"已向原手机";
    [self.view addSubview:briefCodeLabel];
    
    
    UILabel * areaLabel = [[UILabel alloc]init];
    areaLabel.text = self.areaStr;
    areaLabel.textColor = [UIColor colorWithHexColorStr:@"#FCC828"];
    areaLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:areaLabel];
    _areaLabel = areaLabel;
    
    UILabel * phoneNumberLabel = [[UILabel alloc]init];
    phoneNumberLabel.text = phone;
    phoneNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#FCC828"];
    phoneNumberLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:phoneNumberLabel];
    _phoneNumberLabel = phoneNumberLabel;
    
    UILabel * codeLabel = [[UILabel alloc]init];
    codeLabel.textColor = [UIColor colorWithHexColorStr:@"#9B9B9B"];
    codeLabel.font = [UIFont systemFontOfSize:12];
    codeLabel.text = @"发送验证码";
    [self.view addSubview:codeLabel];
    
    UITextField * phoneTextfield = [[UITextField alloc]init];
    phoneTextfield.placeholder = @"输入验证码";
    phoneTextfield.tag = 4;
//    phoneTextfield.delegate = self;
    phoneTextfield.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    [phoneTextfield addTarget:self action:@selector(textFieldEditChanged:)forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:phoneTextfield];
    _phoneTextfield = phoneTextfield;
    
    UIView * leftview = [[UIView alloc]init];
    phoneTextfield.leftView = leftview;
    phoneTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton * sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendCodeBtn.userInteractionEnabled = YES;
    [sendCodeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F9F9F9"]];
    sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [sendCodeBtn addTarget:self action:@selector(sendCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [sendCodeBtn setTitleColor:[UIColor colorButtonNormalWithDyColorChangObject] forState:UIControlStateNormal];
    [self.view addSubview:sendCodeBtn];
    
    UITextField * passwordTextfield = [[UITextField alloc]init];
    passwordTextfield.placeholder = @"输入新密码";
//    passwordTextfield.delegate = self;
    passwordTextfield.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    [self.view addSubview:passwordTextfield];
    UIView * passwordview = [[UIView alloc]init];
    passwordTextfield.leftView = passwordview;
    passwordTextfield.leftViewMode = UITextFieldViewModeAlways;
    [passwordTextfield addTarget:self action:@selector(textFieldEditChanged:)forControlEvents:UIControlEventEditingChanged];
    _passwordTextfield = passwordTextfield;
    
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    nextBtn.tag = 4;
    [nextBtn addTarget:self action:@selector(nextAndCompleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D8D8DA"]];
    [self.view addSubview:nextBtn];
    _nextBtn = nextBtn;
    
    titleCodeLabel.sd_layout
    .leftSpaceToView(self.view, 33.5)
    .rightSpaceToView(self.view, 33.5)
    .topSpaceToView(self.navigationController.navigationBar, 56)
    .heightIs(34);
    
    briefCodeLabel.sd_layout
    .leftEqualToView(titleCodeLabel)
    .widthIs(65)
    .topSpaceToView(titleCodeLabel, 2.5)
    .heightIs(16.5);
    
    areaLabel.sd_layout
    .topEqualToView(briefCodeLabel)
    .bottomEqualToView(briefCodeLabel)
    .leftSpaceToView(briefCodeLabel, 0)
    .widthIs(25);
    
    phoneNumberLabel.sd_layout
    .topEqualToView(areaLabel)
    .bottomEqualToView(areaLabel)
    .leftSpaceToView(areaLabel, 5)
    .widthIs(85);
    
    codeLabel.sd_layout
    .leftSpaceToView(phoneNumberLabel, 0)
    .topEqualToView(phoneNumberLabel)
    .bottomEqualToView(phoneNumberLabel)
    .widthIs(70);
    
    phoneTextfield.sd_layout
    .leftEqualToView(briefCodeLabel)
    .topSpaceToView(briefCodeLabel, 18.5)
    .widthRatioToView(self.view, 0.6)
    .heightIs(40);
    
    leftview.sd_layout
    .widthIs(15.5);
    
    sendCodeBtn.sd_layout
    .topEqualToView(phoneTextfield)
    .bottomEqualToView(phoneTextfield)
    .leftSpaceToView(phoneTextfield, 4)
    .rightSpaceToView(self.view, 15);
    
    
    passwordTextfield.sd_layout
    .leftEqualToView(phoneTextfield)
    .rightEqualToView(sendCodeBtn)
    .topSpaceToView(phoneTextfield, 6)
    .heightIs(40);
    
    passwordview.sd_layout
    .widthIs(15.5);
    
    nextBtn.sd_layout
    .leftSpaceToView(self.view, 35)
    .rightSpaceToView(self.view, 35)
    .topSpaceToView(passwordTextfield, 30)
    .heightIs(49);
       
    nextBtn.layer.cornerRadius = 27;
    nextBtn.layer.masksToBounds = YES;
}

//FIXME:UITextfieldDatagele
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//发送验证码
- (void)sendCodeAction:(UIButton *)sendBtn{
    [self messageTimeUbutton:sendBtn];
    NSString * phoneNumber = [NSString string];
    if (self.phoneType == 4) {
       phoneNumber = [NSString stringWithFormat:@"phoneNumber=%@",self.phoneStr];
     
    }else{
        NSString * phone = [self delSpaceAndNewline:self.phoneStr];
        phoneNumber = [NSString stringWithFormat:@"phoneNumber=%@",phone];
        NSLog(@"---------------------%@",phoneNumber);
        [RSNetworkTool netWorkToolWebServiceDataUrl:URL_VERIFICATION_IOS andType:@"GET" withParameters:phoneNumber andURLName:URL_VERIFICATION_IOS andContentType:@"JSON" withBlock:^(id  _Nonnull responseObject, BOOL success) {
            NSLog(@"---------------%@",responseObject);
        }];
    }
    [RSNetworkTool netWorkToolWebServiceDataUrl:URL_IMAGE_GET_IOS andType:@"GET" withParameters:phoneNumber andURLName:URL_IMAGE_GET_IOS andContentType:@"JSON" withBlock:^(id  _Nonnull responseObject, BOOL success) {
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
             
        
        
         }];
    
}

//通过64Base转换成图片
- (UIImage *)baseWith64EncodedString:(NSString *)baseEncode{
    NSData * bigimageData = [[NSData alloc] initWithBase64EncodedString:baseEncode options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage * bigimage = [UIImage imageWithData:bigimageData];
    return bigimage;
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    NSLog(@"====================================%ld",textField.tag);
//    NSLog(@"+++++++++++++++++++++++++++++++++=+++%@",textField.text);
//}

- (void)textFieldEditChanged:(UITextField *)textfield{
    if (self.phoneType == 1 || self.phoneType == 2) {
        if (textfield.text.length > self.i) {
            if (textfield.text.length == 4 || textfield.text.length == 9 ) {//输入
               NSMutableString * str = [[NSMutableString alloc ] initWithString:textfield.text];
               [str insertString:@" " atIndex:(textfield.text.length-1)];
               textfield.text = str;
            }if (textfield.text.length >= 13 ) {//输入完成
               textfield.text = [textfield.text substringToIndex:13];
               [textfield resignFirstResponder];
            }
            self.i = textfield.text.length;
        }else if (textfield.text.length < self.i){//删除
            if (textfield.text.length == 4 || textfield.text.length == 9) {
               textfield.text = [NSString stringWithFormat:@"%@",textfield.text];
                textfield.text = [textfield.text substringToIndex:(textfield.text.length-1)];
            }
            self.i = textfield.text.length;
        }
    }
    if (self.phoneType == 1 || self.phoneType == 2 ) {
        NSString * phone = [self delSpaceAndNewline:textfield.text];
        if (phone.length > 10){
            [self.nextBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FCC828"]];
        }else{
            [self.nextBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D8D8DA"]];
        }
    }else if (self.phoneType == 3 ){
        if (textfield.text.length > 5) {
             [self.nextBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FCC828"]];
        }else{
            [self.nextBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D8D8DA"]];
        }
    }else if (self.phoneType == 4){
        //密码
        if (self.phoneTextfield.text.length > 5 && self.passwordTextfield.text.length > 5 && self.passwordTextfield.text.length < 19) {
            [self.nextBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FCC828"]];
        }else{
            [self.nextBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D8D8DA"]];
        }
    }
}

//删除
- (void)deleteAction:(UIButton *)deleteBtn{
    self.phoneTextfield.text = @"";
    [self.nextBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D8D8DA"]];
}

//下一步和完成
- (void)nextAndCompleteAction:(UIButton *)nextBtn{
    RSWeakself
    //判断手机号是否完整化
    [_phoneTextfield resignFirstResponder];
    if (nextBtn.tag == 1) {
        NSString * phone = [self delSpaceAndNewline:_phoneTextfield.text];
        //输入原手机号
        if (![self isTrueMobile:phone]) {
            jxt_showToastTitle(@"请输入正确的电话号码", 0.75);
            return;
        }
        RSChagePhoneNumberViewController * chagePhoneNumberVc = [[RSChagePhoneNumberViewController alloc]init];
        chagePhoneNumberVc.phoneType = 2;
        [self.navigationController pushViewController:chagePhoneNumberVc animated:YES];
        
    }else if (nextBtn.tag == 2){
        NSString * phone = [self delSpaceAndNewline:_phoneTextfield.text];
        if (![self isTrueMobile:phone]) {
            jxt_showToastTitle(@"请输入正确的电话号码", 0.75);
            return;
        }
        NSLog(@"------------------%@",weakSelf.areaBtn.currentTitle);
        id parameters = [NSString stringWithFormat:@"phoneNumber=%@",phone];
        NSLog(@"===============================%@",parameters);
        //判断新的手机号验证是否可用
        [RSNetworkTool netWorkToolWebServiceDataUrl:URL_REGISTER_PHONE_IOS andType:@"GET" withParameters:parameters andURLName:URL_REGISTER_PHONE_IOS andContentType:@"JSON" withBlock:^(id  _Nonnull responseObject, BOOL success) {
         NSLog(@"-======================%@",responseObject);
            if ([responseObject[@"data"][@"exists"] boolValue] == 1) {
                jxt_showToastTitle(@"手机号已经被注册，请重新输入新的手机号", 0.75);
            }else{
                //请输入新手机号
                RSChagePhoneNumberViewController * chagePhoneNumberVc = [[RSChagePhoneNumberViewController alloc]init];
                chagePhoneNumberVc.phoneType = 3;
                chagePhoneNumberVc.areaStr = weakSelf.areaBtn.currentTitle;
                chagePhoneNumberVc.phoneStr = weakSelf.phoneTextfield.text;
                [weakSelf.navigationController pushViewController:chagePhoneNumberVc animated:YES];
            }
        }];
    }else if (nextBtn.tag == 3){
        //输入验证码
        if (_phoneTextfield.text.length < 6 ||_phoneTextfield.text.length > 6) {
            jxt_showToastTitle(@"请输入正确验证码", 0.75);
            return;
        }
        //这边是要变化到其他的地方
        //这边是需要修改手机号网络接口的部分
        NSString * phone = [self delSpaceAndNewline:_phoneNumberLabel.text];
        [JHSysAlertUtil presentAlertViewWithTitle:@"更换已绑定的手机号" message:phone cancelTitle:@"取消" defaultTitle:@"确定" distinct:NO cancel:^{
           //取消
        } confirm:^{
            //确定
            NSString * data = [NSString stringWithFormat:@"{userPhone:'%@',verificationCode:'%@'}",[self delSpaceAndNewline:[NSString stringWithFormat:@"%@",weakSelf.phoneStr]],weakSelf.phoneTextfield.text];
            NSString * aes2 = [self encryptAESDataKey:data];
            NSDictionary * parameters = [NSDictionary dictionary];
            parameters = @{@"data":aes2};
            [RSNetworkTool netWorkToolWebServiceDataUrl:URL_USER_PHONE_IOS andType:@"POST" withParameters:parameters andURLName:URL_USER_PHONE_IOS andContentType:[UserInfoContext sharedUserInfoContext].userInfo.loginToken withBlock:^(id  _Nonnull responseObject, BOOL success) {
                
                UserInfo * userInfo = [UserInfoContext sharedUserInfoContext].userInfo;
                userInfo.userPhone = [weakSelf delSpaceAndNewline:weakSelf.phoneStr];
                [Usertilities SetNSUserDefaults:userInfo];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshUserInfromation" object:@{@"phone":userInfo.userPhone,@"TYPE":@"1"}];
            [self.navigationController popToViewController:weakSelf.navigationController.viewControllers[1] animated:YES];
                
            }];
        }];
    }else if (nextBtn.tag == 4){
        if (_phoneTextfield.text.length < 6) {
            jxt_showToastTitle(@"请输入验证码", 0.75);
            return;
        }
        //修改密码
        if (_passwordTextfield.text.length<6)
        {
            jxt_showToastMessage(@"请设置6-18位密码", 0.75);
            return;
        }
        if (_passwordTextfield.text.length>20)
        {
            jxt_showToastMessage(@"请设置6-18位密码", 0.75);
            return;
        }
        [JHSysAlertUtil presentAlertViewWithTitle:@"修改密码" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:NO cancel:^{
           //取消
        } confirm:^{
            //确定
            NSString * data = [NSString stringWithFormat:@"{userPassword:'%@',verificationCode:'%@'}",[MyMD5 md5:weakSelf.passwordTextfield.text],weakSelf.phoneTextfield.text];
            NSString * aes2 = [self encryptAESDataKey:data];
            NSDictionary * parameters = [NSDictionary dictionary];
            parameters = @{@"data":aes2};
            [RSNetworkTool netWorkToolWebServiceDataUrl:URL_USER_PWD_IOS andType:@"POST" withParameters:parameters andURLName:URL_USER_PWD_IOS andContentType:[UserInfoContext sharedUserInfoContext].userInfo.loginToken withBlock:^(id  _Nonnull responseObject, BOOL success) {
                //登出接口部分
                NSDictionary * parameter = [NSDictionary dictionary];
                [RSNetworkTool netWorkToolWebServiceDataUrl:URL_LOGOUT_IOS andType:@"POST" withParameters:parameter andURLName:URL_LOGOUT_IOS andContentType:[UserInfoContext sharedUserInfoContext].userInfo.loginToken withBlock:^(id  _Nonnull responseObject, BOOL success) {
                    
                    //删除本地存储的用户信息
                    [Usertilities clearLocalUserModel];
                    //删除用户单利的用户信息的对象
                    [UserInfoContext clear];
                    //这边要变成登录和注册的界面
                    RSRegisterViewController * registerVc = [[RSRegisterViewController alloc]init];
                    RSMyNavigationViewController * myNav = [[RSMyNavigationViewController alloc]initWithRootViewController:registerVc];
                    AppDelegate * appdelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
                    appdelegate.window.rootViewController = myNav;
                    
                }];
                //UserInfo * userInfo = [UserInfoContext sharedUserInfoContext].userInfo;
                //userInfo.passwordSet = 1;
                //[Usertilities SetNSUserDefaults:userInfo];
                
                
                //[[NSNotificationCenter defaultCenter]postNotificationName:@"refreshUserInfromation" object:@{@"passwordSet":[NSString stringWithFormat:@"%d",userInfo.passwordSet],@"TYPE":@"2"}];
                //[weakSelf.navigationController popToViewController:weakSelf.navigationController.viewControllers[1] animated:YES];
            }];
        }];
        
    }
}

- (void)choiceAreaNumberAction:(UIButton *)areaBtn{
    XWCountryCodeController * countryCodeVC = [[XWCountryCodeController alloc] init];
    countryCodeVC.returnCountryCodeBlock = ^(NSString *countryName, NSString *code) {
        NSLog(@"=====================国家:%@----------------------代码:%@",countryName,code);
        [areaBtn setTitle:[NSString stringWithFormat:@"+%@",code] forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:countryCodeVC animated:YES];
}


@end
