
//
//  ZYSearch.m
//  Project-Tuan800
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZYSearch.h"

@implementation ZYSearch

/**
 *  init方法内部会调用这个方法
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 内容水平向左
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        // 占位文字
        //self.placeholder = @"寻找团购,店铺,地点";
        self.borderStyle = UITextBorderStyleLine;
        
        self.font = [UIFont systemFontOfSize:9.0];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
//        self.backgroundColor = [UIColor redColor];
        
        // 文本框左边的放大镜图片
        UIImageView *leftSearch = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v6_common_search"]];
        leftSearch.contentMode = UIViewContentModeCenter;
        leftSearch.bounds = CGRectMake(0, 0, 30, 30);
        self.leftView = leftSearch;
        
        // 设置左边的view永远显示
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 设置字体
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

@end
