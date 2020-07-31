//
//  RSStscmAlertView.m
//  Stscm
//
//  Created by mac on 2020/7/21.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSStscmAlertView.h"


@interface RSStscmAlertView()


@property(nonatomic,strong)UIView *bgView;

@end


@implementation RSStscmAlertView




-(void)createView
{
    
    
    NSLog(@"===========================================================");
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15;
    self.clipsToBounds = YES;
    
        //仓库
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,self.bounds.size.width, 28)];
        label.text = @"选择";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 8 - 28, 11, 28, 28)];
        [cancelBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(label.frame) + 16, self.bounds.size.width, 23)];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.text = @"公司名称";
        timeLabel.font = [UIFont systemFontOfSize:16];
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        

        JJOptionView * fristView = [[JJOptionView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(timeLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        fristView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        fristView.layer.cornerRadius = 17;
        fristView.layer.masksToBounds = YES;
        fristView.title = @"1公司";
//        fristView.selectType = @"newWareHouse";
        fristView.dataSource = @[@"1公司",@"2公司",@"3公司"];
//      RSWeakself
        fristView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
           //weakSelf.index = selectedIndex;
            NSLog(@"------222------------%@",selectType);
        };
        [self addSubview:fristView];
//      _fristView = fristView;
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, CGRectGetMaxY(fristView.frame) + 10, self.bounds.size.width, 23)];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.text = @"角色";
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        
        JJOptionView * secondView = [[JJOptionView alloc] initWithFrame:CGRectMake(39, CGRectGetMaxY(nameLabel.frame) + 5, self.bounds.size.width - 78, 34)];
        secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        secondView.layer.cornerRadius = 17;
        secondView.layer.masksToBounds = YES;
        secondView.title = @"销售1";
//      secondView.selectType = @"newWareHouse";
        secondView.dataSource = @[@"销售1",@"销售2",@"销售3"];
//      RSWeakself
        secondView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex, NSString * _Nonnull selectType) {
           //weakSelf.index = selectedIndex;
            NSLog(@"------------------%@",selectType);
        };
        [self addSubview:secondView];
    
       UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondView.frame) + 20, self.bounds.size.width, 1)];
       view.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
       [self addSubview:view];
    
       
        
        UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonOne.frame = CGRectMake(0, CGRectGetMaxY(view.frame), self.bounds.size.width/2 - 0.5, 47);
        [buttonOne setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonOne setTitle:@"取消" forState:UIControlStateNormal];
        [buttonOne addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonOne];
        
        UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonOne.frame), CGRectGetMaxY(view.frame) + 10, 1, 30)];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self addSubview:midView];
        
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(CGRectGetMaxX(midView.frame), CGRectGetMaxY(view.frame),  self.bounds.size.width/2 - 0.5, 47);
        [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
//         [buttonTwo addTarget:self action:@selector(sendSalertAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonTwo];
        
   
}



- (void)showView
{
    
//    if ([self.selectType isEqualToString:@"edit"]) {
//        //编辑
//
//
//    }else{
//        //新建
//        self.index = 0;
//        self.secondIndex = 0;
//    }
   
    if (self.bgView) {
        return;
    }
    
    [self createView];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.bgView addGestureRecognizer:tap];
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.4;
    [window addSubview:self.bgView];
    [window addSubview:self];
    
}


- (void)deleteAction:(UIButton *)sender{
    [self closeView];
}

- (void)closeView
{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [IQKeyboardManager sharedManager].enable = YES;
    [self removeFromSuperview];
}

-(void)tap:(UIGestureRecognizer *)tap
{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
}


- (void)cancelAction:(UIButton *)cancelBtn{
    [self closeView];
}



@end
