//
//  YBaseAllData.m
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "YBaseAllData.h"
#import "YMetadata.h"
#import "YTagdata.h"
#import "YShops.h"


NSString *const kYBaseAllDataMetadata = @"_metadata";
NSString *const kYBaseAllDataTagdata = @"tagdata";
NSString *const kYBaseAllDataShops = @"shops";
NSString *const kYBaseAllDataDistance = @"distance";


@interface YBaseAllData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YBaseAllData

@synthesize metadata = _metadata;
@synthesize tagdata = _tagdata;
@synthesize shops = _shops;
@synthesize distance = _distance;


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
            self.metadata = [YMetadata modelObjectWithDictionary:[dict objectForKey:kYBaseAllDataMetadata]];
    NSObject *receivedYTagdata = [dict objectForKey:kYBaseAllDataTagdata];
    NSMutableArray *parsedYTagdata = [NSMutableArray array];
    if ([receivedYTagdata isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYTagdata) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYTagdata addObject:[YTagdata modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYTagdata isKindOfClass:[NSDictionary class]]) {
       [parsedYTagdata addObject:[YTagdata modelObjectWithDictionary:(NSDictionary *)receivedYTagdata]];
    }

    self.tagdata = [NSArray arrayWithArray:parsedYTagdata];
    NSObject *receivedYShops = [dict objectForKey:kYBaseAllDataShops];
    NSMutableArray *parsedYShops = [NSMutableArray array];
    if ([receivedYShops isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYShops) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYShops addObject:[YShops modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYShops isKindOfClass:[NSDictionary class]]) {
       [parsedYShops addObject:[YShops modelObjectWithDictionary:(NSDictionary *)receivedYShops]];
    }

    self.shops = [NSArray arrayWithArray:parsedYShops];
            self.distance = [[self objectOrNilForKey:kYBaseAllDataDistance fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.metadata dictionaryRepresentation] forKey:kYBaseAllDataMetadata];
    NSMutableArray *tempArrayForTagdata = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tagdata) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTagdata addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTagdata addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTagdata] forKey:kYBaseAllDataTagdata];
    NSMutableArray *tempArrayForShops = [NSMutableArray array];
    for (NSObject *subArrayObject in self.shops) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForShops addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForShops addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForShops] forKey:kYBaseAllDataShops];
    [mutableDict setValue:[NSNumber numberWithDouble:self.distance] forKey:kYBaseAllDataDistance];

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

    self.metadata = [aDecoder decodeObjectForKey:kYBaseAllDataMetadata];
    self.tagdata = [aDecoder decodeObjectForKey:kYBaseAllDataTagdata];
    self.shops = [aDecoder decodeObjectForKey:kYBaseAllDataShops];
    self.distance = [aDecoder decodeDoubleForKey:kYBaseAllDataDistance];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_metadata forKey:kYBaseAllDataMetadata];
    [aCoder encodeObject:_tagdata forKey:kYBaseAllDataTagdata];
    [aCoder encodeObject:_shops forKey:kYBaseAllDataShops];
    [aCoder encodeDouble:_distance forKey:kYBaseAllDataDistance];
}

- (id)copyWithZone:(NSZone *)zone
{
    YBaseAllData *copy = [[YBaseAllData alloc] init];
    
    if (copy) {

        copy.metadata = [self.metadata copyWithZone:zone];
        copy.tagdata = [self.tagdata copyWithZone:zone];
        copy.shops = [self.shops copyWithZone:zone];
        copy.distance = self.distance;
    }
    
    return copy;
}


@end
