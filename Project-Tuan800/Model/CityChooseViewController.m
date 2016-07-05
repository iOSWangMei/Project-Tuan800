//
//  CityChooseViewController.m
//  Project-Tuan800
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height


#import "CityChooseViewController.h"
#import "ZYSearch.h"
#import "XDataModels.h"

@interface CityChooseViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_cityArray;
    UITableView *_tableView;
    NSMutableDictionary *_mDict_group_City;
    NSArray *_keyArray;
    UITableViewCell *_cell;
    NSInteger _currentSelectRow;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *hotCityArray;
@property(nonatomic,strong)NSMutableArray *recentVisitArray;

@end

@implementation CityChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor cyanColor];
    
    _currentSelectRow = 0;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    
    self.hotCityArray = [[NSMutableArray alloc]initWithObjects:@"北京",@"上海",@"西安",@"成都",@"广州",@"深圳",@"天津",@"武汉",@"杭州",@"重庆",@"苏州",@"南京", nil];
    self.recentVisitArray = [[NSMutableArray alloc]init];
    
    
    _cityArray = [[NSMutableArray alloc]init];
    
    self.dataArray = [[NSMutableArray alloc]init];
    
    _keyArray = [[NSArray alloc]init];
    
    [self createSearch];
    [self getData];
    [self getDataInSection];
    [self createTableView];    
}


#pragma mark - 信息修改完毕后,刷新表
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_tableView reloadData];
}

#pragma mark - 获得数据流
-(void)getData
{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
//    NSLog(@"jsonPath:%@",jsonPath);
    
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    
    if (!error) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        XBaseDataModel *model = [XBaseDataModel modelObjectWithDictionary:jsonDic];
        
        [self.dataArray setArray:model.cities];
        
        for (XCities *cities in self.dataArray) {
            
//            NSString *name = cities.name;
            [_cityArray addObject:cities];
        }
        
//        NSLog(@"_cityArray.count:%ld",_cityArray.count);
        
    }else{
        
        NSLog(@"%@",error);
    }
}


#pragma mark - 创建搜索框
-(void)createSearch
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    ZYSearch *search = [[ZYSearch alloc]initWithFrame:CGRectMake(10, 8, SCREEN_WIDTH-20, 35)];
    search.placeholder = @"请输入城市关键字";
    
    [view addSubview:search];
    [self.view addSubview:view];
}


#pragma mark - 根据首字母取出每个区的数据
-(void)getDataInSection
{
    _mDict_group_City = [[NSMutableDictionary alloc]init];
    
    //分组(对 _cityArray 中的元素进行分组)
    //通过block 遍历数组
    [_cityArray enumerateObjectsUsingBlock:^(XCities*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"==%@",obj);
        NSString *cityName = obj.pinyin;
        
        /*
         NSString *cityName = obj.name;
        
        //(1)汉语转拼音
        NSMutableString *mString_city_name = [NSMutableString stringWithString:cityName];
        CFMutableStringRef cf_mString_city_name = (__bridge CFMutableStringRef)mString_city_name;
        
        //参数1:表示要转换的字符串
        //参数2:转换的范围 range NULL:表示全部转换
        //参数3:转换类型(汉语转拼音)
        //参数4:是否可逆
        CFStringTransform(cf_mString_city_name, NULL, kCFStringTransformMandarinLatin, NO);
        //去掉音符
        CFStringTransform(cf_mString_city_name, NULL, kCFStringTransformStripDiacritics, NO);
         
        //(2)取首字母
        NSString *string_name = (__bridge NSString *)cf_mString_city_name;
        NSString *firstChar = [string_name substringWithRange:NSMakeRange(0, 1)];
         */

        NSString *firstChar = [cityName substringWithRange:NSMakeRange(0, 1)];
        //将小写字母转换为大写字母
        NSString *big_firstChar = firstChar.uppercaseString;
        
        //(3)判断取出的 firstChar 是否与字典中的某个 key 相等.
        
        NSArray *keyArray = _mDict_group_City.allKeys;
        
        BOOL isHave = NO;
        for (NSString *keyString in keyArray)
        {
            if ([keyString isEqualToString:big_firstChar] == YES)
            {
                isHave = YES;
            }
        }
        
        if (isHave == NO)
        {
            //如果不相等,就作为新的一组,将 key(firstChar)-value(array(obj.name)) 存到字典中.
            NSMutableArray *mArray = [NSMutableArray arrayWithObjects:obj.name, nil];
            [_mDict_group_City setObject:mArray forKey:big_firstChar];
        }
        else
        {
            //如果相等,直接将 obj.name 存到key 对应的 value_array中.
            NSMutableArray *mArray = [_mDict_group_City objectForKey:big_firstChar];
            [mArray addObject:obj.name];
        }
        
    }];
    
    //对字典的key进行排序(对数组中的元素进行升序排列)
    _keyArray = [_mDict_group_City.allKeys sortedArrayUsingSelector:@selector(compare:)];
}


#pragma mark - 创建tableView
-(void)createTableView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 80, SCREEN_WIDTH-50, SCREEN_HEIGHT-50)];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-50, SCREEN_HEIGHT-50)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.rowHeight = 60;
    [view addSubview:_tableView];
    
    [self.view addSubview:view];
}

#pragma mark - UITableViewDataSource
#pragma mark - 每个区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%ld",section);
    
    if (section == 0) {
        
        return 1;
    }else if (section == 1) {
        
        return self.recentVisitArray.count;
    }else if (section == 2) {
        
        return self.hotCityArray.count;
    }else if (section >= 3){
        
//        NSLog(@"每个区的行数section:%ld",section);
        NSString *key = [_keyArray objectAtIndex:section-3];
        NSArray *array = [_mDict_group_City objectForKey:key];
        
        return array.count;
    }
    return nil;
}
#pragma mark - 每一行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    _cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!_cell) {
        _cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    if (indexPath.section == 0) {
        
        _cell.textLabel.text = @"定位城市:";
        
    }else if (indexPath.section == 1) {
        
        _cell.textLabel.text = [self.recentVisitArray objectAtIndex:indexPath.row];
        
    }else if (indexPath.section == 2) {
        
        _cell.textLabel.text = [self.hotCityArray objectAtIndex:indexPath.row];
        
    }else if (indexPath.section >= 3) {
        
//        NSLog(@"每一行的内容indexPath.section:%ld",indexPath.section);
        NSString *key = [_keyArray objectAtIndex:indexPath.section-3];
        NSArray *array = [_mDict_group_City objectForKey:key];
        NSString *city = [array objectAtIndex:indexPath.row];
//    NSLog(@"===%@",city);
        _cell.textLabel.text = city;
    }
    return _cell;
}
#pragma mark - 区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"%ld",_keyArray.count);
//    NSLog(@"总区数:%ld",_keyArray.count+3);
    return _keyArray.count+3;
}
/*
#pragma mark - 区头标题
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_keyArray objectAtIndex:section];
}
 */
#pragma mark - 区索引标题
//添加区索引
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray *array = @[@"*",@"#",@"$",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    return array;
}

#pragma mark - UITableViewDelegate
#pragma mark - 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark - 区头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
#pragma mark - 自定义区头
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]init];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-65, 30)];
    
    if (section == 1){
        
        titleLab.text = @"最近访问";
    }else if (section == 2){
        
        titleLab.text = @"热门城市";
    }else if (section >= 3){
        
//        NSLog(@"自定义区头section:%ld",section);
        titleLab.text = [_keyArray objectAtIndex:section-3];
        titleLab.textColor = [UIColor orangeColor];
    }
    
    titleLab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    titleLab.textAlignment = NSTextAlignmentLeft;
    
    titleLab.layer.cornerRadius = 15;
    titleLab.clipsToBounds = YES;
    
    [headerView addSubview:titleLab];
    
    return headerView;
}
#pragma mark - 选中某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _currentSelectRow = indexPath.row;
    
    NSString *cellContent = _cell.textLabel.text;
    //调用
    self.changecellContent(cellContent);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
