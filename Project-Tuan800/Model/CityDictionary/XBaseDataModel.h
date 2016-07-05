//
//  XBaseDataModel.h
//
//  Created by mac  on 16/7/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface XBaseDataModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *cities;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
