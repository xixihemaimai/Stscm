//
//  RSPersonSecondCell.m
//  石来石往
//
//  Created by mac on 2017/9/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSPersonSecondCell.h"

@implementation RSPersonSecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameLabel.font = [UIFont systemFontOfSize:Textadaptation(15)];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        
        UILabel * phoneLabel = [[UILabel alloc]init];
        _phoneLabel = phoneLabel;
        phoneLabel.textAlignment = NSTextAlignmentRight;
        phoneLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        phoneLabel.font = [UIFont systemFontOfSize:Textadaptation(15)];
        [self.contentView addSubview:phoneLabel];
        
        UIImageView * rightImageView = [[UIImageView alloc]init];
             rightImageView.image = [UIImage imageNamed:@"system-backnew copy 5"];
             [self.contentView addSubview:rightImageView];
        
        
        UIView * bottoview = [[UIView alloc]init];
        bottoview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottoview];
        
        
        nameLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .heightIs(15)
        .widthRatioToView(self.contentView, 0.4);
        
        phoneLabel.sd_layout
        .leftSpaceToView(nameLabel, 10)
        .topSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 32);
        
        rightImageView.sd_layout
               .centerYEqualToView(self.contentView)
               .rightSpaceToView(self.contentView, 13)
               .widthIs(9)
               .heightIs(15);
        
        bottoview.sd_layout
        .leftSpaceToView(self.contentView, 4)
        .rightSpaceToView(self.contentView, 4)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
        
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
