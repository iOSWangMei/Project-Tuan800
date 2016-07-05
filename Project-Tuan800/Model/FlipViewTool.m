//
//  FlipViewTool.m
//  OrderDishTest
//
//  Created by chenYangWang on 16/4/19.
//  Copyright © 2016年 zhiyou. All rights reserved.
//

#import "FlipViewTool.h"

@implementation FlipViewTool

+ (void)changeViewContorller:(UIViewController *)viewController
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = viewController;
}
+ (void)flipView:(UIView *)view withDuration:(NSTimeInterval)time withStyle:(UIViewAnimationTransition)style
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:time];
    [UIView setAnimationTransition:style forView:view cache:YES];
    [UIView commitAnimations];
}



@end
