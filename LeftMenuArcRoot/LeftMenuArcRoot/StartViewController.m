//
//  StartViewController.m
//  LeftMenuArcRoot
//
//  Created by ryan on 12/11/14.
//  Copyright (c) 2014 Ryan. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

@synthesize startImageView;

#pragma mark - UIViewController methods

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    usleep(3500000);
    [[NSNotificationCenter defaultCenter] postNotificationName:kShowPannelViewNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.startImageView.image = [UIImage assetLaunchImage];
}

#pragma mark - StatusBar methods
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
