//
//  SmsButtonHandle.h
//  RJTextField
//
//  Created by mac on 2020/7/10.
//  Copyright © 2020 RenJiee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SmsButtonHandle : NSObject

+ (instancetype)sharedSmsBHandle;

- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title action:(SEL)action superVC:(UIViewController *)superVC;

- (UIButton *)buttonWithTitle:(NSString *)title action:(SEL)action superVC:(UIViewController *)superVC;

- (void)startTimer;



@end

NS_ASSUME_NONNULL_END
