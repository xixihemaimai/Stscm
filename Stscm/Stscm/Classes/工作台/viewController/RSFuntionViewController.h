//
//  RSFuntionViewController.h
//  Stscm
//
//  Created by mac on 2020/8/7.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum _FuntionType{
    blockInType = 0,
    blockOutType = 1,
    blockStockType = 2,
    blockReportFormType = 3,
    bigBoardInType = 4,
    bigBoardOutType = 5,
    bigBoardStockType = 6,
    bigBoardReportFormType = 7,
    materialDictionaryType = 8,
    warehouseManagememtType =9,
    processingFactoryType = 10,
    roleManagementType = 11,
    userManagementType = 12,
    codeSheetTemplateType = 13
}FuntionType;

@interface RSFuntionViewController : RSBaseViewController

@property (nonatomic,assign)FuntionType funtionType;

@end

NS_ASSUME_NONNULL_END
