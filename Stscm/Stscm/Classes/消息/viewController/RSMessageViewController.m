//
//  RSMessageViewController.m
//  Stscm
//
//  Created by mac on 2020/7/16.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSMessageViewController.h"

@interface RSMessageViewController ()

@end

@implementation RSMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"==============================");
    
    self.emptyView.hidden = YES;
    
    self.customBlock = ^(NSInteger pageNum) {
        NSLog(@"+++++++++++++++++++++++++++++++%ld",pageNum);
    };
    
}

@end
