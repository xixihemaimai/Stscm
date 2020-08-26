//
//  RSRoleTimeCell.m
//  Stscm
//
//  Created by mac on 2020/7/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSRoleTimeCell.h"

@implementation RSRoleTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel * timeLabel = [[UILabel alloc]init];
        timeLabel.text = @"角色名称";
        timeLabel.textColor = [UIColor colorWithDyColorChangObject:timeLabel andHexLightColorStr:@"#333333" andHexDarkColorStr:@"#ffffff"];
        timeLabel.font = [UIFont systemFontOfSize:16];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
        
        UIButton * timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [timeBtn setTitle:@"2020-02-02 12:23:23" forState:UIControlStateNormal];
        [timeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        timeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.contentView addSubview:timeBtn];
        _timeBtn = timeBtn;
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [self.contentView addSubview:bottomview];
        
        timeLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .heightIs(22.5)
        .widthIs(80);
        
        timeBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(timeLabel, 10)
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
