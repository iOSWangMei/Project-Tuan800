//
//  ZYBaseModel.h
//
//  Created by mac  on 16/6/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZYBaseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *banner;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
