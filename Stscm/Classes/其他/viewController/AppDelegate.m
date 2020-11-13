//
//  AppDelegate.m
//  Stscm
//
//  Created by mac on 2020/6/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "RSStscmController.h"

/**注册*/
#import "RSRegisterViewController.h"

/**登录*/
#import "RSLoginViewController.h"

/**主界面*/
#import "RSMainViewController.h"


@interface AppDelegate ()
{
    UIViewController *tempViewControl;
}

// 当前屏幕与设计尺寸 (iPhone6) 宽度比例
@property ( nonatomic , assign ) CGFloat  autoSizeScaleW;
// 当前屏幕与设计尺寸 (iPhone6) 高度比例
@property ( nonatomic , assign ) CGFloat  autoSizeScaleH;


@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [SVProgressHUD setMinimumDismissTimeInterval:0.3];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    UserInfo * userInfo = [UserInfoContext sharedUserInfoContext].userInfo = [Usertilities GetNSUserDefaults];
    if (userInfo.loginToken.length < 1) {
        [Usertilities clearLocalUserModel];
        RSRegisterViewController * registerVc = [[RSRegisterViewController alloc]init];
        RSMyNavigationViewController * myNav = [[RSMyNavigationViewController alloc]initWithRootViewController:registerVc];
        self.window.rootViewController = myNav;
//      [UserInfoContext clear];
        [Usertilities clearLocalUserModel];
    }else{
        NSLog(@"=========2222222222222222222===========%@",userInfo.userHeadImageUrl);
        //这边要进行网络请求来进行获取用户信息
        NSString * parameter = [NSString string];
        //NSString * content = @"e1fe219d0b2143d4ae9a41ea2c5c556";
        [RSNetworkTool netWorkToolWebServiceDataUrl:URL_USER_INFO_IOS andType:@"GET" withParameters:parameter andURLName:URL_USER_INFO_IOS andContentType:userInfo.loginToken withBlock:^(id  _Nonnull responseObject, BOOL success) {
            if (success) {
               NSLog(@"============================================%@",responseObject);
               [RSUserInfoTool initWithUserToolUserInfo:userInfo ResponseObject:responseObject];
               //重新获取用户信息成功
               RSMainViewController * mainVc = [[RSMainViewController alloc]init];
               self.window.rootViewController = mainVc;
            }else{
               //重新获取用户信息失败
               RSRegisterViewController * registerVc = [[RSRegisterViewController alloc]init];
               RSMyNavigationViewController * myNav = [[RSMyNavigationViewController alloc]initWithRootViewController:registerVc];
               self.window.rootViewController = myNav;
               //[UserInfoContext clear];
               [Usertilities clearLocalUserModel];
            }
        }];
    }
    [self.window makeKeyAndVisible];
    //设置键盘
    [self settIQKeyMananger];
    //监测网络
    [self networkInspect];
    
    //适配
    [self initAutoScaleSize];
    return YES;
}


- (void)initAutoScaleSize
{
    if (SCH==480)
    {
        //4s
        _autoSizeScaleW =SCW/375;
        _autoSizeScaleH =SCH/667;
    }
    else if(SCH==568)
    {
        //5
        _autoSizeScaleW =SCW/375;
        _autoSizeScaleH =SCH/667;
    }
    else if(SCH==667)
     {
//4.7
        //6 6s 7 8 se
        _autoSizeScaleW =SCW/375;
        _autoSizeScaleH =SCH/667;
    }
    else if(SCH==736)
    {
//5.5
        //6p 7p 8p
        _autoSizeScaleW =SCW/375;
        _autoSizeScaleH =SCH/736;
    }else if(SCH== 812){
//5.8
     //iphonex iPhone XS iphone11pro
        _autoSizeScaleW =SCW/375;
        _autoSizeScaleH =SCH/812;


    }else if(SCH== 896){
//6.1
     //iphonexr  iphone11  iphone xs max  iPhone 11 pro max
         _autoSizeScaleW =SCW/414;
        _autoSizeScaleH =SCH/896;

    }else if(SCH== 780){
       //iphone 12 mini
        _autoSizeScaleW =SCW/360;
        _autoSizeScaleH =SCH/780;
 
    }else if(SCH == 844){
       //iphone 12  iPhone 12 pro
         _autoSizeScaleW =SCW/390;
        _autoSizeScaleH =SCH/844;
 
    }else if(SCH == 926){
       //iPhone 12 pro max
        _autoSizeScaleW =SCW/428;
        _autoSizeScaleH =SCH/926;
    }
else
    {
        _autoSizeScaleW =1;
        _autoSizeScaleH =1;
    }
}
- (CGFloat)autoScaleW:(CGFloat)w{
    return w * self.autoSizeScaleW;
}
- (CGFloat)autoScaleH:(CGFloat)h{
    return h * self.autoSizeScaleH;
}



- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    if (_allowRotation == true) {   // 如果属性值为YES,仅允许屏幕向左旋转,否则仅允许竖屏
        return UIInterfaceOrientationMaskAll;  // 这里是屏幕要旋转的方向
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}

- (BOOL)shouldAutorotate
{
    if (_allowRotation == true) {
        return YES;
    }
    return NO;
}

- (void)settIQKeyMananger{
    IQKeyboardManager * keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}
//FIXME:这边是网络
-(void)networkInspect
{
    RSWeakself
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变时调用
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //NSLog(@"未知网络");
                [weakSelf showNetWorkBar];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //NSLog(@"没有网络");
                //此步意义不明
                //                if([[self topViewController]class] ==[ToolNetWorkSolveVC class])
                //                {
                //                    [self dismissNetWorkBar];
                //                    return;
                //                }
                // [self showNetWorkBar];
                [weakSelf showNetWorkBar];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //NSLog(@"手机自带网络");
                //   [weakSelf showPhoneNetworkBar];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //NSLog(@"WIFI");
                //[weakSelf showWIFINetworkBar];
                break;
        }
    }];
    //开始监控
    [manager startMonitoring];
}

- (void)showNetWorkBar{
    tempViewControl = [self topViewController];
    [self showNotNetworkView:[self topViewController]];
}

- (void)showWIFINetworkBar{
    tempViewControl = [self topViewController];
    [self showWifiNetwork:[self topViewController]];
}

- (void)showPhoneNetworkBar{
    tempViewControl = [self topViewController];
    [self showYouPhoneNetWork:[self topViewController]];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:self.window.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

#pragma mark -- 当没有网络的时候
- (void)showNotNetworkView:(UIViewController *)viewController{
    Nonetwork *Nonet=[[Nonetwork alloc] initWithFrame:[UIScreen mainScreen].bounds];
    Nonet.Prompt=@"无法连接服务器，请检查你的网络设置";
    Nonet.typeDisappear=0;
    Nonet.Warningicon.image=[UIImage imageNamed:@"internet"];
    [Nonet popupWarningview];
    Nonet.returnsAnEventBlock = ^{
        // NSLog(@"重新加载数据");
    };
    [Nonet bringSubviewToFront:viewController.view];
    [viewController.view addSubview:Nonet];
}

#pragma mark -- 有WIFT的时候
- (void)showWifiNetwork:(UIViewController *)viewController{
    Nonetwork *Nonet=[[Nonetwork alloc] initWithFrame:[UIScreen mainScreen].bounds];
    Nonet.Prompt=@"已连接WIFI";
    Nonet.typeDisappear=0;
    Nonet.Warningicon.image=[UIImage imageNamed:@"WIFI 我fi"];
    [Nonet popupWarningview];
    Nonet.returnsAnEventBlock = ^{
        //NSLog(@"重新加载数据");
    };
    [Nonet bringSubviewToFront:viewController.view];
    [viewController.view addSubview:Nonet];
}

#pragma mark -- 手机的网络
- (void)showYouPhoneNetWork:(UIViewController *)viewController{
    Nonetwork *Nonet=[[Nonetwork alloc] initWithFrame:[UIScreen mainScreen].bounds];
    Nonet.Prompt=@"已连接手机网络";
    Nonet.typeDisappear=0;
    Nonet.Warningicon.image=[UIImage imageNamed:@"4g"];
    [Nonet popupWarningview];
    Nonet.returnsAnEventBlock = ^{
        //NSLog(@"重新加载数据");
    };
    [Nonet bringSubviewToFront:viewController.view];
    [viewController.view addSubview:Nonet];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





@end
