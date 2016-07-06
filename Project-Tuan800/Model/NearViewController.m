//
//  NearViewController.m
//  Project-Tuan800
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

#import "NearViewController.h"
#import "FilterViewController.h"
#import "YDataModels.h"
#import "CustomCell.h"
#import "DistanceView.h"
#import "SortView.h"
#import <CoreLocation/CoreLocation.h>

@interface NearViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_button;
    
    NSMutableArray *_imgArray;
    NSMutableArray *_titleNameArray;
    NSMutableArray *_dealsCountArray;
    NSMutableArray *_minPriceArray;
    NSMutableArray *_maxPriceArray;
    NSMutableArray *_nameArray;
    NSMutableArray *_addressArray;
    
    BOOL _btnIsRed;
    DistanceView *_distanceView;
    SortView *_sortView;
}
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation NearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor cyanColor];
    self.dataArray = [[NSMutableArray alloc]init];
    
    _imgArray = [[NSMutableArray alloc]init];
    _titleNameArray = [[NSMutableArray alloc]init];
    _dealsCountArray = [[NSMutableArray alloc]init];
    _minPriceArray = [[NSMutableArray alloc]init];
    _maxPriceArray = [[NSMutableArray alloc]init];
    _nameArray = [[NSMutableArray alloc]init];
    _addressArray = [[NSMutableArray alloc]init];
    
    [self createHeadView];
    [self createLine];
    [self getData];
//    [self createTableView];
    [self createBottomView];
}


#pragma mark - 在视图将要出现的时候加载数据
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self getData];
//    [self createTableView];
}


#pragma mark - 获取数据
-(void)getData
{
    //1,url
    NSURL *url = [NSURL URLWithString:@"http://m.api.tuan800.com/v4/nearby?imgModel=webp&supportType=1%2C2%2C3%2C4%2C5&distance=2.0&imgType=all&tagdata=true&longitude=113.741165&autoDistance=true&latitude=34.722058&metadata=true&page=1&pageset=15"];
    //2,request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3,链接
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if (!error) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        YBaseAllData *model = [YBaseAllData modelObjectWithDictionary:jsonDic];
        
        //获得流数据
        [self.dataArray setArray:model.shops];
        for (YShops *shop in self.dataArray) {
            
            YDeal *deal = shop.deal;
            NSString *imgNormal = deal.imgNormal;
            [_imgArray addObject:imgNormal];
            
            NSString *titleName = shop.name;
            [_titleNameArray addObject:titleName];
            
            int dealsC = shop.dealsCount;
            NSString *dealsCount = [NSString stringWithFormat:@"%d",dealsC];
            [_dealsCountArray addObject:dealsCount];
            
            double minP = shop.minPrice/100.f;
            NSString *minPrice = nil;
            if (minP > 10) {
                
                minPrice = [NSString stringWithFormat:@"%.f",minP];
            }else{
                
                minPrice = [NSString stringWithFormat:@"%.1f",minP];
            }
            [_minPriceArray addObject:minPrice];
            
            double maxP = shop.maxPrice/100.f;
            NSString *maxPrice = [NSString stringWithFormat:@"%.f",maxP];
            [_maxPriceArray addObject:maxPrice];
            
            YTag *tag = shop.tag;
            NSString *name = tag.name;
            [_nameArray addObject:name];
            
            NSString *address = shop.address;
            [_addressArray addObject:address];
        }
        /*
        NSLog(@"_imgArray.count:%ld",_imgArray.count);
        NSLog(@"_imgArray.count:%@",_imgArray);
        
        NSLog(@"_titleNameArray.count:%ld",_titleNameArray.count);
        NSLog(@"_titleNameArray.count:%@",_titleNameArray);
        
        NSLog(@"_dealsCountArray.count:%ld",_dealsCountArray.count);
        NSLog(@"_dealsCountArray.count:%@",_dealsCountArray);
        
        NSLog(@"_minPriceArray.count:%ld",_minPriceArray.count);
        NSLog(@"_minPriceArray.count:%@",_minPriceArray);
        
        NSLog(@"_maxPriceArray.count:%ld",_maxPriceArray.count);
        NSLog(@"_maxPriceArray.count:%@",_maxPriceArray);
        
        NSLog(@"_nameArray.count:%ld",_nameArray.count);
        NSLog(@"_nameArray.count:%@",_nameArray);
        
        NSLog(@"_addressArray.count:%ld",_addressArray.count);
        NSLog(@"_addressArray.count:%@",_addressArray);
        */
        [self createTableView];
        
    }else{
        
        NSLog(@"%@",error);
    }
}


#pragma mark - 内容视图--创建tableView
-(void)createTableView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT-120)];
//    view.backgroundColor = [UIColor redColor];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120)];
//    tableView.backgroundColor = [UIColor magentaColor];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 100;
    
    [view addSubview:tableView];
    
    [self.view addSubview:view];
}

#pragma mark - UITableViewDataSource
#pragma mark - 每个区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleNameArray.count;
}
#pragma mark - 每一行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil];
        cell = [cellArray objectAtIndex:0];
    }
    
    //1.图片
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_imgArray objectAtIndex:indexPath.row]]];
    cell.normalImgView.image = [UIImage imageWithData:data];
    
    //2.标题
    cell.titleNameLabel.text = [_titleNameArray objectAtIndex:indexPath.row];
    cell.titleNameLabel.font = [UIFont systemFontOfSize:15];
    cell.titleNameLabel.textAlignment = NSTextAlignmentLeft;
    
    //3.团购个数
    cell.dealsCountLabel.text = [_dealsCountArray objectAtIndex:indexPath.row];
    cell.dealsCountLabel.textColor = [UIColor redColor];
    cell.dealsCountLabel.font = [UIFont systemFontOfSize:12];
    cell.dealsCountLabel.textAlignment = NSTextAlignmentRight;
    
    //4.价格
    if ([_minPriceArray objectAtIndex:indexPath.row] == [_maxPriceArray objectAtIndex:indexPath.row]) {
        cell.priceLabel.text = [NSString stringWithFormat:@"¥ %@",[_minPriceArray objectAtIndex:indexPath.row]];
    }else{
        cell.priceLabel.text = [NSString stringWithFormat:@"¥ %@ ~ ¥ %@",[_minPriceArray objectAtIndex:indexPath.row],[_maxPriceArray objectAtIndex:indexPath.row]];
    }
    cell.priceLabel.textColor = [UIColor redColor];
    cell.priceLabel.textAlignment = NSTextAlignmentLeft;
    
    //5.菜系名
    cell.nameLabel.text = [_nameArray objectAtIndex:indexPath.row];
    cell.nameLabel.font = [UIFont systemFontOfSize:13];
    cell.nameLabel.textAlignment = NSTextAlignmentRight;
    
    //6.地址
    cell.addressLabel.text = [_addressArray objectAtIndex:indexPath.row];
    cell.addressLabel.font = [UIFont systemFontOfSize:12];
    cell.addressLabel.textAlignment = NSTextAlignmentLeft;
    
//    //7.距离
//    cell.distanceLabel.text = [_distanceArray objectAtIndex:indexPath.row];
    
    return cell;
}
#pragma mark - UITableViewDelegate
#pragma mark - 选中某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


#pragma mark - 纵向分割线
-(void)createLine
{
    for (int i = 1; i < 4; i ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4 * i, 35, 1, 20)];
        view.backgroundColor = [UIColor blackColor];
        [self.view addSubview:view];
    }
}


#pragma mark - 创建头部视图
-(void)createHeadView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    for (int i = 0; i < 4; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH/4 * i, 0, SCREEN_WIDTH/4, 50);
        
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        
        [view addSubview:btn];
        
        if (i == 0) {
            
#pragma mark - 全部button
            [btn setImage:[UIImage imageNamed:@"v6_category_all_icon1"] forState:UIControlStateNormal];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            
            [btn setTitle:@"全部" forState:UIControlStateNormal];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
            [btn addTarget:self action:@selector(allBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 1) {
            
#pragma mark - 距离button
            [btn setImage:[UIImage imageNamed:@"v6_category_filterbar_arrow_down"] forState:UIControlStateNormal];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 80, 0, 0);
            
            [btn setTitle:@"2km" forState:UIControlStateNormal];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
             _btnIsRed = NO;
            
            [btn addTarget:self action:@selector(distanceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 2) {
            
#pragma mark - 默认排序button
            [btn setImage:[UIImage imageNamed:@"v6_category_filterbar_arrow_down"] forState:UIControlStateNormal];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 90, 0, 0);
            
            [btn setTitle:@"默认排序" forState:UIControlStateNormal];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            _btnIsRed = NO;
            NSLog(@"%d",_btnIsRed);
            
            [btn addTarget:self action:@selector(orderBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            
#pragma mark - 筛选button
            [btn setImage:[UIImage     imageNamed:@"v6_category_filterbar_icon4"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"v6_category_filterbar_icon4_selected"] forState:UIControlStateHighlighted];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            
            [btn setTitle:@"筛选" forState:UIControlStateNormal];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
            [btn addTarget:self action:@selector(filterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    [self.view addSubview:view];
}


#pragma mark - 全部button点击
-(void)allBtnAction:(UIButton *)sender
{
    
}

#pragma mark - 弹出距离视图
-(DistanceView *)createDistanceView
{
    DistanceView *distanceView = [[DistanceView alloc]initWithFrame:CGRectMake(0, 71, SCREEN_WIDTH, SCREEN_HEIGHT-71)];
    distanceView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:distanceView];
    
    distanceView.leftArray = [[NSMutableArray alloc]initWithObjects:@"附近",@"全郑州",@"金水区",@"二七区",@"中原区",@"近郊",@"管城区",@"上街区",@"惠济区",@"郑东新区", nil];
    
    float rightRowSpace = 10;
    float rightButtonWidth = 100;
    float rightButtonHeight = 30;


    NSMutableArray *rightArray = [[NSMutableArray alloc]initWithObjects:@"0.5km",@"1km",@"2km",@"3km",@"5km",@"10km", nil];
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"所有区域",@"所有商圈", nil];
    
    for (int i = 0; i < 5; i ++) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (distanceView.cell.textLabel.text == [distanceView.leftArray objectAtIndex:0]) {
            
            rightButton.center = CGPointMake(distanceView.frame.size.width/2+100, rightRowSpace+(rightButtonHeight/2)+(rightRowSpace+rightButtonHeight)*i);
            [rightButton setTitle:[rightArray objectAtIndex:i] forState:UIControlStateNormal];
            [rightButton setTitle:[rightArray objectAtIndex:i] forState:UIControlStateSelected];
            
        }else if (distanceView.cell.textLabel.text == [distanceView.leftArray objectAtIndex:1]) {
            
            rightButton.center = CGPointMake(distanceView.frame.size.width/2+100, rightRowSpace+(rightButtonHeight/2));
            [rightButton setTitle:@"所有区域" forState:UIControlStateNormal];
            [rightButton setTitle:@"所有区域" forState:UIControlStateSelected];
        }else{
            
            rightButton.center = CGPointMake(distanceView.frame.size.width/2+100, rightRowSpace+(rightButtonHeight/2));
            [rightButton setTitle:@"所有商圈" forState:UIControlStateNormal];
            [rightButton setTitle:@"所有商圈" forState:UIControlStateSelected];
        }

        rightButton.bounds = CGRectMake(0, 0, rightButtonWidth, rightButtonHeight);
        
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [rightButton setBackgroundImage:[UIImage imageNamed:@"v6_category_filterbar_selected_cell2"] forState:UIControlStateSelected];
        
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [rightButton addTarget:self action:@selector(distanceViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [distanceView.rightView addSubview:rightButton];
    }

    return distanceView;
}
#pragma mark - 点击button,对tableView进行排序
-(void)distanceViewButtonAction:(UIButton *)sender
{
    
}
//    //[view addSubview:view];
//    [view bringSubviewToFront:view];
//
//    //[view removeFromSuperview];
//    [view bringSubviewToFront:view];

#pragma mark - 距离button点击
-(void)distanceBtnAction:(UIButton *)sender
{
    _btnIsRed = !_btnIsRed;
    NSLog(@"%d",_btnIsRed);
    
    if (_btnIsRed) {
        
        [sender setImage:[UIImage imageNamed:@"v6_category_filterbar_arrow_up"] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
        if (!_distanceView) {
            
            _distanceView = [self createDistanceView];
            [self.view addSubview:_distanceView];
        }
    }else{
        
        [sender setImage:[UIImage imageNamed:@"v6_category_filterbar_arrow_down"] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_distanceView removeFromSuperview];
       
    }
}


#pragma mark - 弹出默认排序视图
-(SortView *)createSortView
{
    SortView *sortView = [[SortView alloc]initWithFrame:CGRectMake(0, 71, SCREEN_WIDTH, SCREEN_HEIGHT-71)];
    sortView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:sortView];
    
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
        [sortView.topView addSubview:button];
    }
    return sortView;
}
#pragma mark - 点击button,对tableView进行排序
-(void)orderViewButtonAction:(UIButton *)sender
{
    
}
#pragma mark - 默认排序button点击
-(void)orderBtnAction:(UIButton *)sender
{
    _btnIsRed = !_btnIsRed;
    NSLog(@"%d",_btnIsRed);
    
    if (_btnIsRed) {
        
        [sender setImage:[UIImage imageNamed:@"v6_category_filterbar_arrow_up"] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
        if (!_sortView) {
            
            _sortView = [self createSortView];
            [self.view addSubview:_sortView];
        }
        
    }else{
        
        [sender setImage:[UIImage imageNamed:@"v6_category_filterbar_arrow_down"] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_sortView removeFromSuperview];
        
    }
}


#pragma mark - 筛选button点击
-(void)filterBtnAction:(UIButton *)sender
{
    FilterViewController *filterVC = [[FilterViewController alloc]init];
    [self presentViewController:filterVC animated:YES completion:nil];
}


#pragma mark - 创建尾部视图
-(void)createBottomView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
#pragma mark - locationButton
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, SCREEN_WIDTH-50, 50);
    [btn setImage:[UIImage imageNamed:@"v6_common_gps_ok_icon1"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [btn setTitle:@"正在定位中..." forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];

    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    [btn addTarget:self action:@selector(locationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];

#pragma mark - 地图button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH-50, 0, 50, 50);
    [button setImage:[UIImage imageNamed:@"v6_category_map"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"v6_category_map_sel"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(mapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    [self.view addSubview:view];
}
/*
#pragma mark - 显示具体定位的button点击
-(void)locationButtonAction:(UIButton *)sender
{
    //初始化地理编码器
    CLGeocoder *geocoder= [[CLGeocoder alloc]init];
    
//    "id":"25",
//    "name":"郑州",
//    "pinyin":"zhengzhou",
//    "longitude":113.624899,
//    "latitude":34.746985
    //获得相应城市的经纬度信息
    CLLocationDegrees latitude = self.latitude;
    CLLocationDegrees longitude = self.longitude;
    
    //反编码,将经纬度,反编成详细的地址信息
    //创建location对象
    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@",error);
            return ;
        }
        
        [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            //总的地址信息
            NSLog(@"%@",obj.addressDictionary);
            //地名
            NSString *name = obj.name;
            NSLog(@"%@",name);
            //街道
            NSString *thoroughfare = obj.thoroughfare;
            NSLog(@"%@",thoroughfare);
            //街道相关的信息,例如门牌等
            NSString *subThoroughfare = obj.subThoroughfare;
            NSLog(@"%@",subThoroughfare);
            //城市
            NSString *locality = obj.locality;
            NSLog(@"%@",locality);
            //城市相关的信息,例如标志性建筑物
            NSString *subLocality = obj.subLocality;
            NSLog(@"%@",subLocality);
            //行政区域信息
            NSString *subAdministrativeArea = obj.subAdministrativeArea;
            NSLog(@"%@",subAdministrativeArea);
            
        }];
        
    }];
 
}
 */
#pragma mark - 地图button点击
-(void)mapButtonAction:(UIButton *)sender
{
    
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
