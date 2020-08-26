//
//  RSAddRoleHeaderView.m
//  Stscm
//
//  Created by mac on 2020/7/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSAddRoleHeaderView.h"

@implementation RSAddRoleHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithDyColorChangObject:self.contentView andHexLightColorStr:@"#ffffff" andHexDarkColorStr:@"#000000"];
        
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"用户列表";
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = [UIColor colorWithDyColorChangObject:titleLabel andHexLightColorStr:@"#333333" andHexDarkColorStr:@"#ffffff"];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        
        UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor colorWithDyColorChangObject:addBtn andHexLightColorStr:@"#333333" andHexDarkColorStr:@"#ffffff"] forState:UIControlStateNormal];
        [addBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FCC828"]];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:addBtn];
        
        titleLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .widthIs(65.5)
        .heightIs(22.5);
        
        
        addBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 12)
        .widthIs(50)
        .heightIs(28);
        
        addBtn.layer.cornerRadius = 14;
        addBtn.layer.masksToBounds = YES;
        
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
