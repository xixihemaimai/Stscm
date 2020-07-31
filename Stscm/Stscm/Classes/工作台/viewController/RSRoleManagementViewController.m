//
//  RSRoleManagementViewController.m
//  Stscm
//
//  Created by mac on 2020/7/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSRoleManagementViewController.h"
#import "RSRoleManementCell.h"

#import "RSAddRoleViewController.h"

@interface RSRoleManagementViewController ()

@end

@implementation RSRoleManagementViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.emptyView.hidden = YES;
    self.pageNum = 1;
    self.title = @"角色管理";
    
    
    UIButton * addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 60, 60)];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    
   
    self.customBlock = ^(NSInteger pageNum) {
        
        NSLog(@"------------------%ld",pageNum);
        
        
    };
   
    
    
    
}






- (void)addAction:(UIButton *)addBtn{
    NSLog(@"添加");
    
    RSAddRoleViewController * addRoleVc = [[RSAddRoleViewController alloc]init];
    [self.navigationController pushViewController:addRoleVc animated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ROLEMAMEMENTCELLID = @"ROLEMAMEMENTCELLID";
    RSRoleManementCell * cell = [tableView dequeueReusableCellWithIdentifier:ROLEMAMEMENTCELLID];
    if (!cell) {
        cell = [[RSRoleManementCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ROLEMAMEMENTCELLID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}






@end
