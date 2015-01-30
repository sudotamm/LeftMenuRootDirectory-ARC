//
//  CommonNaviController.m
//  ACCT
//
//  Created by ryan on 12/17/14.
//  Copyright (c) 2014 Ryan. All rights reserved.
//

#import "CommonNaviController.h"

@implementation CommonNaviController

#pragma mark- UINavigationController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    if(IsIos7Later)
    {
        //iOS7中使用tintColor和barTintColor设置样式，iOS6中需要自定义
        self.navigationBar.barTintColor = kMainProjColor;
        self.navigationBar.tintColor = [UIColor whiteColor];
    }
/*
     ****************iOS6中自定需要重新自定义tabBar的样式*******************
    else
    {
        self.navigationBar.tintColor = kMainProjColor;
    }
*/
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
}

- (void)dealloc
{
    if (IsIos7Later)
    {
        self.interactivePopGestureRecognizer.delegate = nil;
        self.delegate = nil;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    [super pushViewController:viewController animated:animated];
}


#pragma mark - UINavigationControllerDelegate methods
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // Enable the gesture again once the new controller is shown
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        //if ([[navigationController.viewControllers firstObject] isEqual:viewController]) {
        if ([navigationController.viewControllers count] == 1)
        {
            // Disable the interactive pop gesture in the rootViewController of navigationController
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
        else
        {
            // Enable the interactive pop gesture
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
