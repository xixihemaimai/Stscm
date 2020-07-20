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

@interface RSMineViewController ()

@end

@implementation RSMineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.emptyView.hidden = YES;
    
    [self customHeaderView];
    
    
}




- (void)customHeaderView{
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#FCC828"];
    //image.size.height/image.size.width*ScreenWeidth
    headerView.frame = CGRectMake(0, 0, SCW, 200/SCW * SCW);
    
    
    UIButton * userImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userImageBtn setImage:[UIImage imageNamed:@"Group 2"] forState:UIControlStateNormal];
    [headerView addSubview:userImageBtn];
    userImageBtn.frame = CGRectMake(SCW/2 - 30, (200/SCW * SCW)/2 - 30, 60, 60);
    
    
    UILabel * userPhoneLabel = [[UILabel alloc]init];
    userPhoneLabel.textAlignment = NSTextAlignmentCenter;
    userPhoneLabel.font = [UIFont systemFontOfSize:18];
    userPhoneLabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    NSString *phoneStr = @"12901111111";
    NSString *withStr = @"*****";
    NSInteger fromIndex = 3;
    NSRange range = NSMakeRange(fromIndex,  withStr.length);
    NSString *phoneNumber = [phoneStr stringByReplacingCharactersInRange:range  withString:withStr];
    userPhoneLabel.text = phoneNumber;
    [headerView addSubview:userPhoneLabel];
    userPhoneLabel.frame = CGRectMake(0, CGRectGetMaxY(userImageBtn.frame) + 8, SCW, 25);
    self.tableview.tableHeaderView = headerView;
    
    
    
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
    }else if (indexPath.row == 1) {
    }else if(indexPath.row == 2){
        //清除缓存
          // NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
           NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
           NSString *path = [paths objectAtIndex:0];
           float MBCache = [self sizeOfDirectory:path];
           //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
            MBCache = MBCache/1000/1000;
           NSString * text = [NSString stringWithFormat:@"已清理:%0.3lfM",MBCache];
           UIAlertController *alert = [UIAlertController alertControllerWithTitle:text message:nil preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction * actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               //这边是清理缓存
               //异步清除图片缓存 （磁盘中的）
               dispatch_async(dispatch_get_global_queue(0, 0), ^{
                   //[[SDImageCache sharedImageCache] clearMemory];
                   [self deleteFileByPath:path];
               });
               //这句话是解决，清除缓存之后，在去点击视频，没有办法播放视频的问题
               [KTVHTTPCache cacheDeleteAllCaches];
               
           }];
           [alert addAction:actionConfirm];
           if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
               alert.modalPresentationStyle = UIModalPresentationFullScreen;
           }
           [self presentViewController:alert animated:YES completion:nil];
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
