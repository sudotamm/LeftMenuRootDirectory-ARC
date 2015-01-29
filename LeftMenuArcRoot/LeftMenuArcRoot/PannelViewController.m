//
//  PannelViewController.m
//  RootDirectory
//
//  Created by Ryan on 13-2-28.
//  Copyright (c) 2013年 Ryan. All rights reserved.
//

#import "PannelViewController.h"

#define kLeftMenuWidth 160.f

@interface PannelViewController ()

@property (nonatomic, strong) UIPanGestureRecognizer *naviPanGesture;

@end

@implementation PannelViewController

@synthesize contentContainView;
@synthesize contentMaskView;
@synthesize leftMenuView,contentNaviController;
@synthesize naviPanGesture;
@synthesize menuType,statusBarStyle;

- (LeftMenuView *)leftMenuView
{
    if(nil == leftMenuView)
    {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"LeftMenuView" owner:self options:nil];
        leftMenuView = [nibs lastObject];
    }
    return leftMenuView;
}

- (ContentNaviController *)contentNaviController
{
    if(nil == contentNaviController)
    {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        contentNaviController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ContentNaviController"];
    }
    return contentNaviController;
}

- (UIPanGestureRecognizer *)naviPanGesture
{
    if(nil == naviPanGesture)
    {
        naviPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(naviViewPanWithGesture:)];
    }
    return naviPanGesture;
}

#pragma mark - Notification methods
- (void)showLeftMenuWithNotification:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3f animations:^(void){
        self.contentContainView.frame = CGRectMake(self.leftMenuView.frame.size.width, self.contentContainView.frame.origin.y, self.contentContainView.frame.size.width, self.contentContainView.frame.size.height);
    } completion:^(BOOL finished){
        self.contentMaskView.hidden = NO;
        self.menuType = kMenuLeft;
    }];
}

- (void)hideMenuViewWithNotification:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3f animations:^(void){
        self.contentContainView.frame = CGRectMake(0, self.contentContainView.frame.origin.y, self.contentContainView.frame.size.width, self.contentContainView.frame.size.height);
    } completion:^(BOOL finished){
        self.contentMaskView.hidden = YES;
        self.menuType = kMenuNone;
    }];
}

- (void)activeNaviViewPanGestureWithNotification:(NSNotification *)notification
{
    if(![self.contentNaviController.view.gestureRecognizers containsObject:self.naviPanGesture])
        [self.contentNaviController.view addGestureRecognizer:self.naviPanGesture];
}

- (void)inActiveNaviViewPanGestureWithNotification:(NSNotification *)notification
{
    if([self.contentNaviController.view.gestureRecognizers containsObject:self.naviPanGesture])
        [self.contentNaviController.view removeGestureRecognizer:self.naviPanGesture];
}

#pragma mark - Gesture methods
- (void)naviViewPanWithGesture:(UIPanGestureRecognizer *)gesture
{
    CGRect rectForNaviView = self.contentContainView.frame;
    
    CGPoint translationPoint = [gesture translationInView:self.view];
    CGFloat moveX = translationPoint.x;
    CGFloat naviX = rectForNaviView.origin.x;
    
    CGPoint currentVelocityPoint = [gesture velocityInView:self.view];
    CGFloat currentVelocityX     = currentVelocityPoint.x;
    
    if(gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled)
    {
        //显示左菜单
        if(currentVelocityX > 0)
            [self showLeftMenuWithNotification:nil];
        else
            [self hideMenuViewWithNotification:nil];
    }
    else
    {
        //手势移动过程中的contentview 管理
        if(self.menuType == kMenuNone)
        {
            naviX = 0+moveX;
        }
        else if(self.menuType == kMenuLeft)
        {
            naviX = self.leftMenuView.frame.size.width+moveX;
        }
        if(naviX > self.leftMenuView.frame.size.width)
            naviX = self.leftMenuView.frame.size.width;
        if(naviX < 0)
            naviX = 0;
        rectForNaviView.origin.x = naviX;
        self.contentContainView.frame = rectForNaviView;
    }
}

- (void)maskViewTapWithGesture:(UITapGestureRecognizer *)gesture
{
    [self hideMenuViewWithNotification:nil];
}

- (void)showLightStatusBarWithNotification:(NSNotification *)notification
{
    self.statusBarStyle = kStatusBarStyleLight;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)showBlackStatusBarWithNotification:(NSNotification *)notification
{
    self.statusBarStyle = kStatusBarStyleBlack;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLeftMenuWithNotification:) name:kShowLeftMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideMenuViewWithNotification:) name:kHideMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(activeNaviViewPanGestureWithNotification:) name:kActiveNaviPanGestureNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inActiveNaviViewPanGestureWithNotification:) name:kInActiveNaviPanGestureNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLightStatusBarWithNotification:) name:kShowLightStatusBarNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBlackStatusBarWithNotification:) name:kShowBlackStatusBarNotification object:nil];
    //添加内容navi contain view
    [self.contentContainView addSubview:self.contentNaviController.view];
    self.contentNaviController.view.frame = self.contentContainView.bounds;
    self.contentNaviController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    //添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTapWithGesture:)];
    [self.contentMaskView addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(naviViewPanWithGesture:)];
    [self.contentMaskView addGestureRecognizer:panGesture];
    //添加左菜单
    [self.view addSubview:self.leftMenuView];
    [self.leftMenuView setTranslatesAutoresizingMaskIntoConstraints:NO];
    UIView *v1 = self.view;
    UIView *v2 = self.leftMenuView;
    NSDictionary *dictView = NSDictionaryOfVariableBindings(v1,v2);
    NSDictionary *dictMetrics = @{@"leftMenuWidth":@kLeftMenuWidth};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[v2(leftMenuWidth)]-(>=0)-|" options:0 metrics:dictMetrics views:dictView]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[v2(v1)]|" options:0 metrics:nil views:dictView]];
    
    [self.view bringSubviewToFront:self.contentContainView];
    [self.contentContainView bringSubviewToFront:self.contentMaskView];
    
    //默认菜单选择为kMenuNone
    self.menuType = kMenuNone;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - StatusBar methods
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if(self.statusBarStyle == kStatusBarStyleLight)
    {
        return UIStatusBarStyleLightContent;
    }
    else if(self.statusBarStyle == kStatusBarStyleBlack)
    {
        return UIStatusBarStyleDefault;
    }
    else
        return UIStatusBarStyleLightContent;
}

@end
