//
//  SortView.m
//  Project-Tuan800
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 mac. All rights reserved.
//
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

#import "SortView.h"

@interface SortView ()

@end

@implementation SortView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createTopView];
        
        [self createBottomView];
    }
    return self;
}


#pragma mark - 创建view
-(void)createTopView
{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 71, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
//    view.backgroundColor = [UIColor yellowColor];
//    [view addSubview:view];
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"默认排序",@"离我最近",@"销量最高",@"价格最低",@"价格最高", nil];
    
    float rowSpace = 20;
    float buttonWidth = 100;
    float buttonHeight = 30;
    
    for (int i = 0; i < 5; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.center = CGPointMake(SCREEN_WIDTH/2, rowSpace+(buttonHeight/2)+(rowSpace+buttonHeight)*i);
        button.bounds = CGRectMake(0, 0, buttonWidth, buttonHeight);
        
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button setBackgroundImage:[UIImage imageNamed:@"v6_category_filterbar_selected_cell2"] forState:UIControlStateSelected];
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(orderViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}
#pragma mark - 点击button,对tableView进行排序
-(void)orderViewButtonAction:(UIButton *)sender
{
    
}


#pragma mark - 创建底部视图
-(void)createBottomView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2+71-50, SCREEN_WIDTH, 50)];
    //    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    imageView.image = [UIImage imageNamed:@"v6_category_filter_bottom"];
    [view addSubview:imageView];
    
    [view addSubview:view];
}

//    //[view addSubview:view];
//    [view bringSubviewToFront:view];
//
//    //[view removeFromSuperview];
//    [view bringSubviewToFront:view];


@end
