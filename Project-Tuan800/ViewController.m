//
//  ViewController.m
//  Project-Tuan800
//
//  Created by mac on 16/6/24.
//  Copyright © 2016年 mac. All rights reserved.
//
#define TAG_ADD1 100
#define TAG_ADD2 200
#define TAG_ADD3 300

#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

#import "ViewController.h"
#import "DataModels.h"
#import "UIImageView+WebCache.h"
#import "CityChooseViewController.h"
#import "SearchViewController.h"
#import <UIKit+AFNetworking.h>
#import "ImageViewController.h"
#import "NearViewController.h"
#import "CategoryViewController.h"
#import "XDataModels.h"

@interface ViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    
    //速度
    int _speed;
    
    //定时器
    NSTimer *_timer;
    
    UIPageControl *_pageControl;
    
    UIButton *_cityChooseBtn;
}
@property (nonatomic,strong)NSMutableArray *imgArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//        [self reqeustData];
    self.imgArray = [[NSMutableArray alloc]init];
    
    
        [self createTopView];
//    [self createHeadView];
    
    
    ///*
//    [self createScrollView];
//    [self addPage];
    [self createMiddleHeadView];
    [self createSeparater];
    [self createMiddleBottomView];
    [self createBottomView];
     //*/
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reqeustData];
}


#pragma mark - 搜索button
-(void)createTopView
{
#pragma mark - 城市选择button
    _cityChooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cityChooseBtn.frame = CGRectMake(10, 25, 80, 50);
//    cityChooseBtn.backgroundColor = [UIColor redColor];
    
    [_cityChooseBtn setImage:[UIImage imageNamed:@"v6_common_up_arrow_btn"] forState:UIControlStateNormal];
    [_cityChooseBtn setImage:[UIImage imageNamed:@"v6_common_up_arrow_selected_btn"] forState:UIControlStateHighlighted];
    _cityChooseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    
    [_cityChooseBtn setTitle:@"郑州" forState:UIControlStateNormal];
    _cityChooseBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    _cityChooseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cityChooseBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_cityChooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cityChooseBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [_cityChooseBtn addTarget:self action:@selector(cityChooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cityChooseBtn];

    
#pragma mark - 搜索button
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(100, 25, SCREEN_WIDTH-120, 50);
//    searchButton.backgroundColor = [UIColor redColor];
    
    [searchButton setImage:[UIImage imageNamed:@"v6_common_search"] forState:UIControlStateNormal];
    
    [searchButton setTitle:@"   寻找团购,店铺,地点" forState:UIControlStateNormal];
    searchButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    searchButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [searchButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:searchButton];
}
#pragma mark - 城市选择button按钮
-(void)cityChooseBtnAction:(UIButton *)sender
{
    CityChooseViewController *cityChooseVC = [[CityChooseViewController alloc]init];
    
    //实现
    cityChooseVC.changecellContent = ^(NSString *cellContent){
        
        sender.titleLabel.text = cellContent;
    };

    [self presentViewController:cityChooseVC animated:YES completion:nil];
}
#pragma mark - 搜索button按钮
-(void)searchButtonAction:(UIButton *)sender
{
    SearchViewController *searchVC = [[SearchViewController alloc]init];
//    [FlipViewTool changeViewContorller:searchVC];
//    [FlipViewTool flipView:[[[UIApplication sharedApplication] delegate] window] withDuration:1 withStyle:UIViewAnimationTransitionNone];
    
    
//    //弹出样式
//    searchVC.modalPresentationStyle = UIModalPresentationFormSheet;
//    //弹出动画效果
//    searchVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:searchVC animated:YES completion:nil];
}


#pragma mark - 看附近按钮点击方法
- (IBAction)lookNearClick:(id)sender {
    
    NearViewController *nearVC = [[NearViewController alloc]init];
    
#pragma mark - 获得相应城市的经纬度信息,并传出去
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    
    if (!error) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        XBaseDataModel *model = [XBaseDataModel modelObjectWithDictionary:jsonDic];
        
        for (XCities *cities in model.cities) {
            NSString *name = cities.name;
            if (_cityChooseBtn.titleLabel.text == name) {
                
                nearVC.latitude = cities.latitude;
                nearVC.longitude = cities.longitude;
            }
        }
    }else{
        
        NSLog(@"%@",error);
    }

    [self presentViewController:nearVC animated:YES completion:nil];
}


#pragma mark - 找分类按钮点击方法
- (IBAction)seekCategory:(id)sender {
    
    CategoryViewController *categoryVC = [[CategoryViewController alloc]init];
    
    [self presentViewController:categoryVC animated:YES completion:nil];
}


/*
#pragma mark - 头部
-(void)createHeadView
{
    NSMutableArray *nameArray = [[NSMutableArray alloc]initWithObjects:@"看附近",@"找分类", nil];
    float imgWidth = 30;
    float rowSpace = 20;
    float colSpace = (SCREEN_WIDTH - 2*(imgWidth+80))/3;
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.backgroundColor = [UIColor redColor];
        
        btn.frame = CGRectMake(colSpace-15+(imgWidth+80+colSpace)*(i%2), 60+rowSpace, imgWidth, imgWidth);
        
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_00%d",i+1]] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_00%d_selected",i+1]] forState:UIControlStateHighlighted];
        
        UIEdgeInsets insets = UIEdgeInsetsMake(120, -120, 120, 120);
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"home_003"]];
        image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        [btn setBackgroundImage:image forState:UIControlStateHighlighted];
        
        
        btn.tag = i+1;
        [btn addTarget:self action:@selector(HeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setTitle:[nameArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -100)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.view addSubview:btn];
    }
}
-(void)HeadButtonAction:(UIButton*)button
{
    
}
*/

#pragma mark - 请求图片数据
-(void)reqeustData
{
    ///*
     #pragma mark - AFNetworking 获取异步数据
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     [manager GET:@"http://m.api.tuan800.com/api/checkconfig/v3/banner?product=tuan800&imgModel=webp&platform=android&trackid=c0fd96&cityid=1&mode=1" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
     
     NSDictionary *jsonDic = responseObject;
     
     ZYBaseModel *model = [ZYBaseModel modelObjectWithDictionary:jsonDic];
     
     //获得流数据
     [self.imgArray setArray:model.banner];
//     NSLog(@"model.banner:%@",model.banner);
//     NSLog(@"self.imgArray:%@",self.imgArray);
//     NSLog(@"self.imgArray.count:%ld",self.imgArray.count);
     
     [self createScrollView];
     [self addPage];
     
     } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
     NSLog(@"---%@",error);
     }];
     //*/
    
    
    /*
     #pragma mark - 获取异步数据
     //1,url
     NSURL *url = [NSURL URLWithString:@"http://m.api.tuan800.com/api/checkconfig/v3/banner?product=tuan800&imgModel=webp&platform=android&trackid=c0fd96&cityid=1&mode=1"];
     //2,request
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     
     [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
     
     if (!connectionError) {
     
     NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
     
     ZYBaseModel *model = [ZYBaseModel modelObjectWithDictionary:jsonDic];
     
     //获得流数据
     [self.imgArray setArray:model.banner];
     NSLog(@"model.banner:%@",model.banner);
     NSLog(@"self.imgArray:%@",self.imgArray);
     NSLog(@"%ld",self.imgArray.count);
     [self createScrollView];
     [self addPage];
     
     }else{
     
     NSLog(@"connectionError===%@",connectionError);
     }
     
     }];
     */
    
    
    /*
#pragma mark - 获取同步数据
    //1,url
    NSURL *url = [NSURL URLWithString:@"http://m.api.tuan800.com/api/checkconfig/v3/banner?product=tuan800&imgModel=webp&platform=android&trackid=c0fd96&cityid=1&mode=1"];
    //2,request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3,链接
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if (!error) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        ZYBaseModel *model = [ZYBaseModel modelObjectWithDictionary:jsonDic];
         
        //获得流数据
        [self.imgArray setArray:model.banner];
//        NSLog(@"model.banner:%@",model.banner);
//        NSLog(@"self.imgArray:%@",self.imgArray);
//        NSLog(@"self.imgArray.count:%ld",self.imgArray.count);
        
        [self createScrollView];
        [self addPage];
        
    }else{
        NSLog(@"%@",error);
    }
    */
}


#pragma mark - 创建scrollView
-(void)createScrollView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 180)];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 180);
    for (int i = 0; i < 2; i++)
    {
        
//        for (ZYBanner *smallImg in self.imgArray) {
        
        ZYBanner *smallImg = self.imgArray[i];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i *SCREEN_WIDTH, 0, SCREEN_WIDTH, 180)];
        
        //分隔字符串
        NSString *string = smallImg.smallDetailImage;
        NSArray *array = [string componentsSeparatedByString:@".webp"];
//        NSLog(@"array:%@",array);
        
        //设置图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:array[0]]];
        [_scrollView addSubview:imageView];
        
//        }
        
        //创建scrollView上的button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i *SCREEN_WIDTH, 0, SCREEN_WIDTH, 180);
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
    }
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    //设置代理
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];

    //初始速度(0-->1)
    _speed = 1;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeImage:) userInfo:_scrollView repeats:YES];
}
//scrollView上的button点击事件
-(void)buttonAction
{
//    for (ZYBanner *bigImg in self.imgArray) {
    
    if (_pageControl.currentPage == 0) {
        
        ZYBanner *bigImg = self.imgArray[_pageControl.currentPage];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        
        NSLog(@"bigImg.data:%@",bigImg.data);
        //设置图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:bigImg.data]];
        
        ImageViewController *imageVC = [[ImageViewController alloc]init];
        imageVC.imageView = imageView;
        [self presentViewController:imageVC animated:YES completion:nil];
        
    }else{
        
    }
    
//    }
}
//定时器方法
- (void)changeImage:(NSTimer *)timer
{
    UIScrollView *scrollView = [timer userInfo];
    
    //每次对scrollView的偏移量进行改变
    //第一:确定速度(1/-1)
    //第二:确定当前页
    
    if (_pageControl.currentPage == 0)
    {
        _speed = 1;
    }
    if (_pageControl.currentPage == 1)
    {
        _speed = -1;
    }
    
    _pageControl.currentPage = _pageControl.currentPage + _speed;
    
    //改变scrollView的偏移量
    [scrollView setContentOffset:CGPointMake(_pageControl.currentPage * SCREEN_WIDTH, 0) animated:YES];
}
#pragma mark -  scrollView的协议方法 UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //将要开始拖拽
    if (_timer != nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //根据偏移量,计算当前页
    _pageControl.currentPage = scrollView.contentOffset.x/SCREEN_WIDTH;
    
    if (_pageControl.currentPage == 1)
    {
        _speed = -1;
    }
    if (_pageControl.currentPage == 0)
    {
        _speed = 1;
    }
    
    if (_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeImage:) userInfo:scrollView repeats:YES];
    }
}


#pragma mark - 添加页数
-(void)addPage
{
    //UIPageControl
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, 270, 60, 30)];
    //设置页数
    _pageControl.numberOfPages = 2;
    
    _pageControl.backgroundColor = [UIColor clearColor];
    //设置当前显示的指示灯的颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    //其他不显示的颜色
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    //给pageControl绑定点击事件
    [_pageControl addTarget:self action:@selector(changeCurrentImage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
}
-(void)changeCurrentImage:(UIPageControl *)sender
{
    NSLog(@"----%ld",(long)sender.currentPage);
    
    [_scrollView setContentOffset:CGPointMake(sender.currentPage * SCREEN_WIDTH, 0) animated:YES];
}


#pragma mark - 中上部
-(void)createMiddleHeadView
{
    NSMutableArray *nameArray = [[NSMutableArray alloc]initWithObjects:@"美食",@"电影",@"酒店",@"更多", nil];
    float imgWidth = 60;
    float rowSpace = 20;
    float colSpace = (SCREEN_WIDTH - 4*imgWidth)/5;
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.backgroundColor = [UIColor redColor];
        
        btn.frame = CGRectMake(colSpace+(imgWidth+colSpace)*(i%4), 300+rowSpace, imgWidth, imgWidth);
        
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_%d",i+1]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_%d_selected",i+1]] forState:UIControlStateHighlighted];
        btn.tag = i+1+TAG_ADD1;
        [btn addTarget:self action:@selector(MiddleHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setTitle:[nameArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(120, 0, 0, 0)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
}
-(void)MiddleHeadButtonAction:(UIButton*)button
{
    
}


#pragma mark - 横向分割线
-(void)createSeparater
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 430, SCREEN_WIDTH-40, 1)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:view];
}


#pragma mark - 中下部
-(void)createMiddleBottomView
{
    NSMutableArray *nameArray = [[NSMutableArray alloc]initWithObjects:@"限时抢购",@"今日新单",@"九块九包邮",@"签到有礼",@"积分商城",@"团购名站", nil];
    float imgWidth = 60;
    float rowSpace = 50;
    float colSpace = (SCREEN_WIDTH - 3*imgWidth)/4;
    for (int i = 0; i < 6; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.backgroundColor = [UIColor redColor];
        
        btn.frame = CGRectMake(colSpace+(imgWidth+colSpace)*(i%3), 450+(imgWidth+rowSpace)*(i/3), imgWidth, imgWidth);
        
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_0%d",i+1]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_0%d_selected",i+1]] forState:UIControlStateHighlighted];
        btn.tag = i+1+TAG_ADD2;
        [btn addTarget:self action:@selector(MiddleBottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setTitle:[nameArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(80, 0, 0, 0)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:btn];
    }
}
-(void)MiddleBottomButtonAction:(UIButton*)button
{
    
}


#pragma mark - 底部
-(void)createBottomView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 670, SCREEN_WIDTH, 100)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    NSMutableArray *nameArray = [[NSMutableArray alloc]initWithObjects:@"订单",@"积分",@"优惠券",@"收藏",nil];
    
    float imgWidth = 30;
    float rowSpace = 10;
    float colSpace = (SCREEN_WIDTH - 5*imgWidth)/6;
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.backgroundColor = [UIColor redColor];
        
        btn.frame = CGRectMake(colSpace-20+(imgWidth+colSpace+10)*(i%5), rowSpace, imgWidth, imgWidth);
        
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_000%d",i+1]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_000%d_selected",i+1]] forState:UIControlStateHighlighted];
        btn.tag = i+1+TAG_ADD3;
        [btn addTarget:self action:@selector(BottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        if (i == 0){
            
            btn.frame = CGRectMake(colSpace-20+(imgWidth+colSpace+10)*(i%5), rowSpace+5, imgWidth+10, imgWidth+10);
            
        }else{
            [btn setTitle:[nameArray objectAtIndex:i-1] forState:UIControlStateNormal];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(50, 0, 0, 0)];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:10];
        }
    }
    [self.view addSubview:view];
}
-(void)BottomButtonAction:(UIButton*)button
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
