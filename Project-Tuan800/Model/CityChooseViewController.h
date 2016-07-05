//
//  CityChooseViewController.h
//  Project-Tuan800
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block)(NSString *);

@interface CityChooseViewController : UIViewController

//声明
@property(nonatomic,copy)block changecellContent;

@end
