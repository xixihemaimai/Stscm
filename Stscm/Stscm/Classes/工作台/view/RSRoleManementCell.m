//
//  RSRoleManementCell.m
//  Stscm
//
//  Created by mac on 2020/7/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSRoleManementCell.h"

@implementation RSRoleManementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel * roleLabel = [[UILabel alloc]init];
        roleLabel.text = @"管理员";
        roleLabel.textColor = [UIColor colorWithDyColorChangObject:roleLabel andHexLightColorStr:@"#333333" andHexDarkColorStr:@"#ffffff"];
        roleLabel.textAlignment = NSTextAlignmentLeft;
        roleLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:roleLabel];
        
        UIButton * modifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [modifyBtn setTitle:@"修改" forState:UIControlStateNormal];
        [modifyBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FCC828"] forState:UIControlStateNormal];
        modifyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:modifyBtn];
        _modifyBtn = modifyBtn;
        
        
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#FCC828"];
        [self.contentView addSubview:midView];
        
        
        
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FCC828"] forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:deleteBtn];
        _deleteBtn = deleteBtn;
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [self.contentView addSubview:bottomview];
        
        
        roleLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 11)
        .widthRatioToView(self.contentView, 0.7)
        .heightIs(24);
        
        deleteBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 11)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .widthIs(50);
        
        midView.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(deleteBtn, 12.5)
        .widthIs(0.5)
        .heightIs(18.5);
        
        modifyBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(midView, 12.5)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .widthIs(50);
        
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
