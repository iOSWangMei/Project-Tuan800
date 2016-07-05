//
//  SearchViewController.m
//  Project-Tuan800
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 mac. All rights reserved.
//
#define TAG_ADD4 400
#define TAG_ADD5 500

#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height


#import "SearchViewController.h"
#import "ZYSearch.h"


@interface SearchViewController ()
{
    UIView *_historyView;
    UIView *_hotView;
    UIView *_lineView;
}
//@property (nonatomic,strong)UIView *_historyView;
//@property (nonatomic,strong)UIView *_hotView;
//@property (nonatomic,strong)UIView *_lineView;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor magentaColor];
    
    [self createSearch];
    [self createSeparater];
    [self createButton];
    [self createLine];
    [self createUnderLine];
}


#pragma mark - 添加下划线
-(void)createUnderLine
{
    _lineView = [[UIView alloc]init];
    _lineView.bounds = CGRectMake(0, 0, SCREEN_WIDTH/2, 5);
    _lineView.center = CGPointMake(SCREEN_WIDTH/4, 115);
    _lineView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_lineView];
}


#pragma mark - 创建搜索框
-(void)createSearch
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    ZYSearch *search = [[ZYSearch alloc]initWithFrame:CGRectMake(10, 8, SCREEN_WIDTH-20, 35)];
    
    [view addSubview:search];
    [self.view addSubview:view];
}


#pragma mark - 横向分割线
-(void)createSeparater
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
}


#pragma mark - 创建按钮
-(void)createButton
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
#pragma mark - 搜索历史
    UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    historyBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 50);
    [historyBtn setTitle:@"搜索历史" forState:UIControlStateNormal];
    [historyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [historyBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [historyBtn addTarget:self action:@selector(historyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:historyBtn];
    
#pragma mark - 热门搜索
    UIButton *hotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hotBtn.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 50);
    [hotBtn setTitle:@"热门搜索" forState:UIControlStateNormal];
    
    [hotBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hotBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [hotBtn addTarget:self action:@selector(hotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:hotBtn];
    
    [self.view addSubview:view];
}


#pragma mark - 搜索历史按钮
-(void)historyBtnAction:(UIButton *)sender
{
    _lineView.center = CGPointMake(sender.center.x, 115);
    if (!_historyView) {
        _historyView = [[UIView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, SCREEN_HEIGHT-120)];
        _historyView.backgroundColor = [UIColor whiteColor];
        
        //    NSMutableArray *titleArray =
        
        float btnWidth = SCREEN_WIDTH;
        float btnHeight = 50;
        
        for (int i = 0; i ; i ++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0,btnHeight*i, btnWidth, btnHeight);
            //        [button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            button.backgroundColor = [UIColor whiteColor];
            
            button.tag = i+1+TAG_ADD5;
            [button addTarget:self action:@selector(searchHistoryAction:) forControlEvents:UIControlEventTouchUpInside];
            [_historyView addSubview:button];
            
        }
        [self.view addSubview:_historyView];
    }
    [self.view bringSubviewToFront:_historyView];
}
#pragma mark - 搜索历史按钮点击事件
-(void)searchHistoryAction:(UIButton *)sender
{
   [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   sender.backgroundColor = [UIColor grayColor];
}


#pragma mark - 热门搜索按钮
-(void)hotBtnAction:(UIButton *)sender
{
    _lineView.center = CGPointMake(sender.center.x, 115);
    if (!_hotView) {
        _hotView = [[UIView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, SCREEN_HEIGHT-120)];
        _hotView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        NSMutableArray *titleArray = [[NSMutableArray alloc]initWithObjects:@"好伦哥",@"眼镜",@"美发",@"生日蛋糕",@"九月天",@"蛋糕",@"驿家365",@"鲜花",@"ktv",@"万达",@"儿童摄影",@"德庄", nil];
        
        float btnWidth = 90;
        float btnHeight = 40;
        float rowSpace = 20;
        float colSpace = (SCREEN_WIDTH - 3*btnWidth)/4;
        
        for (int i = 0; i < 12; i ++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(colSpace+(btnWidth+colSpace)*(i%3),rowSpace+(btnHeight+rowSpace)*(i/3), btnWidth, btnHeight);
            [button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            button.backgroundColor = [UIColor whiteColor];
            
            button.tag = i+1+TAG_ADD4;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_hotView addSubview:button];
            
        }
        [self.view addSubview:_hotView];
    }
    [self.view bringSubviewToFront:_hotView];
}
#pragma mark - 热门搜索按钮点击事件
-(void)buttonAction:(UIButton *)sender
{
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor grayColor];
}


#pragma mark - 纵向分割线
-(void)createLine
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 70, 1, 49)];
    view.backgroundColor = [UIColor lightGrayColor];
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
