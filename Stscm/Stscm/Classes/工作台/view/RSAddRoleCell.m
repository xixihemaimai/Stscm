//
//  RSAddRoleCell.m
//  Stscm
//
//  Created by mac on 2020/7/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSAddRoleCell.h"

@interface RSAddRoleCell()
{
    UIView * bottomview;
}

@end

@implementation RSAddRoleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel * roleLabel = [[UILabel alloc]initWithFrame:CGRectMake(12,0, 80, 50)];
        roleLabel.text = @"角色名称";
        roleLabel.textColor = [UIColor colorWithDyColorChangObject:roleLabel andHexLightColorStr:@"#333333" andHexDarkColorStr:@"#ffffff"];
        roleLabel.font = [UIFont systemFontOfSize:16];
        roleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:roleLabel];
        _roleLabel = roleLabel;
        
        UITextView * textview = [[UITextView alloc]initWithFrame:CGRectMake(95, 9, SCW - 95 - 15, 41)];
        textview.delegate = self;
        textview.textAlignment = NSTextAlignmentRight;
        textview.font = [UIFont systemFontOfSize:15];
        textview.scrollEnabled = NO;
        textview.wzb_placeholder = @"请输入";
        textview.wzb_placeholderColor = [UIColor lightGrayColor];
        textview.showsVerticalScrollIndicator = NO;
        textview.showsHorizontalScrollIndicator = NO;
        textview.returnKeyType = UIReturnKeyDone;
        textview.keyboardType = UIKeyboardTypeDefault;
        textview.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:textview];
        _textview = textview;

        bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(textview.frame), SCW, 1)];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [self.contentView addSubview:bottomview];
    }
    return self;
}

-(void)textViewDidChange:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textViewCell:didChangeText:)]) {
        [self.delegate textViewCell:self didChangeText:textView];
    }
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, frame.size.height);
    CGSize size = [textView sizeThatFits:constraintSize];
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,size.height);
    bottomview.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.frame) - 1, SCW, 1);
    UITableView *tableView = [self tableView];
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (UITableView *)tableView
{
    UIView * tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.textview.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
