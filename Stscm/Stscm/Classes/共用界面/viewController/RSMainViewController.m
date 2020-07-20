//
//  RSMainViewController.m
//  Stscm
//
//  Created by mac on 2020/7/16.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSMainViewController.h"

/**我的*/
#import "RSMineViewController.h"
/**消息*/
#import "RSMessageViewController.h"
/**工资台*/
#import "RSStscmController.h"


@interface RSMainViewController ()

@end

@implementation RSMainViewController

+ (void)load{
    UITabBarItem *item = nil;
    if ([UIDevice currentDevice].systemVersion.floatValue < 9.0) {
        item = [UITabBarItem appearanceWhenContainedIn:[self class], nil];
    }else{
        if (@available(iOS 9.0, *)) {
            item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
        } else {
            item = [UITabBarItem appearanceWhenContainedIn:[self class], nil];
        }// iOS9.0
    }
    //富文本：带属性的字符串
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    //设置字体颜色
    //[UIColor colorWithRed:41/255.0 green:51/255.0 blue:65/255.0 alpha:1];
    attrDict[NSForegroundColorAttributeName] = [UIColor colorWithHexColorStr:@"#FC9C0A"];
    //设置标题的富文本
    [item setTitleTextAttributes:attrDict forState:UIControlStateSelected];
    // 设置富文本属性
    NSMutableDictionary *attrNormal = [NSMutableDictionary dictionary];
    // 设置文字大小的属性
    attrNormal[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    // 设置按钮文字的大小属性
    [item setTitleTextAttributes:attrNormal forState:UIControlStateNormal];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addSubCtrls];
    
    
}


- (void)addSubCtrls {
   
        //消息
        RSMessageViewController * messageVc = [[RSMessageViewController alloc]init];
        messageVc.tabBarItem.tag = 0;
        messageVc.tabBarItem.title = @"消息";
        messageVc.tabBarItem.image =  [UIImage imageNamed:@"图标"];
        UIImage * image0 = [UIImage imageNamed:@"图标备份"];
        UIImage * newImage0 = [image0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        messageVc.tabBarItem.selectedImage = newImage0;
        
        RSMyNavigationViewController * myNav0 = [[RSMyNavigationViewController alloc]initWithRootViewController:messageVc];
           
        //工作台
        RSStscmController * stscmVc = [[RSStscmController alloc]init];
        stscmVc.tabBarItem.tag = 1;
        stscmVc.tabBarItem.title = @"工作台";
        stscmVc.tabBarItem.image =  [UIImage imageNamed:@"图标备份 2"];
        UIImage * image1 = [UIImage imageNamed:@"图标备份 3"];
        UIImage * newImage1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        stscmVc.tabBarItem.selectedImage = newImage1;

        
        RSMyNavigationViewController * myNav1 = [[RSMyNavigationViewController alloc]initWithRootViewController:stscmVc];
        
      
        //我的
        RSMineViewController * mineVc = [[RSMineViewController alloc]init];
        mineVc.tabBarItem.tag = 2;
        mineVc.tabBarItem.title = @"我的";
        mineVc.tabBarItem.image =  [UIImage imageNamed:@"图标备份 4"];
        UIImage * image2 = [UIImage imageNamed:@"图标备份 5"];
        UIImage * newImage2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        mineVc.tabBarItem.selectedImage = newImage2;
        
        RSMyNavigationViewController * myNav2 = [[RSMyNavigationViewController alloc]initWithRootViewController:mineVc];
    
    
    
       self.viewControllers = @[myNav0,myNav1,myNav2];
}



@end
