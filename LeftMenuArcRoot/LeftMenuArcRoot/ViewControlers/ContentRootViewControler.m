//
//  ContentRootViewControler.m
//  LeftMenuArcRoot
//
//  Created by ryan on 12/17/14.
//  Copyright (c) 2014 Ryan. All rights reserved.
//

#import "ContentRootViewControler.h"

@interface ContentRootViewControler ()

@end

@implementation ContentRootViewControler

@synthesize startImageView;

#pragma mark - UIViewController methods
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.startImageView.image = [UIImage assetLaunchImage];
}

@end
