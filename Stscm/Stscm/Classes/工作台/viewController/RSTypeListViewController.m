//
//  RSTypeListViewController.m
//  Stscm
//
//  Created by mac on 2020/8/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSTypeListViewController.h"

#import "RSTypeListCell.h"

@interface RSTypeListViewController ()

@end

@implementation RSTypeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"列表";
    self.emptyView.hidden = YES;
    
    
    //清除导航栏下面横线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
     
    UIButton * firstBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 60, 60)];
    [firstBtn setTitle:@"新建" forState:UIControlStateNormal];
    [firstBtn setTitleColor:[UIColor colorWithDyColorChangObject:firstBtn andHexLightColorStr:@"#666666" andHexDarkColorStr:@"#ffffff"] forState:UIControlStateNormal];
    firstBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [firstBtn addTarget:self action:@selector(firstBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:firstBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    [self typeListCustonHeaderView];
    
}



- (void)typeListCustonHeaderView{
    
    //这边添加搜索框，和筛选的按键
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:headerView];
    
    UIView * searchView = [[UIView alloc]init];
    searchView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8F8"];
    [headerView addSubview:searchView];
    
    UITextField * searchTextField = [[UITextField alloc]init];
    searchTextField.placeholder = @"请输入要匹配的仓库名";
    searchTextField.font = [UIFont systemFontOfSize:14];
    [searchView addSubview:searchTextField];
    
    UIImageView * searchImage = [[UIImageView alloc]init];
    searchImage.backgroundColor = [UIColor redColor];
    searchImage.image = [UIImage imageNamed:@""];
    [searchView addSubview:searchImage];

    
    UIButton * screenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
//    [screenBtn addTarget:self action:@selector(screenAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:screenBtn];
    
    
    headerView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.navigationController.navigationBar, 0)
    .heightIs(62.5);
    
    
    searchView.sd_layout
    .leftSpaceToView(headerView, 12)
    .topSpaceToView(headerView, 12.5)
    .widthRatioToView(headerView,0.8)
    .heightIs(40);
    
    searchImage.sd_layout
    .leftSpaceToView(searchView, 18.5)
    .centerYEqualToView(searchView)
    .widthIs(13)
    .heightEqualToWidth();
    
    searchTextField.sd_layout
    .leftSpaceToView(searchImage, 3.5)
    .rightSpaceToView(searchView, 0)
    .topSpaceToView(searchView, 0)
    .bottomSpaceToView(searchView, 0);
    
    searchView.layer.cornerRadius = 20;
    searchView.layer.masksToBounds = YES;
    
    
    screenBtn.sd_layout
    .rightSpaceToView(headerView, 12)
    .topSpaceToView(headerView, 12.5)
    .heightIs(40)
    .widthIs(50);

    self.tableview.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(headerView, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    [self.tableview layoutIfNeeded];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * TYPELISTCELLID = @"TYPELISTCELLID";
    RSTypeListCell * cell = [tableView dequeueReusableCellWithIdentifier:TYPELISTCELLID];
    if (!cell) {
        cell = [[RSTypeListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TYPELISTCELLID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



@end
