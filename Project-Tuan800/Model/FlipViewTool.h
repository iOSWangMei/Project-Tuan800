//
//  FlipViewTool.h
//  OrderDishTest
//
//  Created by chenYangWang on 16/4/19.
//  Copyright © 2016年 zhiyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FlipViewTool : NSObject

+ (void)changeViewContorller:(UIViewController *)viewController;

+ (void)flipView:(UIView *)view withDuration:(NSTimeInterval)time withStyle:(UIViewAnimationTransition)style;





@end
