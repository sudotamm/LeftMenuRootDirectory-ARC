//
//  AppDelegate.h
//  LeftMenuArcRoot
//
//  Created by ryan on 12/11/14.
//  Copyright (c) 2014 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartViewController.h"
#import "PannelViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) StartViewController *startViewController;
@property (nonatomic, strong) PannelViewController *pannelViewController;

@end

