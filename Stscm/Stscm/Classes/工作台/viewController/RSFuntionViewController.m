//
//  RSFuntionViewController.m
//  Stscm
//
//  Created by mac on 2020/8/7.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSFuntionViewController.h"
#import "RSTypeListViewController.h"

#define ECA 2
#define MARGIN 15

@interface RSFuntionViewController ()

@end

@implementation RSFuntionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"--------------------------%d",self.funtionType);
    //这边需要怎么设置需要的界面
    self.emptyView.hidden = YES;
    if (self.funtionType == blockInType) {
        self.title = @"荒料入库";
    }else if (self.funtionType == blockOutType){
        self.title = @"荒料出库";
    }else if (self.funtionType == blockStockType){
        self.title = @"库存管理";
    }else if (self.funtionType == blockReportFormType){
        self.title = @"报表中心";
    }else if (self.funtionType == bigBoardInType){
        self.title = @"大板入库";
    }else if (self.funtionType == bigBoardOutType){
        self.title = @"大板出库";
    }else if (self.funtionType == bigBoardStockType){
        self.title = @"库存管理";
    }else if (self.funtionType == bigBoardReportFormType){
        self.title = @"报表中心";
    }else if (self.funtionType == materialDictionaryType){
        self.title = @"物料字典";
    }else if (self.funtionType == warehouseManagememtType){
        self.title = @"仓库管理";
    }else if (self.funtionType == processingFactoryType){
        self.title = @"加工厂";
    }else if (self.funtionType == roleManagementType){
        self.title = @"角色管理";
    }else if (self.funtionType == userManagementType){
        self.title = @"用户管理";
    }else if (self.funtionType == codeSheetTemplateType){
        self.title = @"码单模板";
    }
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    CGFloat btnW = (SCW - (ECA + 1)*MARGIN)/ECA;
    CGFloat btnH = btnW;
    int count = 0;
    if (self.funtionType == blockInType || self.funtionType == blockOutType || self.funtionType == blockStockType || self.funtionType == bigBoardInType || self.funtionType == bigBoardOutType || self.funtionType == bigBoardStockType) {
        //荒料入库和大板入库，荒料出库，大板出库
        count = 3;
    }else if (self.funtionType == bigBoardReportFormType || self.funtionType == blockReportFormType){
        count = 6;
    }
    for (int i = 0 ; i < count; i++) {
        RSPublishButton * publishBtn = [RSPublishButton buttonWithType:UIButtonTypeCustom];
        publishBtn.adjustsImageWhenHighlighted = NO;
        NSInteger row = i / ECA;
        NSInteger colom = i % ECA;
        CGFloat btnX =  colom * (MARGIN + btnW) + MARGIN;
        CGFloat btnY =  row * (MARGIN + btnH) + MARGIN;
        publishBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        publishBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        publishBtn.imageView.sd_layout.topSpaceToView(publishBtn, 38);
        publishBtn.titleLabel.sd_layout.bottomSpaceToView(publishBtn, 40);
        if (self.funtionType == blockInType || self.funtionType == bigBoardInType ) {
                if (i == 0) {
                    [publishBtn setTitle:@"采购入库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 11"] forState:UIControlStateNormal];
                }else if (i == 1){
                    [publishBtn setTitle:@"加工入库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 3"] forState:UIControlStateNormal];
                }else if (i == 2){
                    [publishBtn setTitle:@"盘盈入库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标"] forState:UIControlStateNormal];
                }
        }
            else if (self.funtionType == blockOutType || self.funtionType == bigBoardOutType){
                if (i == 0) {
                    [publishBtn setTitle:@"销售出库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 2"] forState:UIControlStateNormal];
                }else if (i == 1){
                    [publishBtn setTitle:@"加工出库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 3"] forState:UIControlStateNormal];
                }else if (i == 2){
                    [publishBtn setTitle:@"盘亏出库" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 4"] forState:UIControlStateNormal];
                }
            }
            else if (self.funtionType == blockStockType || self.funtionType == bigBoardStockType){
                  if (i == 0) {
                     [publishBtn setTitle:@"异常处理" forState:UIControlStateNormal];
                     [publishBtn setImage:[UIImage imageNamed:@"图标 copy 5"] forState:UIControlStateNormal];
                  }else if (i == 1){
                     [publishBtn setTitle:@"调拨" forState:UIControlStateNormal];
                     [publishBtn setImage:[UIImage imageNamed:@"图标 copy 6"] forState:UIControlStateNormal];
                  }else if (i == 2){
                      [publishBtn setTitle:@"现货展示区" forState:UIControlStateNormal];
                      [publishBtn setImage:[UIImage imageNamed:@"图标 copy 9复制"] forState:UIControlStateNormal];
                  }
                //荒料部分
            }
            else if(self.funtionType == blockReportFormType || self.funtionType == bigBoardReportFormType){
                
                if (i == 0) {
                    [publishBtn setTitle:@"库存余额表" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 7"] forState:UIControlStateNormal];
                }else if (i == 1){
                    [publishBtn setTitle:@"库存流水账" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 8"] forState:UIControlStateNormal];
                }else if (i == 2){
                    [publishBtn setTitle:@"入库明细表" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 9"] forState:UIControlStateNormal];
                }else if (i == 3){
                    [publishBtn setTitle:@"出库明细表" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 10"] forState:UIControlStateNormal];
                }else if (i == 4){
                    [publishBtn setTitle:@"加工跟单" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 9复制 2"] forState:UIControlStateNormal];
                }else{
                    [publishBtn setTitle:@"出材率" forState:UIControlStateNormal];
                    [publishBtn setImage:[UIImage imageNamed:@"图标 copy 9复制 3"] forState:UIControlStateNormal];
                }
        }
        //[publishBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle"] forState:UIControlStateNormal];
        [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        [publishBtn addTarget:self action:@selector(jumpFunctionView:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:publishBtn];
        [headerView setupAutoHeightWithBottomView:publishBtn bottomMargin:10];
        [headerView layoutIfNeeded];
        self.tableview.tableHeaderView = headerView;
        //[publishBtn bringSubviewToFront:self.contetnView];
    }
}


- (void)jumpFunctionView:(UIButton *)sender{
    RSTypeListViewController * typelistVc = [[RSTypeListViewController alloc]init];
    [self.navigationController pushViewController:typelistVc animated:YES];
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}




@end
