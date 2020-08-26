//
//  RSMineViewController.m
//  Stscm
//
//  Created by mac on 2020/7/16.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSMineViewController.h"

#import "RSCustomMenuCell.h"
#import "RSMenuHeaderFootView.h"

/**个人信息*/
#import "RSMineInformationViewController.h"

/**注册界面*/
#import "RSRegisterViewController.h"

@interface RSMineViewController ()

    
@property (nonatomic,strong)UIImageView * userImage;
    
@property (nonatomic,strong)UILabel * userPhoneLabel;

@end

@implementation RSMineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UserInfo * userInfo = [UserInfoContext sharedUserInfoContext].userInfo;
    NSLog(@"======================%@------------------%@",userInfo.userName,userInfo.userPhone);
    
    self.emptyView.hidden = YES;
    
    [self customHeaderView];
}

- (void)customHeaderView{
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#FCC828"];
    //image.size.height/image.size.width*ScreenWeidth
    headerView.frame = CGRectMake(0, 0, SCW, 200/SCW * SCW);
    NSLog(@"========111111111=============%@",[UserInfoContext sharedUserInfoContext].userInfo.userHeadImageUrl);
    
    UIImageView * userImage = [[UIImageView alloc]init];
//    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_IOS_PICTURE,[UserInfoContext sharedUserInfoContext].userInfo.userHeadImageUrl]];
//    NSData* imageData = [NSData dataWithContentsOfURL:url];
//    UIImage * image = [UIImage imageWithData:imageData];
//    [userImageBtn setImage:image forState:UIControlStateNormal];
    [userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_IOS_PICTURE,[UserInfoContext sharedUserInfoContext].userInfo.userHeadImageUrl]] placeholderImage:[UIImage imageNamed:@"Group 2"]];
    
    [headerView addSubview:userImage];
    userImage.frame = CGRectMake(SCW/2 - 30, (200/SCW * SCW)/2 - 30, 60, 60);
    _userImage = userImage;
    _userImage.layer.cornerRadius = _userImage.yj_width * 0.5;
    _userImage.layer.masksToBounds = YES;
    
    UILabel * userPhoneLabel = [[UILabel alloc]init];
    userPhoneLabel.textAlignment = NSTextAlignmentCenter;
    userPhoneLabel.font = [UIFont systemFontOfSize:18];
    userPhoneLabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//    NSString * phoneStr = [UserInfoContext sharedUserInfoContext].userInfo.userName;
//    NSString * withStr = @"*****";
//    NSInteger fromIndex = 3;
//    NSRange range = NSMakeRange(fromIndex,  withStr.length);
//    NSString * phoneNumber = [phoneStr stringByReplacingCharactersInRange:range  withString:withStr];
    userPhoneLabel.text = [UserInfoContext sharedUserInfoContext].userInfo.userName;
    [headerView addSubview:userPhoneLabel];
    userPhoneLabel.frame = CGRectMake(0, CGRectGetMaxY(userImage.frame) + 8, SCW, 25);
    self.tableview.tableHeaderView = headerView;
    _userPhoneLabel = userPhoneLabel;
    
    //尾部视图
    UIView * menuFootView = [[UIView alloc]init];
    menuFootView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    menuFootView.frame = CGRectMake(0, 0, SCW, 100);
       
    UIButton * footSignoutBtn = [[UIButton alloc]init];
    [footSignoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [footSignoutBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FCC828"]];
    [footSignoutBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    [footSignoutBtn addTarget:self action:@selector(signOutAction:) forControlEvents:UIControlEventTouchUpInside];
    footSignoutBtn.titleLabel.font = [UIFont systemFontOfSize:Textadaptation(15)];
    [menuFootView addSubview:footSignoutBtn];
    
    footSignoutBtn.frame = CGRectMake(52.5, 50-22, SCW - 52.5 - 52.5, 44);
    footSignoutBtn.layer.cornerRadius = 24.5;
    footSignoutBtn.layer.masksToBounds = YES;
    self.tableview.tableFooterView = menuFootView;
}


- (void)signOutAction:(UIButton *)btn{
    NSDictionary * parameters = [NSDictionary dictionary];
    [RSNetworkTool netWorkToolWebServiceDataUrl:URL_LOGOUT_IOS andType:@"POST" withParameters:parameters andURLName:URL_LOGOUT_IOS andContentType:[UserInfoContext sharedUserInfoContext].userInfo.loginToken withBlock:^(id  _Nonnull responseObject, BOOL success) {
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
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (45/SCW) * SCW;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        RSMineInformationViewController * mineInformationVc = [[RSMineInformationViewController alloc]init];
        [self.navigationController pushViewController:mineInformationVc animated:YES];
        mineInformationVc.backUp = ^(id  _Nonnull responseObject, NSInteger type) {
            if (type == 0) {
                [self.userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_IOS_PICTURE,responseObject]] placeholderImage:[UIImage imageNamed:@"Group 2"]];
//               NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_IOS_PICTURE,responseObject]]];
//               UIImage * image = [UIImage imageWithData:imageData];
//               [self.userImage setImage:image forState:UIControlStateNormal];
               //UserInfo * userInfo = [UserInfoContext sharedUserInfoContext].userInfo;
               //userInfo.userHeadImageUrl = responseObject;
               //[Usertilities SetNSUserDefaults:userInfo];
            }else{
                UserInfo * userInfo = [UserInfoContext sharedUserInfoContext].userInfo = [Usertilities GetNSUserDefaults];
                //userInfo.userPhone = responseObject;
                //NSString * phoneStr = responseObject;
                //NSString * withStr = @"*****";
                //NSInteger fromIndex = 3;
                //NSRange range = NSMakeRange(fromIndex,  withStr.length);
                //NSString * phoneNumber = [phoneStr stringByReplacingCharactersInRange:range  withString:withStr];
                self.userPhoneLabel.text = responseObject;
            }
        };
    }else if (indexPath.row == 1) {
        //关于我们
        
        
        
    }else if(indexPath.row == 2){
        //清除缓存
        // NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        float MBCache = [self sizeOfDirectory:path];
        //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
        MBCache = MBCache/1000/1000;
        NSString * text = [NSString stringWithFormat:@"已清理:%0.3lfM",MBCache];
        [JHSysAlertUtil presentAlertViewWithTitle:text message:nil confirmTitle:@"确定" handler:^{
            //这边是清理缓存
            //异步清除图片缓存 （磁盘中的）
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //[[SDImageCache sharedImageCache] clearMemory];
               [self deleteFileByPath:path];
             });
             //这句话是解决，清除缓存之后，在去点击视频，没有办法播放视频的问题
             [KTVHTTPCache cacheDeleteAllCaches];
        }];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString * MENUHEADER = @"MENUHEADER";
    RSMenuHeaderFootView * menuHeaderView = [[RSMenuHeaderFootView alloc]initWithReuseIdentifier:MENUHEADER];
    return menuHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CELLMENUID = @"CELLMENUID";
    RSCustomMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLMENUID];
    if (!cell) {
        cell = [[RSCustomMenuCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLMENUID];
    }
    if (indexPath.row == 0) {
        cell.menuImageView.image = [UIImage imageNamed:@"个人信息"];
        cell.menuLabel.text = @"个人信息";
    }else if (indexPath.row == 1){
        cell.menuImageView.image = [UIImage imageNamed:@"密码修改"];
        cell.menuLabel.text = @"关于我们";
    }else if (indexPath.row == 2){
        cell.menuImageView.image = [UIImage imageNamed:@"清除缓存"];
        cell.menuLabel.text = @"清除缓存";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}









@end
