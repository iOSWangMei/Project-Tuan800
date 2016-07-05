//
//  XBaseDataModel.m
//
//  Created by mac  on 16/7/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "XBaseDataModel.h"
#import "XCities.h"


NSString *const kXBaseDataModelCities = @"cities";


@interface XBaseDataModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation XBaseDataModel

@synthesize cities = _cities;


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
    NSObject *receivedXCities = [dict objectForKey:kXBaseDataModelCities];
    NSMutableArray *parsedXCities = [NSMutableArray array];
    if ([receivedXCities isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedXCities) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedXCities addObject:[XCities modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedXCities isKindOfClass:[NSDictionary class]]) {
       [parsedXCities addObject:[XCities modelObjectWithDictionary:(NSDictionary *)receivedXCities]];
    }

    self.cities = [NSArray arrayWithArray:parsedXCities];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForCities = [NSMutableArray array];
    for (NSObject *subArrayObject in self.cities) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCities addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCities addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCities] forKey:kXBaseDataModelCities];

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

    self.cities = [aDecoder decodeObjectForKey:kXBaseDataModelCities];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cities forKey:kXBaseDataModelCities];
}

- (id)copyWithZone:(NSZone *)zone
{
    XBaseDataModel *copy = [[XBaseDataModel alloc] init];
    
    if (copy) {

        copy.cities = [self.cities copyWithZone:zone];
    }
    
    return copy;
}


@end
