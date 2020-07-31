//
//  RSAddRoleViewController.m
//  Stscm
//
//  Created by mac on 2020/7/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSAddRoleViewController.h"
#import "RSAddRoleCell.h"

#import "RSRoleTimeCell.h"

#import "RSAddRoleHeaderView.h"
#import "RSRoleUserCell.h"






@interface RSAddRoleViewController ()<UITextViewDelegate>


@property(nonatomic,strong)NSMutableDictionary *dicHeight;//高度



@end

@implementation RSAddRoleViewController

-(NSMutableDictionary *)dicHeight{
    if (!_dicHeight) {
        _dicHeight = [NSMutableDictionary dictionary];
    }
    return _dicHeight;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emptyView.hidden = YES;
    self.title = @"添加角色";
    
    UIButton * addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 60, 60)];
    [addBtn setTitle:@"保存" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//保存
- (void)saveAction:(UIButton *)saveBtn{
    NSLog(@"保存");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    }else{
        return 5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSString *key = [NSString stringWithFormat:@"%@",indexPath];
        if(self.dicHeight[key]){
            NSNumber *number = self.dicHeight[key];
            if (number.floatValue > 50) {
                return number.floatValue;
            }
        }
        return 50;
    }else{
        return 45;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        static NSString * ADDROLEHEADERVIEWID = @"ADDROLEHEADERVIEWID";
        RSAddRoleHeaderView * addRoleHeaderview = [[RSAddRoleHeaderView alloc]initWithReuseIdentifier:ADDROLEHEADERVIEWID];
        return addRoleHeaderview;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 51;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ADDROLECELLID = @"ADDROLECELLID";
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            RSAddRoleCell * cell = [tableView dequeueReusableCellWithIdentifier:ADDROLECELLID];
            if (!cell) {
                cell = [[RSAddRoleCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ADDROLECELLID];
            }
            cell.contentView.tag = 1000 + indexPath.row;
            cell.textView.tag = 1000 + indexPath.row;
            cell.textView.delegate = self;
            if (indexPath.row == 0) {
                cell.textView.text = @"0032";
                cell.roleLabel.text = @"角色代码";
                cell.textView.editable = false;
            }else if (indexPath.row == 1){
                cell.roleLabel.text = @"角色名称";
                cell.textView.editable = true;
            }else if (indexPath.row == 2){
                cell.roleLabel.text = @"创建人";
                cell.textView.editable = true;
            }else{
                cell.roleLabel.text = @"修改人";
                cell.textView.editable = true;
            }
            [self tableViewCellAutoHeight:indexPath cell:cell];
            return cell;
        }else{
            RSRoleTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:ADDROLECELLID];
            if (!cell) {
                cell = [[RSRoleTimeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ADDROLECELLID];
            }
            if (indexPath.row == 4) {
                cell.timeLabel.text = @"创建时间";
            }else{
                cell.timeLabel.text = @"修改时间";
            }
            cell.timeBtn.tag = 100000 + indexPath.row;
            [cell.timeBtn addTarget:self action:@selector(choiceTimeAction:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }else{
        RSRoleUserCell * cell = [tableView dequeueReusableCellWithIdentifier:ADDROLECELLID];
        if (!cell) {
            cell = [[RSRoleUserCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ADDROLECELLID];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)choiceTimeAction:(UIButton *)timeBtn{
    NSLog(@"----------------------%ld",timeBtn.tag);
    SPDateTimePickerView *pickerView = [[SPDateTimePickerView alloc]init];
    pickerView.pickerViewMode = 5;
//       pickerView.delegate = self;
    pickerView.title = @"时间选择器";
    [self.view addSubview:pickerView];
    [pickerView showDateTimePickerView];
    __weak typeof (pickerView)WeakPickView = pickerView;
    pickerView.timeBlock = ^(BOOL isCancel, NSString *timeStr) {
        NSLog(@"----------------%d------------%@",isCancel,timeStr);
        if (isCancel == false) {
           [timeBtn setTitle:timeStr forState:UIControlStateNormal];
        }
        [WeakPickView removeFromSuperview];
    };
    
    
//    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDayHourMinute scrollToDate:[self nsstringConversionNSDate:timeBtn.currentTitle] CompleteBlock:^(NSDate *selectDate) {
//        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
//        [timeBtn setTitle:date forState:UIControlStateNormal];
//    }];
//    [datepicker show];
}


//模拟数据刷新
-(void)textViewDidChange:(UITextView *)textView{
  NSLog(@"======---------------%ld=============%@",textView.tag,textView.text);
}

#pragma mark -自动改变行高
- (void)tableViewCellAutoHeight:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell{
//    UITextView * textView = [cell.contentView viewWithTag:1000 + indexPath.row];
    NSLog(@"----------%@",[cell.contentView viewWithTag:1000 + indexPath.row]);
    UITextView * textView = nil;
    for (UIView * view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UITextView class]]) {
            textView = (UITextView *)view;
        }
    }
    __weak typeof (self)WeakSelf = self;
    __weak typeof (textView)WeakTextView = textView;
    // 最大高度为300 改变高度的 block
    [textView wzb_autoHeightWithMaxHeight:300 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        CGRect frame = WeakTextView.frame;
        frame.size.height = currentTextViewHeight;
        if (frame.size.height < 50) {
            frame.size.height = 50;
        }
        WeakTextView.frame = frame;
//        [UIView animateWithDuration:0.2 animations:^{
//            WeakTextView.frame = frame;
//        } completion:^(BOOL finished) {
//        }];
        NSString *key = [NSString stringWithFormat:@"%@",indexPath];
        NSNumber *height = [NSNumber numberWithFloat:currentTextViewHeight];
        if (self.dicHeight[key]) {
            NSNumber *oldHeight = self.dicHeight[key];
            if (oldHeight.floatValue != height.floatValue) {
                [self.dicHeight setObject:height forKey:key];
            }
        }
        else{
            [self.dicHeight setObject:height forKey:key];
        }
        [WeakSelf.tableview beginUpdates];
        [WeakSelf.tableview endUpdates];
    }];
}



@end
