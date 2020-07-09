//
//  RSCustomLabel.h
//  Stscm
//
//  Created by mac on 2020/6/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSCustomLabel : UILabel


+ (instancetype)creatCustomLabelAndText:(NSString *)text andTextColor:(UIColor *)textColor andFont:(UIFont *)font andTextAlignment:(NSTextAlignment)textAlignment andBackgroundColor:(UIColor *)backgroundColor;

@end

NS_ASSUME_NONNULL_END
