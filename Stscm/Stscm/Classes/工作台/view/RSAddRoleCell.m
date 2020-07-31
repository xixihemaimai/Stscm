//
//  RSAddRoleCell.m
//  Stscm
//
//  Created by mac on 2020/7/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSAddRoleCell.h"


@implementation RSAddRoleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel * roleLabel = [[UILabel alloc]init];
        roleLabel.text = @"角色名称";
        roleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        roleLabel.font = [UIFont systemFontOfSize:16];
        roleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:roleLabel];
        _roleLabel = roleLabel;
        
        UITextView *textView = [[UITextView alloc] init];
        textView.wzb_placeholder = @"请输入";
        textView.wzb_placeholderColor = [UIColor colorWithHexColorStr:@"#999999"];
        textView.textAlignment=NSTextAlignmentRight;
        textView.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:textView];
        _textView = textView;
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [self.contentView addSubview:bottomview];
        
        
        roleLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .heightIs(22.5)
        .widthIs(80);
        
        textView.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(roleLabel, 10)
        .rightSpaceToView(self.contentView, 12)
        .topEqualToView(self.contentView)
        .bottomEqualToView(self.contentView);
        
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(1)
        .bottomEqualToView(self.contentView);
        
        
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
