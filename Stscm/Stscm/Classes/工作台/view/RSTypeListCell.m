//
//  RSTypeListCell.m
//  Stscm
//
//  Created by mac on 2020/8/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSTypeListCell.h"

@implementation RSTypeListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        UIView * showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        [self.contentView addSubview:showView];
        
        //显示界面的内容
        UIImageView * showImageView = [[UIImageView alloc]init];
        showImageView.contentMode = UIViewContentModeScaleAspectFill;
        showImageView.clipsToBounds = YES;
        showImageView.image = [UIImage imageNamed:@"已入库"];
        [showView addSubview:showImageView];
//        _showImageView = showImageView;
        //单号
        UILabel * showLabel = [[UILabel alloc]init];
        showLabel.text = @"单号：CGRK201901070001";
        showLabel.textAlignment = NSTextAlignmentLeft;
        showLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        UIFont * font = [UIFont fontWithName:@"PingFangSC" size:16];
        showLabel.font = font;
        [showView addSubview:showLabel];
//        _showLabel = showLabel;
        //时间
        UILabel * timeLabel = [[UILabel alloc]init];
        timeLabel.text = @"2019/01/12";
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        timeLabel.font = [UIFont systemFontOfSize:10];
        [showView addSubview:timeLabel];
//        _timeLabel = timeLabel;
        //物料名称
        UILabel * productLabel = [[UILabel alloc]init];
        productLabel.text = @"物料名称：白玉兰、黑芝麻、奥特曼…";
        productLabel.textAlignment = NSTextAlignmentLeft;
        productLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        productLabel.font = [UIFont systemFontOfSize:15];
        [showView addSubview:productLabel];
//        _productLabel = productLabel;
        //颗数
        UILabel * numberLabel = [[UILabel alloc]init];
        numberLabel.text = @"颗  数：2颗";
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        numberLabel.font = [UIFont systemFontOfSize:15];
        [showView addSubview:numberLabel];
//        _numberLabel = numberLabel;
        //立方米
        UILabel * areaLabel = [[UILabel alloc]init];
        areaLabel.text = @"立方米：3.234m³";
        areaLabel.textAlignment = NSTextAlignmentLeft;
        areaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        areaLabel.font = [UIFont systemFontOfSize:15];
        [showView addSubview:areaLabel];
//        _areaLabel = areaLabel;
        //状态
        UILabel * statusLabel = [[UILabel alloc]init];
        statusLabel.text = @"已入库";
        statusLabel.textAlignment = NSTextAlignmentRight;
        statusLabel.textColor = [UIColor colorWithHexColorStr:@"#26C589"];
        statusLabel.font = [UIFont systemFontOfSize:12];
        [showView addSubview:statusLabel];
//        _statusLabel = statusLabel;
        
        
        //异常类型
        UILabel * abnormalLabel = [[UILabel alloc]init];
        abnormalLabel.text = @"异常类型:断裂处理";
        abnormalLabel.hidden = YES;
        abnormalLabel.textAlignment = NSTextAlignmentLeft;
        abnormalLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        abnormalLabel.font = [UIFont systemFontOfSize:15];
        [showView addSubview:abnormalLabel];
//        _abnormalLabel = abnormalLabel;
        
        //异常类型的详情值
//        UILabel * abnormalDetailLabel = [[UILabel alloc]init];
//        abnormalDetailLabel.text = @"断裂处理";
//        abnormalDetailLabel.textAlignment = NSTextAlignmentLeft;
//        abnormalDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//        abnormalDetailLabel.font = [UIFont systemFontOfSize:15];
//        [showView addSubview:abnormalDetailLabel];
        
        
        
        showView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0);
        showView.layer.cornerRadius = 6;
        
        showImageView.sd_layout
        .leftSpaceToView(showView, 15)
        .topSpaceToView(showView, 16)
        .widthIs(32)
        .heightEqualToWidth();
        
        showLabel.sd_layout
        .topSpaceToView(showView, 12)
        .leftSpaceToView(showImageView, 9)
        .widthRatioToView(showView, 0.65)
        .heightIs(23);
        
        
        timeLabel.sd_layout
        .rightSpaceToView(showView, 14)
        .topSpaceToView(showView, 19)
        .heightIs(14)
        .widthRatioToView(showView, 0.3);
        
        
        productLabel.sd_layout
        .leftEqualToView(showLabel)
        .rightSpaceToView(showView, 12)
        .topSpaceToView(showLabel, 3)
        .heightIs(21);
        
        numberLabel.sd_layout
        .leftEqualToView(productLabel)
        .rightEqualToView(productLabel)
        .topSpaceToView(productLabel, 3)
        .heightIs(21);
        
        areaLabel.sd_layout
        .leftEqualToView(numberLabel)
        .rightEqualToView(numberLabel)
        .topSpaceToView(numberLabel, 3)
        .heightIs(21);
        
        statusLabel.sd_layout
        .rightSpaceToView(showView, 14)
        .widthRatioToView(showView, 0.3)
        .heightIs(14)
        .bottomSpaceToView(showView, 13);
        
        
        abnormalLabel.sd_layout
        .leftEqualToView(areaLabel)
        .rightEqualToView(areaLabel)
        .topSpaceToView(areaLabel, 3)
        .heightIs(21);
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
