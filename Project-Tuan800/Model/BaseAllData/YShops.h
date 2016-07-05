//
//  YShops.h
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YTag, YDeal;

@interface YShops : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double rating;
@property (nonatomic, assign) double shopsIdentifier;
@property (nonatomic, assign) double dealsCount;
@property (nonatomic, assign) double minPrice;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) double latitude;
@property (nonatomic, strong) YTag *tag;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *brandName;
@property (nonatomic, strong) YDeal *deal;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double maxPrice;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
