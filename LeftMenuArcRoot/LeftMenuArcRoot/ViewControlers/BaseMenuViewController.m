//
//  BaseMenuViewController.m
//  NOAHWM
//
//  Created by Ryan on 13-6-13.
//  Copyright (c) 2013年 Ryan. All rights reserved.
//

#import "BaseMenuViewController.h"

@interface BaseMenuViewController ()

@end

@implementation BaseMenuViewController

#pragma mark - BaseViewController methods
- (void)leftItemTapped
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kShowLeftMenuNotification object:nil];
}

- (void)rightItemTapped
{

}

#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setLeftNaviItemWithTitle:@"左菜单" imageName:nil];
}
@end
