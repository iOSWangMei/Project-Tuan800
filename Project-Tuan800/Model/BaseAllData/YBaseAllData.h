//
//  YBaseAllData.h
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YMetadata;

@interface YBaseAllData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) YMetadata *metadata;
@property (nonatomic, strong) NSArray *tagdata;
@property (nonatomic, strong) NSArray *shops;
@property (nonatomic, assign) double distance;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
