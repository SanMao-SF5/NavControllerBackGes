//
//  SFWNavController.m
//  导航控制器左滑返回
//
//  Created by 沈方武 on 15/9/14.
//  Copyright (c) 2015年 沈方武. All rights reserved.
//

#import "SFWNavController.h"

@interface SFWNavController () <UIGestureRecognizerDelegate>

@end

@implementation SFWNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航控制器的全屏左滑返回
    [self backGesture];
    
}

#pragma mark - 设置导航控制器的全屏左滑返回
- (void)backGesture{

    // 获取系统导航控制器的手势
    UIScreenEdgePanGestureRecognizer *gesture = (UIScreenEdgePanGestureRecognizer *)self.interactivePopGestureRecognizer;
 
    // 利用KVC获取手势对象的成员
    // "(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fcb69551e20>)"
    NSArray *targets = [gesture valueForKeyPath:@"_targets"];
    // 获取的数组中只有一个元素，取出这个元素
    id gestureRecognizer = targets[0];
    // 利用KVC取出执行手势的对象
    id target =[gestureRecognizer valueForKeyPath:@"_target"];
    
    // 禁止系统的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    // 创建新的滑动手势添加到View上
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];

}

// 如果返回no，表示不触发这个手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 只有非根控制器才能拥有滑动返回功能
    return self.childViewControllers.count != 1;
 
}

@end
