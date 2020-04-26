
//
//  BaseNavigationController.m
//  konachan
//
//  Created by Chian on 2019/2/13.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>
@property(strong,nonatomic) UIPanGestureRecognizer *fullScreenPopPanGesture;
@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addFullScreenPopPanGesture];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)addFullScreenPopPanGesture{
    self.fullScreenPopPanGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    self.fullScreenPopPanGesture.delegate = self;
    [self.view addGestureRecognizer:self.fullScreenPopPanGesture];
    [self.interactivePopGestureRecognizer requireGestureRecognizerToFail:self.fullScreenPopPanGesture];
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count>1) {
        UIBarButtonItem * item1 =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Back Arrow"] style:(UIBarButtonItemStyleDone) target:self action:@selector(back)];
        UIBarButtonItem * item2 =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"close"] style:(UIBarButtonItemStyleDone) target:self action:@selector(popToRootViewControllerAnimated:)];
        viewController.navigationItem.leftBarButtonItems = @[item1,item2];
    }
    else if (self.childViewControllers.count>0){
        UIBarButtonItem * item1 =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Back Arrow"] style:(UIBarButtonItemStyleDone) target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItems = @[item1];
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

#pragma mark -- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isEqual:self.fullScreenPopPanGesture]) {
        //获取手指移动后的相对偏移量
        CGPoint translationPoint = [self.fullScreenPopPanGesture translationInView:self.view];
        //向右滑动 && 不是跟视图控制器
        if (translationPoint.x > 0 && self.childViewControllers.count > 1) {
            return YES;
        }
        return NO;
    }
    return YES;
}


@end
