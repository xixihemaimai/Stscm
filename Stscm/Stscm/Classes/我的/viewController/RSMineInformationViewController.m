//
//  RSMineInformationViewController.m
//  Stscm
//
//  Created by mac on 2020/7/16.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSMineInformationViewController.h"
#import "RSPersonFirstCell.h"
#import "RSPersonSecondCell.h"
#import <Photos/Photos.h>
//修改手机号
#import "RSChagePhoneNumberViewController.h"
//修改用户名
#import "LSXAlertInputView.h"


@interface RSMineInformationViewController ()<TZImagePickerControllerDelegate>

@end

@implementation RSMineInformationViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshUserInfromation:) name:@"refreshUserInfromation" object:nil];
    self.emptyView.hidden = YES;
    self.title = @"个人信息";
    
    NSLog(@"=====0000====================================%@",[UserInfoContext sharedUserInfoContext].userInfo.loginToken);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 101;
    }else{
        return 48;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * MINEINFORMATONCELLID = @"MINEINFORMATONCELLID";
    //UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MINEINFORMATONCELLID];
    if (indexPath.section == 0) {
        RSPersonFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:MINEINFORMATONCELLID];
        if (!cell) {
            cell = [[RSPersonFirstCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MINEINFORMATONCELLID];
        }
        NSLog(@"=22222=======111111111=============%@",[UserInfoContext sharedUserInfoContext].userInfo.userHeadImageUrl);
        [cell.headerview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_IOS_PICTURE,[UserInfoContext sharedUserInfoContext].userInfo.userHeadImageUrl]] placeholderImage:[UIImage imageNamed:@"Group 2"]];
        return cell;
    }else{
        RSPersonSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:MINEINFORMATONCELLID];
        if (!cell) {
            cell = [[RSPersonSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MINEINFORMATONCELLID];
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.nameLabel.text = @"用户名称";
                cell.phoneLabel.text = [UserInfoContext sharedUserInfoContext].userInfo.userName;
            }else if (indexPath.row == 1){
                cell.nameLabel.text = @"绑定手机";
                cell.phoneLabel.text = [UserInfoContext sharedUserInfoContext].userInfo.userPhone;
            }else{
                cell.nameLabel.text = @"密码";
                if ([UserInfoContext sharedUserInfoContext].userInfo.passwordSet == 0) {
                    cell.phoneLabel.text = @"未设置";
                }else{
                    cell.phoneLabel.text = @"已设置";
                }
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RSWeakself
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"------------------------%ld",indexPath.row);
    if (indexPath.section == 0) {
        RSPersonFirstCell * cell = (RSPersonFirstCell *)[self.tableview cellForRowAtIndexPath:indexPath];
        NSDictionary * parameters =@{@"":@""};
        
        ZZCustomCameraViewController * customCameraVc = [[ZZCustomCameraViewController alloc]init];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            customCameraVc.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:customCameraVc animated:true completion:nil];
        customCameraVc.selectImgBlock = ^(UIImage * img,ZZCustomCameraViewController * vc) {
            [vc dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"++++++++++++++++32==3=23==================");
//            dispatch_async(dispatch_get_main_queue(), ^{
                [RSNetworkTool getDifferentTypeWithDataUrlString:URL_HEAD_IMAGE_IOS andLogin_token:[UserInfoContext sharedUserInfoContext].userInfo.loginToken withParameters:parameters andRequest:@"POST" andURLName:URL_HEAD_IMAGE_IOS andVideoUrl:[NSURL URLWithString:@""] andType:@"image" andArray:[NSMutableArray array] andImage:img withBlock:^(id  _Nonnull responseObject, BOOL success) {
                    [cell.headerview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_IOS_PICTURE,responseObject]] placeholderImage:[UIImage imageNamed:@"Group 2"]];
                    NSLog(@"+++=+++++=+++++++++++=+++++++2+++++=+++++++=====================%@",responseObject);
                    [UserInfoContext sharedUserInfoContext].userInfo.userHeadImageUrl = responseObject;
                    NSLog(@"+++=+++++=+++++++++++=++++++++++++=+++++++=====================%@",[UserInfoContext sharedUserInfoContext].userInfo.userHeadImageUrl);
                    [Usertilities SetNSUserDefaults:[UserInfoContext sharedUserInfoContext].userInfo];
                    if (weakSelf.backUp) {
                        weakSelf.backUp(responseObject,0);
                    }
                }];
//            });
        };
        
        
        
        
        //        TZImagePickerController * imagePicker = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
        //        imagePicker.allowTakePicture = YES;
        //        imagePicker.maxImagesCount = 1;
        //        imagePicker.allowCrop = YES;
        //        imagePicker.allowPreview = YES;
        //        imagePicker.showSelectBtn = NO;
        //        imagePicker.allowTakeVideo = NO;
        //        imagePicker.needCircleCrop = YES;
        //        imagePicker.cropRect = CGRectMake(SCW/2 - 30, SCH/2 - 30, 60, 60);
        //        [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        //            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //                for (int i=0; i<photos.count; i++)
        //                {
        //                    UIImage * tempImg = photos[i];
        //                    dispatch_async(dispatch_get_main_queue(), ^{
        //                        [RSNetworkTool getDifferentTypeWithDataUrlString:URL_HEAD_IMAGE_IOS andLogin_token:[UserInfoContext sharedUserInfoContext].userInfo.loginToken withParameters:parameters andRequest:@"POST" andURLName:URL_HEAD_IMAGE_IOS andVideoUrl:[NSURL URLWithString:@""] andType:@"image" andArray:[NSMutableArray array] andImage:tempImg withBlock:^(id  _Nonnull responseObject, BOOL success) {
        //                            [cell.headerview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_IOS_PICTURE,responseObject]] placeholderImage:[UIImage imageNamed:@"Group 2"]];
        //                            NSLog(@"+++=+++++=+++++++++++=+++++++2+++++=+++++++=====================%@",responseObject);
        //                            [UserInfoContext sharedUserInfoContext].userInfo.userHeadImageUrl = responseObject;
        //                            NSLog(@"+++=+++++=+++++++++++=++++++++++++=+++++++=====================%@",[UserInfoContext sharedUserInfoContext].userInfo.userHeadImageUrl);
        //                            [Usertilities SetNSUserDefaults:[UserInfoContext sharedUserInfoContext].userInfo];
        //                            if (weakSelf.backUp) {
        //                                weakSelf.backUp(responseObject,0);
        //                            }
        //                        }];
        //                    });
        //                }
        //            });
        //        }];
        //        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        //            imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        //        }
        //        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
        if (indexPath.row == 0) {
            //修改用户名---弹窗
            LSXAlertInputView * alert=[[LSXAlertInputView alloc]initWithTitle:@"修改用户名" PlaceholderText:@"请输入用户名" WithKeybordType:LSXKeyboardTypeDefault CompleteBlock:^(NSString *contents) {
                NSLog(@"-----%@",contents);
                if (contents.length > 0) {
                    //这边要进行修改用户名
                    RSPersonSecondCell * cell = (RSPersonSecondCell *)[self.tableview cellForRowAtIndexPath:indexPath];
                    NSString * data = [NSString stringWithFormat:@"{userName:'%@'}",contents];
                    NSString * aes2 = [self encryptAESDataKey:data];
                    NSDictionary * parameters = [NSDictionary dictionary];
                    parameters = @{@"data":aes2};
                    [RSNetworkTool netWorkToolWebServiceDataUrl:URL_USER_NAME_IOS andType:@"POST" withParameters:parameters andURLName:URL_USER_NAME_IOS andContentType:[UserInfoContext sharedUserInfoContext].userInfo.loginToken withBlock:^(id  _Nonnull responseObject, BOOL success) {
                        
                        UserInfo * userInfo = [UserInfoContext sharedUserInfoContext].userInfo;
                        userInfo.userName = contents;
                        [Usertilities SetNSUserDefaults:userInfo];
                        cell.phoneLabel.text = contents;
                        
                        if (weakSelf.backUp) {
                            weakSelf.backUp(contents,1);
                        }
                    }];
                }else{
                    jxt_showToastTitle(@"请输入用户名称", 0.75);
                }
            }];
            [alert show];
        }else if (indexPath.row == 1){
            //修改绑定手机号
            RSChagePhoneNumberViewController * chagePhoneNumberVc = [[RSChagePhoneNumberViewController alloc]init];
            chagePhoneNumberVc.phoneType = 1;
            [self.navigationController pushViewController:chagePhoneNumberVc animated:YES];
            
            
        }else{
            //修改密码
            RSChagePhoneNumberViewController * chagePhoneNumberVc = [[RSChagePhoneNumberViewController alloc]init];
            chagePhoneNumberVc.phoneStr = [UserInfoContext sharedUserInfoContext].userInfo.userPhone;
            chagePhoneNumberVc.phoneType = 4;
            chagePhoneNumberVc.areaStr = @"+86";
            [self.navigationController pushViewController:chagePhoneNumberVc animated:YES];
        }
    }
}

- (void)refreshUserInfromation:(NSNotification *)noti{
//    NSDictionary * infoDic = [noti object];
//    if ([[infoDic objectForKey:@"TYPE"] isEqualToString:@"1"]) {
//        UserInfo * userInfo = [UserInfoContext sharedUserInfoContext].userInfo;
//        userInfo.userPhone = [infoDic objectForKey:@"phone"];
//        [Usertilities SetNSUserDefaults:userInfo];
//
//    }else if ([[infoDic objectForKey:@"TYPE"] isEqualToString:@"2"]){
//        UserInfo * userInfo = [UserInfoContext sharedUserInfoContext].userInfo;
//        //修改密码
//        userInfo.passwordSet = [[infoDic objectForKey:@"passwordSet"] boolValue];
//        [Usertilities SetNSUserDefaults:userInfo];
//    }
//    
    [self.tableview reloadData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end
