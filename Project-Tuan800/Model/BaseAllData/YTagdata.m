//
//  YTagdata.m
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "YTagdata.h"


NSString *const kYTagdataId = @"id";
NSString *const kYTagdataDealsCount = @"dealsCount";


@interface YTagdata ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YTagdata

@synthesize tagdataIdentifier = _tagdataIdentifier;
@synthesize dealsCount = _dealsCount;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.tagdataIdentifier = [[self objectOrNilForKey:kYTagdataId fromDictionary:dict] doubleValue];
            self.dealsCount = [[self objectOrNilForKey:kYTagdataDealsCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tagdataIdentifier] forKey:kYTagdataId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dealsCount] forKey:kYTagdataDealsCount];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.tagdataIdentifier = [aDecoder decodeDoubleForKey:kYTagdataId];
    self.dealsCount = [aDecoder decodeDoubleForKey:kYTagdataDealsCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_tagdataIdentifier forKey:kYTagdataId];
    [aCoder encodeDouble:_dealsCount forKey:kYTagdataDealsCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    YTagdata *copy = [[YTagdata alloc] init];
    
    if (copy) {

        copy.tagdataIdentifier = self.tagdataIdentifier;
        copy.dealsCount = self.dealsCount;
    }
    
    return copy;
}


@end
