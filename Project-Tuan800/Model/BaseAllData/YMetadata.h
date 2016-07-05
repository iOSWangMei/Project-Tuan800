//
//  YMetadata.h
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YLinks;

@interface YMetadata : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) YLinks *links;
@property (nonatomic, assign) double totalPages;
@property (nonatomic, assign) double currentPage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
