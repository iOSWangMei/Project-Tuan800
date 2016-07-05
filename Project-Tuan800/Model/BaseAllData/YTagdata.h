//
//  YTagdata.h
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YTagdata : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double tagdataIdentifier;
@property (nonatomic, assign) double dealsCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
