//
//  YLinks.h
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YLinks : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *linksSelf;
@property (nonatomic, strong) NSString *last;
@property (nonatomic, strong) NSString *next;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
