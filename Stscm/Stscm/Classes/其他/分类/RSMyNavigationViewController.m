//
//  RSMyNavigationViewController.m
//  石来石往
//
//  Created by mac on 2017/11/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMyNavigationViewController.h"
#import "UIBarButtonItem+Item.h"

@interface RSMyNavigationViewController ()<UINavigationControllerDelegate>

@property (nonatomic,weak)id popDelegate;

@end

@implementation RSMyNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
   // self.navigationBar.barTintColor = [UIColor colorWithHexColorStr:@"#ffffff"];
}

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    NSInteger count = navigationController.viewControllers.count;
//    if (count > 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }else{
//        viewController.hidesBottomBarWhenPushed = NO;
//    }
//
//}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = (id)viewController;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 非根控制器
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置返回按钮,只有非根控制器
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"]  target:self action:@selector(back) title:nil];
    }
    // 真正在跳转
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
