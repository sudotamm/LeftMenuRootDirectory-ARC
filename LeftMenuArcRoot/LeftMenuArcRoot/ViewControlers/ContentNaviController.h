//
//  ContentNaviController.h
//  WDZZ
//
//  Created by Ryan on 13-8-19.
//  Copyright (c) 2013年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonNaviController.h"

/**
 *  基于CommonNaviController创建的子类，项目左菜单页面切换的容器
 *  默认实现功能：
 *  - 监听左菜单各模块的切换
 *  - 加入左菜单滑开是的阴影处理
 *  - 加入页面切换时Pannel页面的手势和状态栏颜色变动处理
 */

@interface ContentNaviController : CommonNaviController

@end
