//
//  FilterViewController.m
//  Project-Tuan800
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 mac. All rights reserved.
//
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

#import "FilterViewController.h"

@interface FilterViewController ()
{
    UIView *_view;
}
@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self createHeadView];
    
    [self createContentView];
    
    [self createSeparater];
    
    [self createTextField];
    
    [self createButton];
    
    [self createBottomView];
}
//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x+100, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}

#pragma mark - 创建textField
-(void)createTextField
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"最低价",@"最高价", nil];
    
    float width = 150;
    float height = 50;
    for (int i = 0;  i < 2; i ++) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(20+(width+height+10)*i, 370, width, height)];
//        textField.backgroundColor = [UIColor blueColor];
        
        textField.placeholder = [array objectAtIndex:i];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textField.frame), 380, 30, 30)];
//        label.backgroundColor = [UIColor redColor];
        
        label.text = @"元";
        label.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:label];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textField.frame)+30, 380, 30, 30)];
//        lab.backgroundColor = [UIColor yellowColor];
        
        lab.text = @"~";
        lab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lab];
        
        [self.view addSubview:textField];
    }
}


#pragma mark - 创建button
-(void)createButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 450, SCREEN_WIDTH-40, 50);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}
-(void)buttonClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 横向分割线
-(void)createSeparater
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 350, SCREEN_WIDTH-40, 1)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:view];
}


#pragma mark - 创建content视图
-(void)createContentView
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"只看快捷购买",@"只看免预约",@"支持优惠券",@"价格区间",nil];
    
    float rowSpace = 20;
    float height = 50;
    for (int i = 0; i < 4; i ++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 70+rowSpace+(rowSpace+height)*i, 200, height)];
//        label.backgroundColor = [UIColor redColor];
        
        label.text = [array objectAtIndex:i];
        label.textAlignment = NSTextAlignmentLeft;
//        label.font = [UIFont systemFontOfSize:20];
        
        if (i < 3) {
            
            UISwitch *swit = [[UISwitch alloc]init];
            swit.center = CGPointMake(SCREEN_WIDTH-51/2 -20, 70+rowSpace+height/2+(rowSpace+height)*i);
            [self.view addSubview:swit];
        }
        
        [self.view addSubview:label];
    }
    
}


#pragma mark - 创建头部视图
-(void)createHeadView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
#pragma mark - 筛选label
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4, 50)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v6_category_filterbar_icon4"]];
    imageView.center = CGPointMake(20, 25);
    [label addSubview:imageView];
    
    label.text = @"         筛选";
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    
    [self.view addSubview:view];
}


#pragma mark - 创建尾部视图
-(void)createBottomView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:view];
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
