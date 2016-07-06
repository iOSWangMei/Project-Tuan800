//
//  DistanceView.m
//  Project-Tuan800
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DistanceView.h"

@interface DistanceView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DistanceView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
#pragma mark - 创建顶部视图
        self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2-50)];
        self.topView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.topView];

        
#pragma mark - 创建tableView
        [self createTableView];
        
        
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


#pragma mark - 创建左侧视图上的tableView
-(void)createTableView
{
#pragma mark - 左侧的tableView视图
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2-50, self.frame.size.height/2-50)];
    [self.topView addSubview:leftView];
    
#pragma mark - 创建tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(leftView.frame), CGRectGetHeight(leftView.frame))];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    
    [leftView addSubview:tableView];
}


#pragma mark - 创建右侧视图
-(void)createRightView
{
#pragma mark - 右侧的视图
    self.rightView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-50, 0, self.frame.size.width/2+50, self.frame.size.height/2-50)];
    
    self.rightView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.topView addSubview:self.rightView];
}

    
#pragma mark - UITableViewDataSource
#pragma mark - 每个区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftArray.count ;
}
#pragma mark - 每一行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentififer = @"cell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:cellIdentififer];
    
    if (!self.cell) {
        self.cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentififer];
    }
    
    self.cell.textLabel.text = [self.leftArray objectAtIndex:indexPath.row];
    self.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return self.cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
//    indexPath = [tableView indexPathForSelectedRow];
    
    [self createRightView];
    self.cell.textLabel.textColor = [UIColor orangeColor];
    self.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}


@end
