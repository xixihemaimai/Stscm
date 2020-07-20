//
//  RSAddRoleViewController.m
//  Stscm
//
//  Created by mac on 2020/7/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSAddRoleViewController.h"
#import "RSAddRoleCell.h"



@interface RSAddRoleViewController ()<UITextViewDelegate>


@property(nonatomic,strong)NSMutableDictionary *dicHeight;//高度

//记录内容
//@property (strong, nonatomic) NSString *contentInfoString;

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
    
        
    

    
}

//模拟数据刷新
-(void)textViewDidChange:(UITextView *)textView{
    NSLog(@"======---------------%ld=============%@",textView.tag,textView.text);
}






-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ADDROLECELLID = @"ADDROLECELLID";
    RSAddRoleCell * cell = [tableView dequeueReusableCellWithIdentifier:ADDROLECELLID];
    if (!cell) {
        cell = [[RSAddRoleCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ADDROLECELLID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    cell.contentView.tag = 1000 + indexPath.row;
    cell.textView.tag = 1000 + indexPath.row;
    cell.textView.delegate = self;
    
    
//    if (![cell.contentView viewWithTag:1000 + indexPath.row]) {
//        UITextView *view = [UITextView new];
//        view.delegate = self;
//        view.wzb_placeholder = @"请输入";
//        view.wzb_placeholderColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
//        view.font = [UIFont systemFontOfSize:17];
//        view.frame = CGRectMake(SCW * 0.3,0 , SCW * 0.5, 50);
//        view.tag = 1000 + indexPath.row;
//        [cell.contentView addSubview:view];
//    }
    
    [self tableViewCellAutoHeight:indexPath cell:cell];
    
    return cell;
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


#pragma mark -自动改变行高
- (void)tableViewCellAutoHeight:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell{
    UITextView * textView = [cell.contentView viewWithTag:1000 + indexPath.row];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [NSString stringWithFormat:@"%@",indexPath];
    if(self.dicHeight[key]){
        NSNumber *number = self.dicHeight[key];
        if (number.floatValue > 50) {
            return number.floatValue;
        }
    }
    return 50;
}





//- (void)textViewDidChange:(RSTextView *)textView // 此处取巧，把代理方法参数类型直接改成自定义的WSTextView类型，为了可以使用自定义的placeholder属性，省去了通过给控制器WSTextView类型属性这样一步。
//{
//
//    NSLog(@"==============================%@",textView.text);
//
//
//    NSLog(@"=0--------------------------%@",[self delSpaceAndNewline:textView.text]);
//
//    if (textView.hasText) { // textView.text.length
//        textView.placeholder = @"";
//    } else {
//        textView.placeholder = @"请输入";
//    }
//    CGRect bounds = textView.bounds;
//    // 计算高度
//    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
//    CGSize newSize = [textView sizeThatFits:maxSize];
//    bounds.size = newSize;
//    textView.bounds = bounds;
//
//    // 重新计算高度
//    [self.tableview beginUpdates];
//    [self.tableview endUpdates];
//
//}
//










@end
