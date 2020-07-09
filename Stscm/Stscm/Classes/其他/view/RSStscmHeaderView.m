//
//  RSStscmHeaderView.m
//  Stscm
//
//  Created by mac on 2020/6/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSStscmHeaderView.h"

@implementation RSStscmHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        UILabel * titeLabel = [RSCustomLabel creatCustomLabelAndText:@"" andTextColor:[UIColor colorWithHexColorStr:@"#282D38"] andFont:[UIFont fontWithName:@"PingFangSC" size: 16] andTextAlignment:NSTextAlignmentLeft andBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:titeLabel];
        _titeLabel = titeLabel;
        
        
        titeLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 16)
        .rightSpaceToView(self.contentView, 16)
        .heightIs(22.5);
        
    }
    return self;
}

@end
