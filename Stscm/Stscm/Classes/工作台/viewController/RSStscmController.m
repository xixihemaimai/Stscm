//
//  RSStscmController.m
//  Stscm
//
//  Created by mac on 2020/6/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSStscmController.h"

#import "RSStscmHeaderView.h"

#import "RSPersonalEditionCell.h"
//角色
#import "RSRoleManagementViewController.h"

#import "RSStscmAlertView.h"

#import "RSFuntionViewController.h"

@interface RSStscmController ()<RSPersonalEditionCellDelegate>

@property (nonatomic,strong)UIButton * currentSelectButton;

@property (nonatomic,strong)RSStscmAlertView * stscmAlertview;

@end

@implementation RSStscmController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (RSStscmAlertView *)stscmAlertview{
    if (!_stscmAlertview) {
        self.stscmAlertview = [[RSStscmAlertView alloc] initWithFrame:CGRectMake(33, (SCH/2) - 141, SCW - 66 , 282)];
        self.stscmAlertview.backgroundColor = [UIColor whiteColor];
        self.stscmAlertview.layer.cornerRadius = 15;
    }
    return _stscmAlertview;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emptyView.hidden = YES;
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    [self setUi];
    
    
}





- (void)setUi{
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWhiteShow];
    
    //背景
    UIImageView * backImage = [[UIImageView alloc]init];
    backImage.image = [UIImage imageNamed:@"Rectangle 14"];
    [headerView addSubview:backImage];
    
    
    
    //进销存
//    UILabel * purchaseLabel = [RSCustomLabel creatCustomLabelAndText:@"进销存" andTextColor:[UIColor colorWithHexColorStr:@"#161616"] andFont:[UIFont fontWithName:@"PingFangSC" size: 24] andTextAlignment:NSTextAlignmentLeft andBackgroundColor:[UIColor clearColor]];
//    [headerView addSubview:purchaseLabel];
  
    
    
    //用户的信息
    UIView * userView = [[UIView alloc]init];
    userView.backgroundColor = [UIColor colorWithHexColorStr:@"#000000" alpha:0.2];
    [headerView addSubview:userView];
    
    
    //用户
    UIButton * userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userBtn setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    [userBtn addTarget:self action:@selector(userAction:) forControlEvents:UIControlEventTouchUpInside];
    [userView addSubview:userBtn];
    
    
    //用户名称
    UILabel * userLabel = [[UILabel alloc]init];
    userLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    userLabel.font = [UIFont systemFontOfSize:14];
    userLabel.text = @"咿呀咿有限公司";
    userLabel.textAlignment = NSTextAlignmentLeft;
    [userView addSubview:userLabel];
    
    //职位
    UILabel * positionLabel = [[UILabel alloc]init];
    positionLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    positionLabel.font = [UIFont systemFontOfSize:11];
    positionLabel.text = @"销售";
    positionLabel.textAlignment = NSTextAlignmentLeft;
    [userView addSubview:positionLabel];
    
    
    //切换
    UIButton * switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchBtn setImage:[UIImage imageNamed:@"切换"] forState:UIControlStateNormal];
    [switchBtn addTarget:self action:@selector(swithUserAction:) forControlEvents:UIControlEventTouchUpInside];
    [userView addSubview:switchBtn];
    
    
    
    
    
    
    //内部数据界面
    UIView * dataView = [[UIView alloc]init];
    dataView.backgroundColor = [UIColor colorWhiteShow];
    [headerView addSubview:dataView];
    
    
    
    //数据内部的界面
    
    //三个按键
    
    CGFloat btnW = (SCW - 30)/3;
    CGFloat btnH = 42;
    
    for (int i = 0; i < 3; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC" size: 13];
        [btn setTitleColor:[UIColor colorWithHexColorStr:@"#FCC828"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexColorStr:@"#323232"] forState:UIControlStateSelected];
        if (i == 0) {
            [self switchAction:btn];
            CGRect oldRect = btn.bounds;
            oldRect.size.width = btnW;
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:UIRectCornerTopLeft  cornerRadii:CGSizeMake(16, 16)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.path = maskPath.CGPath;
            maskLayer.frame = oldRect;
            btn.layer.mask = maskLayer;
            [btn setTitle:@"总库存数量" forState:UIControlStateNormal];
            //[btn setTitleColor:[UIColor colorWithHexColorStr:@"#FCC828"] forState:UIControlStateNormal];
            //[btn setTitleColor:[UIColor colorWithHexColorStr:@"#323232"] forState:UIControlStateSelected];
            [btn setBackgroundColor:[UIColor colorWhiteShow]];
        }else if (i == 1){
            
            [btn setTitle:@"今日入库" forState:UIControlStateNormal];
            //            [btn setTitleColor:[UIColor colorWithHexColorStr:@"#FCC828"] forState:UIControlStateNormal];
            //            [btn setTitleColor:[UIColor colorWithHexColorStr:@"#323232"] forState:UIControlStateSelected];
            [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#323232"]];
        }else if (i == 2){
            
            [btn setTitle:@"今日出库" forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#323232"]];
            CGRect oldRect1 = btn.bounds;
            oldRect1.size.width = btnW;
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect1 byRoundingCorners:UIRectCornerTopRight  cornerRadii:CGSizeMake(16, 16)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.path = maskPath.CGPath;
            maskLayer.frame = oldRect1;
            btn.layer.mask = maskLayer;
        }
        [btn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
        [dataView addSubview:btn];
    }
    
    
    
    
    
    //荒料
    UILabel * blockLabel = [RSCustomLabel creatCustomLabelAndText:@"荒料" andTextColor:[UIColor colorWithHexColorStr:@"#161616"] andFont:[UIFont fontWithName:@"PingFangSC" size: 13] andTextAlignment:NSTextAlignmentLeft andBackgroundColor:[UIColor clearColor]];;
    [dataView addSubview:blockLabel];
    
    //荒料数据内容
    blockLabel.sd_layout
    .leftSpaceToView(dataView, 20)
    .topSpaceToView(dataView, 55.5)
    .widthIs(40)
    .heightIs(18.5);
    
    UILabel * grainLabel = [RSCustomLabel creatCustomLabelAndText:@"76474657" andTextColor:[UIColor colorWithHexColorStr:@"#000000"] andFont:[UIFont fontWithName:@"PingFangSC" size: 18] andTextAlignment:NSTextAlignmentCenter andBackgroundColor:[UIColor clearColor]];
    [dataView addSubview:grainLabel];
    
    UILabel * vomlueLabel = [RSCustomLabel creatCustomLabelAndText:@"76474657" andTextColor:[UIColor colorWithHexColorStr:@"#000000"] andFont:[UIFont fontWithName:@"PingFangSC" size: 18] andTextAlignment:NSTextAlignmentCenter andBackgroundColor:[UIColor clearColor]];
    [dataView addSubview:vomlueLabel];
    
    UILabel * wegihtLabel = [RSCustomLabel creatCustomLabelAndText:@"76474657" andTextColor:[UIColor colorWithHexColorStr:@"#000000"] andFont:[UIFont fontWithName:@"PingFangSC" size: 18] andTextAlignment:NSTextAlignmentCenter andBackgroundColor:[UIColor clearColor]];
    [dataView addSubview:wegihtLabel];
    
    
     
    UILabel * graindetailLabel = [RSCustomLabel creatCustomLabelAndText:@"颗数" andTextColor:[UIColor colorWithHexColorStr:@"#9A9A9A"] andFont:[UIFont systemFontOfSize:12] andTextAlignment:NSTextAlignmentCenter andBackgroundColor:[UIColor clearColor]];

    [dataView addSubview:graindetailLabel];
    
    
    UILabel * vomluedetailLabel = [RSCustomLabel creatCustomLabelAndText:@"立方数" andTextColor:[UIColor colorWithHexColorStr:@"#9A9A9A"] andFont:[UIFont systemFontOfSize:12] andTextAlignment:NSTextAlignmentCenter andBackgroundColor:[UIColor clearColor]];
    [dataView addSubview:vomluedetailLabel];
    
    
    UILabel * weightdetailLabel = [RSCustomLabel creatCustomLabelAndText:@"重量(吨)" andTextColor:[UIColor colorWithHexColorStr:@"#9A9A9A"] andFont:[UIFont systemFontOfSize:12] andTextAlignment:NSTextAlignmentCenter andBackgroundColor:[UIColor clearColor]];
    [dataView addSubview:weightdetailLabel];
    
    
    
    
    
    
    grainLabel.sd_layout
    .leftSpaceToView(dataView, 0)
    .topSpaceToView(blockLabel, 8)
    .heightIs(25)
    .widthIs((SCW - 30)/3);
    
    
    vomlueLabel.sd_layout
    .leftSpaceToView(grainLabel, 0)
    .topSpaceToView(blockLabel, 8)
    .heightIs(25)
    .widthIs((SCW - 30)/3);
    
    wegihtLabel.sd_layout
    .leftSpaceToView(vomlueLabel, 0)
    .topSpaceToView(blockLabel, 8)
    .heightIs(25)
    .widthIs((SCW - 30)/3);
    
    
    graindetailLabel.sd_layout
    .leftSpaceToView(dataView, 0)
    .topSpaceToView(grainLabel, 2)
    .heightIs(16.5)
    .widthIs((SCW - 30)/3);
    
    
    vomluedetailLabel.sd_layout
    .leftSpaceToView(graindetailLabel, 0)
    .topSpaceToView(grainLabel, 2)
    .heightIs(16.5)
    .widthIs((SCW - 30)/3);
    
    
    weightdetailLabel.sd_layout
    .leftSpaceToView(vomluedetailLabel, 0)
    .topSpaceToView(grainLabel, 2)
    .heightIs(16.5)
    .widthIs((SCW - 30)/3);
    
    
    //大板
    UILabel * largeBoardLabel = [RSCustomLabel creatCustomLabelAndText:@"大板" andTextColor:[UIColor colorWithHexColorStr:@"#161616"] andFont:[UIFont fontWithName:@"PingFangSC" size: 13] andTextAlignment:NSTextAlignmentLeft andBackgroundColor:[UIColor clearColor]];
    [dataView addSubview:largeBoardLabel];
    //大板数据内容
    
    
    
    largeBoardLabel.sd_layout
    .leftSpaceToView(dataView, 20)
    .topSpaceToView(graindetailLabel, 13.5)
    .widthIs(40)
    .heightIs(18.5);
    
    UILabel * turnsLabel = [RSCustomLabel creatCustomLabelAndText:@"76474657" andTextColor:[UIColor colorWithHexColorStr:@"#000000"] andFont:[UIFont fontWithName:@"PingFangSC" size: 18] andTextAlignment:NSTextAlignmentCenter andBackgroundColor:[UIColor clearColor]];
    [dataView addSubview:turnsLabel];
    
    
    UILabel * areaLabel = [RSCustomLabel creatCustomLabelAndText:@"76474657" andTextColor:[UIColor colorWithHexColorStr:@"#000000"] andFont:[UIFont fontWithName:@"PingFangSC" size: 18] andTextAlignment:NSTextAlignmentCenter andBackgroundColor:[UIColor clearColor]];
    [dataView addSubview:areaLabel];
    
    
    UILabel * turnsdetailLabel = [RSCustomLabel creatCustomLabelAndText:@"匝数" andTextColor:[UIColor colorWithHexColorStr:@"#9A9A9A"] andFont:[UIFont systemFontOfSize:12] andTextAlignment:NSTextAlignmentCenter andBackgroundColor:[UIColor clearColor]];
    [dataView addSubview:turnsdetailLabel];
    
    
    UILabel * areadetailLabel = [RSCustomLabel creatCustomLabelAndText:@"平方数" andTextColor:[UIColor colorWithHexColorStr:@"#9A9A9A"] andFont:[UIFont systemFontOfSize:12] andTextAlignment:NSTextAlignmentCenter andBackgroundColor:[UIColor clearColor]];
    [dataView addSubview:areadetailLabel];
    
    
    
    
    
    turnsLabel.sd_layout
    .leftSpaceToView(dataView, 0)
    .topSpaceToView(largeBoardLabel, 8)
    .heightIs(25)
    .widthIs((SCW - 30)/3);
    
    areaLabel.sd_layout
    .leftSpaceToView(turnsLabel, 0)
    .topSpaceToView(largeBoardLabel, 8)
    .heightIs(25)
    .widthIs((SCW - 30)/3);
    
    
    turnsdetailLabel.sd_layout
    .leftSpaceToView(dataView, 0)
    .topSpaceToView(turnsLabel, 2)
    .heightIs(16.5)
    .widthIs((SCW - 30)/3);
    
    
    areadetailLabel.sd_layout
    .leftSpaceToView(turnsdetailLabel, 0)
    .topSpaceToView(turnsLabel, 2)
    .heightIs(16.5)
    .widthIs((SCW - 30)/3);
    
    
    
    
    
    
    //公告的界面
    UIView * noticeView = [[UIView alloc]init];
    noticeView.backgroundColor = [UIColor colorWhiteShow];
    [headerView addSubview:noticeView];
    
    
    UILabel * noticeDetailLabel = [RSCustomLabel creatCustomLabelAndText:@"公告" andTextColor:[UIColor colorWithHexColorStr:@"#ffffff"] andFont:[UIFont systemFontOfSize:12] andTextAlignment:NSTextAlignmentCenter andBackgroundColor:[UIColor colorWithHexColorStr:@"#FF6700"]];
    [headerView addSubview:noticeDetailLabel];
    
    
    UILabel * informationLabel = [RSCustomLabel creatCustomLabelAndText:@"欢迎试用石来石往货物管理系统试用版" andTextColor:[UIColor colorWithHexColorStr:@"#323232"] andFont:[UIFont systemFontOfSize:14] andTextAlignment:NSTextAlignmentCenter andBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:informationLabel];
    
    
    UIImageView * noticeImage = [[UIImageView alloc]init];
    noticeImage.image = [UIImage imageNamed:@"system-moreb"];
    [headerView addSubview:noticeImage];
    
    
    
    userView.sd_layout
    .leftSpaceToView(headerView, 15)
    .topSpaceToView(headerView, 37)
    .widthIs(167)
    .heightIs(34);
    
    userView.layer.cornerRadius = 16.5;
    userView.layer.masksToBounds = YES;
//    userView.alpha = 0.1;
    
//    purchaseLabel.sd_layout
//    .leftSpaceToView(headerView, 15.5)
//    .topSpaceToView(headerView, 35.5)
//    .heightIs(33.5)
//    .widthIs(72);
    
    
    userBtn.sd_layout
    .leftSpaceToView(userView, 3)
    .centerYEqualToView(userView)
    .widthIs(28)
    .heightEqualToWidth();
    
   
    
    
    switchBtn.sd_layout
    .centerYEqualToView(userView)
    .rightSpaceToView(userView, 5)
    .widthIs(18)
    .heightEqualToWidth();
    
    
    userLabel.sd_layout
    .leftSpaceToView(userBtn, 7.5)
    .topSpaceToView(userView, 0)
    .heightIs(20)
    .rightSpaceToView(switchBtn, 0);
       
    positionLabel.sd_layout
    .leftEqualToView(userLabel)
    .rightEqualToView(userLabel)
    .topSpaceToView(userLabel, 0)
    .bottomSpaceToView(userView, 0);

    
    
    backImage.sd_layout
    .leftSpaceToView(headerView, 0)
    .rightSpaceToView(headerView, 0)
    .topSpaceToView(headerView, 0)
    .heightIs(213);
    
    
    
    dataView.sd_layout
    .leftSpaceToView(headerView, 15)
    .rightSpaceToView(headerView, 15)
    .topSpaceToView(headerView, 89)
    .heightIs(230);
    
    dataView.layer.cornerRadius = 16;
    dataView.layer.shadowColor = [UIColor colorWithHexColorStr:@"#999999" alpha:0.2].CGColor;
    dataView.layer.shadowOffset = CGSizeMake(0,2);
    dataView.layer.shadowOpacity = 1;
    dataView.layer.shadowRadius = 10;
    
    
    
    
    noticeView.sd_layout
    .leftEqualToView(dataView)
    .rightEqualToView(dataView)
    .topSpaceToView(dataView, 15)
    .heightIs(40);
    
    
    
    
    noticeDetailLabel.sd_layout
    .leftSpaceToView(headerView, 26)
    .topSpaceToView(dataView, 26)
    .widthIs(40)
    .heightIs(20);
    
    
    noticeDetailLabel.layer.cornerRadius = 9.25;
    noticeDetailLabel.layer.masksToBounds = YES;
    
    //    [noticeDetailLabel bringSubviewToFront:noticeView];
    
    
    
    informationLabel.sd_layout
    //    .centerYEqualToView(noticeView)
    .leftSpaceToView(noticeDetailLabel, 10.5)
    .topSpaceToView(dataView, 24.5)
    .heightIs(20)
    .rightSpaceToView(headerView, 55);
    
    
    noticeImage.sd_layout
    //    .centerYEqualToView(noticeView)
    .topSpaceToView(dataView,29)
    .rightSpaceToView(headerView, 25.5)
    .widthIs(7)
    .heightIs(12);
    
    
    //    [informationLabel bringSubviewToFront:noticeView];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.startPoint = CGPointMake(0, 0.49);
    gl.endPoint = CGPointMake(0.99, 0.61);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:252/255.0 green:199/255.0 blue:36/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:252/255.0 green:200/255.0 blue:40/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.frame = CGRectMake(0, 0, SCW - 30, 40);
    gl.cornerRadius = 12.5;
    [noticeView.layer addSublayer:gl];
    noticeView.layer.cornerRadius = 12.5;
    noticeView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.2].CGColor;
    noticeView.layer.shadowOffset = CGSizeMake(0,1);
    noticeView.layer.shadowOpacity = 1;
    noticeView.layer.shadowRadius = 5;
    
    
    [headerView setupAutoHeightWithBottomView:noticeView bottomMargin:20];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
}

- (void)userAction:(UIButton *)userBtn{
    RSRoleManagementViewController * roleMangementVc = [[RSRoleManagementViewController alloc]init];
    [self.navigationController pushViewController:roleMangementVc animated:YES];
}

//FIXME:切换用户信息
- (void)swithUserAction:(UIButton *)swithBtn{
    [self.stscmAlertview showView];
}

- (void)switchAction:(UIButton *)btn{
    //btn.selected = !btn.selected;
    self.currentSelectButton.selected = NO;
    [self.currentSelectButton setBackgroundColor:[UIColor colorWithHexColorStr:@"#323232"]];
    btn.selected = YES;
    self.currentSelectButton = btn;
    if (btn.selected) {
        [btn setBackgroundColor:[UIColor colorWhiteShow]];
    }
    //    else{
    //        [btn setBackgroundColor:[UIColor colorWithHexColorStr:@""]];
    //    }
}



//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return @"荒料管理";
//    }else if (section == 1){
//        return @"大板管理";
//    }else if (section == 2){
//        return @"基础数据";
//    }else{
//        return @"系统管理";
//    }
//}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString * STSCMHEADERVIEW = @"STSCMHEADERVIEW";
    RSStscmHeaderView * stscm = [[RSStscmHeaderView alloc]initWithReuseIdentifier:STSCMHEADERVIEW];
    if (section == 0) {
        stscm.titeLabel.text = @"荒料管理";
    }else if (section == 1){
        stscm.titeLabel.text = @"大板管理";
    }else if (section == 2){
        stscm.titeLabel.text = @"基础数据";
    }else{
        stscm.titeLabel.text = @"系统管理";
    }
    return stscm;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CELL = @"CELLID";
    RSPersonalEditionCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    if (!cell) {
        cell = [[RSPersonalEditionCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL];
    }
    cell.delegate = self;
    if (indexPath.section == 0) {
        cell.tyle = @"huangliao";
    }else if (indexPath.section == 1){
        cell.tyle = @"daban";
    }else if (indexPath.section == 2){
        cell.tyle = @"jichu";
    }else{
        cell.tyle = @"xitong";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 109;
}


- (void)selectPublishCurrentImage:(UIImage *)CurrentImage{
    RSFuntionViewController * funtionVc = [[RSFuntionViewController alloc]init];
    if ([CurrentImage isEqual:[UIImage imageNamed:@"荒料入库"]]) {
        funtionVc.funtionType = blockInType;
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"荒料出库"]]){
        funtionVc.funtionType = blockOutType;
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"库存管理"]]){
        funtionVc.funtionType = blockStockType;
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"报表中心"]]){
        funtionVc.funtionType = blockReportFormType;
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"大板入库"]]){
        funtionVc.funtionType = bigBoardInType;
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"大板出库"]]){
        funtionVc.funtionType = bigBoardOutType;
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"库存管理(1)"]]){
        funtionVc.funtionType = bigBoardStockType;
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"报表中心(1)"]]){
        funtionVc.funtionType = bigBoardReportFormType;
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"物料字典"]]){
        funtionVc.funtionType = materialDictionaryType;
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"仓库管理"]]){
        funtionVc.funtionType = warehouseManagememtType;
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"加工厂"]]){
        funtionVc.funtionType = processingFactoryType;
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"角色管理"]]){
        funtionVc.funtionType = roleManagementType;
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"用户管理"]]){
        funtionVc.funtionType = userManagementType;
    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"码单模版"]]){
        funtionVc.funtionType = codeSheetTemplateType;
    }
    [self.navigationController pushViewController:funtionVc animated:YES];
}




@end
