//
//  YDeal.h
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YSite;

@interface YDeal : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double dealIdentifier;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, assign) double salesVolume;
@property (nonatomic, strong) NSString *imgBig;
@property (nonatomic, assign) BOOL appointment;
@property (nonatomic, assign) BOOL soldOut;
@property (nonatomic, assign) double listPrice;
@property (nonatomic, strong) NSString *imgSmall;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double scoreRating;
@property (nonatomic, assign) double canBuy;
@property (nonatomic, assign) double commentsCount;
@property (nonatomic, strong) NSString *expireDate;
@property (nonatomic, strong) NSString *closeTime;
@property (nonatomic, strong) YSite *site;
@property (nonatomic, strong) NSString *imgNormal;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
