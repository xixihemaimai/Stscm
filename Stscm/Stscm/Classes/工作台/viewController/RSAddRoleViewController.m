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

@interface RSAddRoleViewController ()<RSAddRoleCellDelegate>
/**用来保存第一组前4个cell要显示的内容，这边需要考虑修改和新增的问题*/
@property (nonatomic,strong) NSMutableArray *data;
/**用来记录选择哪个cell进行编辑的位置的步骤*/
@property (nonatomic,assign)NSInteger selectIndex;

@end

@implementation RSAddRoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emptyView.hidden = YES;
    self.title = @"添加角色";
    self.selectIndex = 100000000000000;
    
    UIButton * addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 60, 60)];
    [addBtn setTitle:@"保存" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor colorWithDyColorChangObject:addBtn andHexLightColorStr:@"#666666" andHexDarkColorStr:@"#ffffff"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.data = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
    
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
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            RSAddRoleCell * cell = (RSAddRoleCell *)[tableView cellForRowAtIndexPath:indexPath];
            if (cell.textview.tag == self.selectIndex) {
                if (cell.textview.frame.size.height <= 50) {
                    cell.cellHeight = 50;
                    return 50;
                }else{
                    cell.cellHeight = cell.textview.frame.size.height + 6;
                    return cell.textview.frame.size.height + 6;
                }
            }else{
                if (cell.cellHeight < 50) {
                    return 50;
                }else{
                    return cell.cellHeight;
                }
            }
        }else{
            return 50;
        }
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
            cell.delegate = self;
            cell.textview.text = self.data[indexPath.row];
            cell.textview.tag = indexPath.row;
            if (indexPath.row == 0) {
                cell.roleLabel.text = @"角色代码";
                cell.textview.text = @"0320";
                cell.textview.editable = false;
            }else if (indexPath.row == 1){
                cell.roleLabel.text = @"角色名称";
                cell.textview.editable = true;
            }else if (indexPath.row == 2){
                cell.roleLabel.text = @"创建人";
                cell.textview.editable = true;
            }else{
                cell.roleLabel.text = @"修改人";
                cell.textview.editable = true;
            }
            cell.selected = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            cell.timeBtn.tag = indexPath.row + 100000000000;
            [cell.timeBtn addTarget:self action:@selector(choiceTimeAction:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }else{
        RSRoleUserCell * cell = [tableView dequeueReusableCellWithIdentifier:ADDROLECELLID];
        if (!cell) {
            cell = [[RSRoleUserCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ADDROLECELLID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.deleteBtn.tag = indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}


- (void)deleteBtnAction:(UIButton *)deleteBtn{
    [JHSysAlertUtil presentAlertViewWithTitle:@"是否确定删除该用户" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:NO cancel:^{
        //取消
    } confirm:^{
        //确定
    }];
}



- (void)textViewCell:(RSAddRoleCell *)cell didChangeText:(UITextView *)textView
{
    NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
    NSMutableArray * data = [self.data mutableCopy];
    data[indexPath.row] = textView.text;
    self.selectIndex = textView.tag;
    self.data = [data copy];
}


- (void)choiceTimeAction:(UIButton *)timeBtn{
    NSLog(@"----------------------%ld",timeBtn.tag);
    SPDateTimePickerView *pickerView = [[SPDateTimePickerView alloc]init];
    if (timeBtn.tag == 100000000000) {
        RSRoleTimeCell * cell = (RSRoleTimeCell *)[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        NSLog(@"==================%@",cell.timeBtn.currentTitle);
        pickerView.timeStr = cell.timeBtn.currentTitle;
    }
    pickerView.pickerViewMode = 5;
    //pickerView.delegate = self;
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
}




@end
