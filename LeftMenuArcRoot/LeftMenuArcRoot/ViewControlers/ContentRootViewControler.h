//
//  ContentRootViewControler.h
//  LeftMenuArcRoot
//
//  Created by ryan on 12/17/14.
//  Copyright (c) 2014 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMenuViewController.h"

/**
 *  基于BaseMenuViewController创建的子类，在展示左菜单内容之前加入的中间层
 *  默认实现功能：
 *  - 使用应用的启动图做占位图
 */

@interface ContentRootViewControler : BaseMenuViewController

@property (nonatomic, weak) IBOutlet UIImageView *startImageView;

@end
