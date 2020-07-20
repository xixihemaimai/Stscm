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
#import "RSRoleManagementViewController.h"

@interface RSStscmController ()<RSPersonalEditionCellDelegate>

@property (nonatomic,strong)UIButton * currentSelectButton;


@end

@implementation RSStscmController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"---------------------------");
    self.emptyView.hidden = YES;
    
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
    UILabel * purchaseLabel = [RSCustomLabel creatCustomLabelAndText:@"进销存" andTextColor:[UIColor colorWithHexColorStr:@"#161616"] andFont:[UIFont fontWithName:@"PingFangSC" size: 24] andTextAlignment:NSTextAlignmentLeft andBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:purchaseLabel];
    
    
    //用户
    UIButton * userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userBtn setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
    [userBtn addTarget:self action:@selector(userAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:userBtn];
    
    
    
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
            //            [btn setTitleColor:[UIColor colorWithHexColorStr:@"#FCC828"] forState:UIControlStateNormal];
            //            [btn setTitleColor:[UIColor colorWithHexColorStr:@"#323232"] forState:UIControlStateSelected];
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
    
    
    
    purchaseLabel.sd_layout
    .leftSpaceToView(headerView, 15.5)
    .topSpaceToView(headerView, 35.5)
    .heightIs(33.5)
    .widthIs(72);
    
    
    userBtn.sd_layout
    .rightSpaceToView(headerView, 15.5)
    .topSpaceToView(headerView, 38.5)
    .widthIs(28)
    .heightEqualToWidth();
    
    
    
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
//    if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版荒料入库"]]) {
//        //HLGL_HLRK荒料入库
//        //HLGL_HLRK_CGRK 荒料采购入库
//        //HLGL_HLRK_JGRK 荒料加工入库
//        //HLGL_HLRK_PYRK荒料盘盈入库
//        if (self.usermodel.pwmsUser.HLGL_HLRK == 1) {
//            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
//            variousFunctionsVc.selectType = @"huangliaoruku";
//            variousFunctionsVc.title = @"荒料入库";
//            variousFunctionsVc.usermodel = self.usermodel;
//            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
//        }else{
//            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
//        }
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版荒料出库"]]){
//        //HLGL_HLCK 荒料出库
//        //HLGL_HLCK_XSCK荒料销售出库
//        //HLGL_HLCK_JGCK荒料加工出库
//        //HLGL_HLCK_PKCK荒料盘亏出库
//        if (self.usermodel.pwmsUser.HLGL_HLCK == 1) {
//            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
//            variousFunctionsVc.selectType = @"huangliaochuku";
//            variousFunctionsVc.title = @"荒料出库";
//             variousFunctionsVc.usermodel = self.usermodel;
//            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
//        }else{
//             [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
//        }
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版库存管理"]]){
//        //HLGL_KCGL 库存管理
//        //HLGL_KCGL_YCCL荒料异常处理
//        //HLGL_KCGL_DB荒料调拨
//        if (self.usermodel.pwmsUser.HLGL_KCGL == 1) {
//            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
//            variousFunctionsVc.selectType = @"kucunguanli";
//            variousFunctionsVc.title = @"库存管理";
//             variousFunctionsVc.usermodel = self.usermodel;
//            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
//        }else{
//           [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
//        }
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版报表中心"]]){
//        //HLGL_BBZX报表中心
//        //HLGL_BBZX_KCYE荒料库存余额
//        //HLGL_BBZX_KCLS荒料库存流水
//        //HLGL_BBZX_RKMX荒料入库明细
//        //HLGL_BBZX_CKMX 荒料出库明细
//        if (self.usermodel.pwmsUser.HLGL_BBZX == 1) {
//            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
//            variousFunctionsVc.selectType = @"baobiaozhongxin";
//            variousFunctionsVc.title = @"报表中心";
//             variousFunctionsVc.usermodel = self.usermodel;
//            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
//        }else{
//             [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
//        }
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版大板入库"]]){
//        //DBGL_DBRK大板入库
//        //DBGL_DBRK_CGRK大板采购入库
//        //DBGL_DBRK_JGRK大板加工入库
//        //DBGL_DBRK_PYRK大板盘盈入库
//        if (self.usermodel.pwmsUser.DBGL_DBRK == 1) {
//            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
//            variousFunctionsVc.selectType = @"dabanruku";
//            variousFunctionsVc.title = @"大板入库";
//             variousFunctionsVc.usermodel = self.usermodel;
//            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
//        }else{
//            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
//        }
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版大板出库"]]){
//        //DBGL大板管理
//        //DBGL_DBCK大板出库
//        //DBGL_DBCK_XSCK大板销售出库
//        //DBGL_DBCK_JGCK大板加工出库
//        //DBGL_DBCK_PKCK大板盘亏出库
//        if (self.usermodel.pwmsUser.DBGL_DBCK == 1) {
//            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
//            variousFunctionsVc.selectType = @"dabanchuku";
//            variousFunctionsVc.title = @"大板出库";
//             variousFunctionsVc.usermodel = self.usermodel;
//            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
//        }else{
//             [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
//
//        }
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版库存管理(1)"]]){
//        //DBGL_KCGL大板库存管理
//        //DBGL_KCGL_YCCL大板异常处理
//        //DBGL_KCGL_DB大板调拨
//        if (self.usermodel.pwmsUser.DBGL_KCGL == 1) {
//            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
//            variousFunctionsVc.selectType = @"kucunguanli1";
//            variousFunctionsVc.title = @"库存管理";
//             variousFunctionsVc.usermodel = self.usermodel;
//            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
//        }else{
//            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
//        }
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版报表中心(1)"]]){
//        //DBGL_BBZX 大板报表中心
//        //DBGL_BBZX_KCYE大板库存余额
//        //DBGL_BBZX_KCLS大板库存流水
//        //DBGL_BBZX_RKMX大板入库明细
//        //DBGL_BBZX_CKMX大板出库明细
//        if (self.usermodel.pwmsUser.DBGL_BBZX == 1) {
//            RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
//            variousFunctionsVc.selectType = @"baobiaozhongxin1";
//            variousFunctionsVc.title = @"报表中心";
//             variousFunctionsVc.usermodel = self.usermodel;
//            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
//        }else{
//            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
//        }
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版数据字典"]]){
//        RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
//        variousFunctionsVc.selectType = @"shujuzidian";
//         variousFunctionsVc.title = @"数据字典";
//         [self.navigationController pushViewController:variousFunctionsVc animated:YES];
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版物料字典"]]){
//        //JCSJ_CKGL仓库管理
//        //JCSJ_WLZD物料字典
//        //TYQX通用权利
//        if (self.usermodel.pwmsUser.JCSJ_WLZD == 1) {
//            //物料字典
//            RSMaterialManagementViewController * materialManagementVc = [[RSMaterialManagementViewController alloc]init];
//            materialManagementVc.usermodel = self.usermodel;
//            [self.navigationController pushViewController:materialManagementVc animated:YES];
//        }else{
//            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
//        }
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版用户管理"]]){
//        //XTGL系统管理
//        //XTGL_JSGL角色管理
//        //XTGL_YHGL用户管理
//        if (self.usermodel.pwmsUser.XTGL_YHGL == 1) {
//            RSUserManagementViewController * variousFunctionsVc = [[RSUserManagementViewController alloc]init];
//            variousFunctionsVc.usermodel = self.usermodel;
//            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
//        }else{
//             [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
//        }
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版角色管理"]]){
//        if (self.usermodel.pwmsUser.XTGL_JSGL == 1) {
//            RSMaterialDetailsViewController * variousFunctionsVc = [[RSMaterialDetailsViewController alloc]init];
//            variousFunctionsVc.usermodel = self.usermodel;
//            [self.navigationController pushViewController:variousFunctionsVc animated:YES];
//        }else{
//             [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
//        }
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版码单模版"]]){
//        if (self.usermodel.pwmsUser.XTGL_MBGL == 1) {
//            RSTemplateViewController * templateVc = [[RSTemplateViewController alloc]init];
//            templateVc.usermodel = self.usermodel;
//            [self.navigationController pushViewController:templateVc animated:YES];
//        }else{
//            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
//        }
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版权限管理"]]){
//        RSVariousFunctionsViewController * variousFunctionsVc = [[RSVariousFunctionsViewController alloc]init];
//        variousFunctionsVc.selectType = @"quanxianguli";
//        variousFunctionsVc.title = @"权限管理";
//        variousFunctionsVc.usermodel = self.usermodel;
//         [self.navigationController pushViewController:variousFunctionsVc animated:YES];
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"个人版仓库管理"]]){
//        //JCSJ_CKGL仓库管理
//        //JCSJ_WLZD物料字典
//        //TYQX通用权利
//        if (self.usermodel.pwmsUser.JCSJ_CKGL == 1) {
//            RSWarehouseManagementViewController * warehouseManagementVc = [[RSWarehouseManagementViewController alloc]init];
//            warehouseManagementVc.usermodel = self.usermodel;
//            [self.navigationController pushViewController:warehouseManagementVc animated:YES];
//        }else{
//            [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
//        }
//    }else if ([CurrentImage isEqual:[UIImage imageNamed:@"加工厂"]]){
//        if (self.usermodel.pwmsUser.JCSJ_JGC == 1) {
//            RSProcessingFactoryViewController * processingFactoryVc = [[RSProcessingFactoryViewController alloc]init];
//            processingFactoryVc.usermodel = self.usermodel;
//            [self.navigationController pushViewController:processingFactoryVc animated:YES];
//        }else{
//             [SVProgressHUD showInfoWithStatus:@"没有开通这个权限"];
//        }
//    }
}




@end
