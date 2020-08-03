//
//  SmsButtonHandle.m
//  RJTextField
//
//  Created by mac on 2020/7/10.
//  Copyright © 2020 RenJiee. All rights reserved.
//

#import "SmsButtonHandle.h"

@implementation SmsButtonHandle{
    NSTimeInterval timeInterval;
    UIButton * smsButton;
    NSString * authTitle;
    NSTimer * timer;
    BOOL isFired;
}

+ (instancetype)sharedSmsBHandle{
    static dispatch_once_t onceToken;
    static SmsButtonHandle * handle;
    dispatch_once(&onceToken, ^{
     handle = [[SmsButtonHandle alloc]init];
    });
    return handle;
}



- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title action:(SEL)action superVC:(UIViewController *)superVC{
    [[SmsButtonHandle sharedSmsBHandle] timeInterval];
    smsButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    smsButton.titleLabel.font = [UIFont systemFontOfSize:11];
    smsButton.frame = frame;
    [smsButton addTarget:superVC action:action forControlEvents:(UIControlEventTouchUpInside)];
    if ([[SmsButtonHandle sharedSmsBHandle] timeInterval] < 59) {
        [[SmsButtonHandle sharedSmsBHandle] startTimer];
    }else{
        [smsButton setTitle:title forState:(UIControlStateNormal)];
    }
    [[SmsButtonHandle sharedSmsBHandle] authTitle:title];
    [smsButton setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:(UIControlStateNormal)];
    return smsButton;
}


- (UIButton *)buttonWithTitle:(NSString *)title action:(SEL)action superVC:(UIViewController *)superVC{
    [[SmsButtonHandle sharedSmsBHandle] timeInterval];
    smsButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    smsButton.titleLabel.font = [UIFont systemFontOfSize:11];
//    smsButton.frame = frame;
    [smsButton addTarget:superVC action:action forControlEvents:(UIControlEventTouchUpInside)];
    if ([[SmsButtonHandle sharedSmsBHandle] timeInterval] < 59) {
        [[SmsButtonHandle sharedSmsBHandle] startTimer];
    }else{
        [smsButton setTitle:title forState:(UIControlStateNormal)];
    }
    [[SmsButtonHandle sharedSmsBHandle] authTitle:title];
    [smsButton setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:(UIControlStateNormal)];
    return smsButton;
}


- (NSString *)authTitle:(NSString *)title{
    if (!authTitle) {
        authTitle = title;
    }
    return authTitle;
}

- (NSTimeInterval)timeInterval{
    if (!timeInterval) {
        timeInterval = 59;
    }
    return timeInterval;
}

- (NSTimer *)timer{
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [timer setFireDate:[NSDate distantFuture]];
    }
    return timer;
}

#pragma mark - Timer Action
- (void)timerAction{
    NSLog(@"=============================");
    if (self.timeInterval >= 1) {
         NSLog(@"==============3232===============");
        NSLog(@"======-------%@",@(timeInterval--));
        [smsButton setTitle:[NSString stringWithFormat:@"%@",@(timeInterval--)] forState:UIControlStateNormal];
//        smsButton.backgroundColor = [UIColor lightGrayColor];
        smsButton.userInteractionEnabled = NO;
    }else{
        [self stopTimer];
        timeInterval = 59;
        authTitle = @"重新发送";
//        smsButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:94/255.0 blue:57/255.0 alpha:1.0];
        [smsButton setTitle:authTitle forState:UIControlStateNormal];
        smsButton.userInteractionEnabled = YES;
    }
}

#pragma mark - Private Method
- (void)startTimer{
    isFired = YES;
    [self.timer setFireDate:[NSDate date]];
}

- (void)stopTimer{
    if (timer) {
        [timer setFireDate:[NSDate distantFuture]];
        isFired = NO;
    }
}

- (void)endTimer{
    if (timer) {
        timeInterval = 59;
        isFired = NO;
        [timer invalidate];
        timer = nil;
    }
}





@end
