//
//  UIColor+HexColor.h
//  04-颜色常识
//
//  Created by mac on 16/7/21.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)
/**
 *  将美工给的十六进制颜色字符串转换成颜色
 *  可以解析的颜色字符串：#666666 0x666666 666666
 *
 *  @param colorStr 十六进制颜色字符串
 *
 *  @return UIColor 默认透明度为1.0de
 */
+ (UIColor *)colorWithHexColorStr:(NSString *)colorStr;

+ (UIColor *)colorWithHexColorStr:(NSString *)colorStr alpha:(CGFloat)alpha;
/**红色*/
+ (UIColor *)colorRedShow;
/**黄色*/
+ (UIColor *)colorYellowShow;
/**白色*/
+ (UIColor *)colorWhiteShow;

/**暗黑模式和白天模式要改变的颜色*/
+ (UIColor *)colorWithDyColorChangObject:(UIView *)object andHexLightColorStr:(NSString *)lightcolorStr andHexDarkColorStr:(NSString *)darkColorStr;

/**文字的暗黑和白天模式的颜色*/
+ (UIColor *)colorLabelWithDyColorChangObject;
/**按键正常模式的暗黑和白天模式的颜色*/
+ (UIColor *)colorButtonNormalWithDyColorChangObject;
/**按键选中模式的暗黑和白天模式的颜色*/
+ (UIColor *)colorButtonSelectWithDyColorChangObject;
/**按键正常模式的暗黑和白天模式的颜色*/
+ (UIColor *)colorButtonBackgroundColorWithDyColorChangObject;
@end
