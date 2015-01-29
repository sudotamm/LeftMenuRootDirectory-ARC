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
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([viewController isKindOfClass:[BaseMenuViewController class]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kActiveNaviPanGestureNotification object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kInActiveNaviPanGestureNotification object:nil];
    }
    
    if(IsIos7)
    {
        if([viewController isKindOfClass:[BaseMenuViewController class]])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kShowBlackStatusBarNotification object:nil];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kShowLightStatusBarNotification object:nil];
        }
    }
}

@end
