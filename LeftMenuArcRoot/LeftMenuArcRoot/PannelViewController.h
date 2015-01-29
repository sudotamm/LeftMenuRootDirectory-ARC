//
//  PannelViewController.h
//  RootDirectory
//
//  Created by Ryan on 13-2-28.
//  Copyright (c) 2013年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuView.h"
#import "ContentNaviController.h"

typedef enum {
    kMenuNone = 0,
    kMenuLeft
}MenuType;

typedef enum {
    kStatusBarStyleHidden,
    kStatusBarStyleLight,
    kStatusBarStyleBlack
}StatusBarStyle;

@interface PannelViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *contentMaskView;
@property (nonatomic, weak) IBOutlet UIView *contentContainView;

@property (nonatomic, strong) LeftMenuView *leftMenuView;
@property (nonatomic, strong) ContentNaviController *contentNaviController;

@property (nonatomic, assign) MenuType menuType;
@property (nonatomic, assign) StatusBarStyle statusBarStyle;

@end
