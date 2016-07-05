//
//  ZYButton.m
//  Project-Tuan800
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZYButton.h"

@implementation ZYButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.frame = CGRectMake(0, 20, 30, 30);
        self.imageView.image = [UIImage imageNamed:@"v6_common_search"];
        [self addSubview:self.imageView];
        
        self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame), 20, self.frame.size.width-CGRectGetMaxX(self.imageView.frame)-20, 30);
        self.titleLabel.text = @"寻找团购,店铺,地点";
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.backgroundColor = [UIColor magentaColor];
        [self addSubview:self.titleLabel];
        // 内容水平向左
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        // 占位文字
//        self.borderStyle = UITextBorderStyleLine;

    }
    return self;
}
@end
