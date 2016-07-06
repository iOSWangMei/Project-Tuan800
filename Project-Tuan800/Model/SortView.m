//
//  SortView.m
//  Project-Tuan800
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SortView.h"

@interface SortView ()

@end

@implementation SortView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
 #pragma mark - 创建顶部视图
        self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2-50)];
        self.topView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.topView];
        
        
#pragma mark - 创建底部视图
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2-50, self.frame.size.width, 50)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        imageView.image = [UIImage imageNamed:@"v6_category_filter_bottom"];
        [bottomView addSubview:imageView];
        
        [self addSubview:bottomView];
        
        
#pragma mark - 创建下部视图
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2)];
        
        footView.backgroundColor = [UIColor blackColor];
        footView.alpha = 0.1;
        
        [self addSubview:footView];
        
        
        /*
#pragma mark - 毛玻璃效果
        //1,效果对象
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        
        //2,创建一个用于显示效果的view
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
        
        effectView.alpha = 0.3;
        effectView.frame = CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2);
        
        [self addSubview:effectView];
        */
    }
    
    return self;
}



@end
