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


@interface AppDelegate ()
{
    UIViewController *tempViewControl;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
    self.window.rootViewController = loginVc;
    
    
//    RSRegisterViewController * registerVc = [[RSRegisterViewController alloc]init];
//    registerVc.type = @"phone";
//    self.window.rootViewController = registerVc;
    
    
//    RSStscmController * stscmVc = [[RSStscmController alloc]init];
//    RSMyNavigationViewController * myNav = [[RSMyNavigationViewController alloc]initWithRootViewController:stscmVc];
//    self.window.rootViewController = myNav;
    
    [self.window makeKeyAndVisible];
    //设置键盘
    [self settIQKeyMananger];
    //监测网络
    [self networkInspect];
    return YES;
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














//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Stscm"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
