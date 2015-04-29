//
//  ContentNaviController.m
//  WDZZ
//
//  Created by Ryan on 13-8-19.
//  Copyright (c) 2013年 Ryan. All rights reserved.
//

#import "ContentNaviController.h"
#import "BaseMenuViewController.h"

@interface ContentNaviController ()

@end

@implementation ContentNaviController

#pragma mark - Notification methods
- (void)showModuleViewWithNotification:(NSNotification *)notification
{
    [self popToRootViewControllerAnimated:NO];
    NSString *moduleClassName = notification.object;
    UIViewController *topVC = (UIViewController *)[self.viewControllers firstObject];
    if([moduleClassName isEqualToString:NSStringFromClass([topVC class])])
        return;
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    id moduleViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:moduleClassName];
    if(moduleViewController)
    {
        [self pushViewController:moduleViewController animated:NO];
    }
    else
    {
        NSLog(@"MainStoryBoard中没有对应的模块实例.");
    }
}

#pragma mark- UINavigationController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showModuleViewWithNotification:) name:kShowModuleViewNotification object:nil];
    self.view.layer.shadowOffset = CGSizeZero;
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 5.f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.layer.bounds].CGPath;
    self.view.clipsToBounds = NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UINavigationControllerDelegate methods
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super navigationController:navigationController didShowViewController:viewController animated:animated];
    if([viewController isKindOfClass:[BaseMenuViewController class]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kActiveNaviPanGestureNotification object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kInActiveNaviPanGestureNotification object:nil];
    }
    
    if(IsIos7Later)
    {
        if([viewController isKindOfClass:[BaseMenuViewController class]])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kShowBlackStatusBarNotification object:nil];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kShowBlackStatusBarNotification object:nil];
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    /*在动画过渡过程中先移除加入到navi.view的手势，只移除加入的pan手势，保留ios7添加的UIScreenEdgePanGestureRecognizer
     在ios7中动画过渡期间就能接受到手势消息，导致的问题是：在pop的view还没有didShow之前调用pan手势，会能够触发pan手势
     ios7之前版本没有这个问题
     */
    for(UIGestureRecognizer *gesture in self.view.gestureRecognizers)
    {
        if([gesture isMemberOfClass:[UIPanGestureRecognizer class]])
            [self.view removeGestureRecognizer:gesture];
    }
}

@end
