//
//  RSRoleUserCell.m
//  Stscm
//
//  Created by mac on 2020/7/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSRoleUserCell.h"

@implementation RSRoleUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        self.contentView.backgroundColor = [UIColor colorWithDyColorChangObject:self.contentView andHexLightColorStr:@"#ffffff" andHexDarkColorStr:@"#000000"];
        UIView * roleUserView = [[UIView alloc]init];
        roleUserView.backgroundColor = [UIColor colorWithDyColorChangObject:roleUserView andHexLightColorStr:@"#f9f9f9" andHexDarkColorStr:@"#696969"];
        [self.contentView addSubview:roleUserView];
        
        UILabel * roleUserLabel = [[UILabel alloc]init];
        roleUserLabel.text = @"用户一";
        roleUserLabel.textAlignment = NSTextAlignmentLeft;
        roleUserLabel.font = [UIFont systemFontOfSize:16];
        roleUserLabel.textColor = [UIColor colorWithDyColorChangObject:roleUserLabel andHexLightColorStr:@"#333333" andHexDarkColorStr:@"#ffffff"];
        [roleUserView addSubview:roleUserLabel];
        
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor colorWithDyColorChangObject:roleUserLabel andHexLightColorStr:@"#333333" andHexDarkColorStr:@"#ffffff"] forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [roleUserView addSubview:deleteBtn];
        _deleteBtn = deleteBtn;
        
        roleUserView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .heightIs(40);
        
        roleUserLabel.sd_layout
        .centerYEqualToView(roleUserView)
        .leftSpaceToView(roleUserView, 12)
        .widthRatioToView(roleUserView, 0.5)
        .heightIs(22.5);
        
        deleteBtn.sd_layout
        .centerYEqualToView(roleUserView)
        .rightSpaceToView(roleUserView, 12)
        .topSpaceToView(roleUserView, 0)
        .bottomSpaceToView(roleUserView, 0)
        .widthIs(50);
      
        
        
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
