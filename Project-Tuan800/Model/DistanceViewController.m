//
//  DistanceViewController.m
//  Project-Tuan800
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 mac. All rights reserved.
//
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

#import "DistanceViewController.h"

@interface DistanceViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *leftArray;
@end

@implementation DistanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor clearColor];
    
    [self createTableView];
    [self createRightView];
    [self createBottomView];
}


#pragma mark - 创建底部视图
-(void)createBottomView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2+71-50, SCREEN_WIDTH, 50)];
//    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    imageView.image = [UIImage imageNamed:@"v6_category_filter_bottom"];
    [view addSubview:imageView];
    
    [self.view addSubview:view];
}


#pragma mark - 创建左侧视图上的tableView
-(void)createTableView
{
#pragma mark - 左侧的tableView视图
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 71, SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2)];
    leftView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:leftView];
    
    self.leftArray = [[NSMutableArray alloc]initWithObjects:@"附近",@"全郑州",@"金水区",@"二七区",@"中原区",@"近郊",@"管城区",@"上街区",@"惠济区",@"郑东新区", nil];
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
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 71, SCREEN_WIDTH/2+50, SCREEN_HEIGHT/2)];
//    rightView.backgroundColor = [UIColor yellowColor];
    
    rightView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:rightView];

    NSMutableArray *rightArray = [[NSMutableArray alloc]initWithObjects:@"0.5km",@"1km",@"2km",@"3km",@"5km",@"10km", nil];
    
    float rightRowSpace = 10;
    float rightButtonWidth = 100;
    float rightButtonHeight = 30;
    
    for (int i = 0; i < 5; i ++) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.center = CGPointMake(SCREEN_WIDTH/2+100, rightRowSpace+(rightButtonHeight/2)+(rightRowSpace+rightButtonHeight)*i);
        rightButton.bounds = CGRectMake(0, 0, rightButtonWidth, rightButtonHeight);
        
        [rightButton setTitle:[rightArray objectAtIndex:i] forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [rightButton setBackgroundImage:[UIImage imageNamed:@"v6_category_filterbar_selected_cell2"] forState:UIControlStateSelected];
        [rightButton setTitle:[rightArray objectAtIndex:i] forState:UIControlStateSelected];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [rightButton addTarget:self action:@selector(distanceViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [rightView addSubview:rightButton];
        
        [self.view addSubview:rightView];
    }
}
#pragma mark - 点击button,对tableView进行排序
-(void)distanceViewButtonAction:(UIButton *)sender
{
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentififer];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentififer];
    }
    
    cell.textLabel.text = [self.leftArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    indexPath = [tableView indexPathForSelectedRow];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
