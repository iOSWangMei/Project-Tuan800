//
//  DistanceViewController.h
//  Project-Tuan800
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistanceView : UIView

@property (nonatomic,strong)UIView *topView;
@property(nonatomic,strong)NSMutableArray *leftArray;
@property(nonatomic,strong)UIView *rightView;
@property(nonatomic,strong)UITableViewCell *cell;

-(instancetype)initWithFrame:(CGRect)frame;

@end
