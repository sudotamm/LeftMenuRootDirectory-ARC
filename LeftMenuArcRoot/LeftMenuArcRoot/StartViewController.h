//
//  StartViewController.h
//  LeftMenuArcRoot
//
//  Created by ryan on 12/11/14.
//  Copyright (c) 2014 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  基于UIViewController创建的子类，在启动和RootViewController之间加入的中间层，可以用于处理启动广告或者向导层
 *  默认实现功能：
 *  - 使用应用的启动图做占位图
 */

@interface StartViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *startImageView;

@end

