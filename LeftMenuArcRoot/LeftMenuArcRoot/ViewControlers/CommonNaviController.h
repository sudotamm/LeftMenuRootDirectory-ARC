//
//  CommonNaviController.h
//  ACCT
//
//  Created by ryan on 12/17/14.
//  Copyright (c) 2014 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  基于UINavigationController创建的子类，项目中得NavigationController应该都基于该类使用
 *  默认实现功能：
 *  - 基于项目MainColor处理NavigationBar
 *  - 加入自定义leftBarItem之后的pan手势不可用处理
 */

@interface CommonNaviController : UINavigationController<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end
