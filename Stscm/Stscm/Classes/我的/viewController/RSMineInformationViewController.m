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

@interface RSMineInformationViewController ()

@end

@implementation RSMineInformationViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emptyView.hidden = YES;
    self.title = @"个人信息";
    
    
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
        return cell;
    }else{
        RSPersonSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:MINEINFORMATONCELLID];
        if (!cell) {
            cell = [[RSPersonSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MINEINFORMATONCELLID];
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.nameLabel.text = @"用户名称";
                cell.phoneLabel.text = @"138*****909";
            }else if (indexPath.row == 1){
                cell.nameLabel.text = @"绑定手机";
                cell.phoneLabel.text = @"138*****909";
            }else{
                cell.nameLabel.text = @"密码";
                cell.phoneLabel.text = @"已设置";
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}






@end
