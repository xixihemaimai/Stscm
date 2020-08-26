//
//  RSCustomLabel.m
//  Stscm
//
//  Created by mac on 2020/6/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSCustomLabel.h"

@implementation RSCustomLabel

+ (instancetype)creatCustomLabelAndText:(NSString *)text andTextColor:(UIColor *)textColor andFont:(UIFont *)font andTextAlignment:(NSTextAlignment)textAlignment andBackgroundColor:(UIColor *)backgroundColor{
    RSCustomLabel * label = [[RSCustomLabel alloc]init];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = textAlignment;
    label.backgroundColor = backgroundColor;
    return label;
}

@end
