//
//  YSite.h
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YSite : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *logoUrl;
@property (nonatomic, assign) double siteIdentifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *siteUrl;
@property (nonatomic, assign) double rating;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
