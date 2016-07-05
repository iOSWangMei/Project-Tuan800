//
//  XCities.h
//
//  Created by mac  on 16/7/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface XCities : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *citiesIdentifier;
@property (nonatomic, assign) double latitude;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pinyin;
@property (nonatomic, assign) double longitude;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
