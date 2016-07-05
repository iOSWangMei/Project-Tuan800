//
//  XCities.m
//
//  Created by mac  on 16/7/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "XCities.h"


NSString *const kXCitiesId = @"id";
NSString *const kXCitiesLatitude = @"latitude";
NSString *const kXCitiesName = @"name";
NSString *const kXCitiesPinyin = @"pinyin";
NSString *const kXCitiesLongitude = @"longitude";


@interface XCities ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation XCities

@synthesize citiesIdentifier = _citiesIdentifier;
@synthesize latitude = _latitude;
@synthesize name = _name;
@synthesize pinyin = _pinyin;
@synthesize longitude = _longitude;


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
            self.citiesIdentifier = [self objectOrNilForKey:kXCitiesId fromDictionary:dict];
            self.latitude = [[self objectOrNilForKey:kXCitiesLatitude fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kXCitiesName fromDictionary:dict];
            self.pinyin = [self objectOrNilForKey:kXCitiesPinyin fromDictionary:dict];
            self.longitude = [[self objectOrNilForKey:kXCitiesLongitude fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.citiesIdentifier forKey:kXCitiesId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.latitude] forKey:kXCitiesLatitude];
    [mutableDict setValue:self.name forKey:kXCitiesName];
    [mutableDict setValue:self.pinyin forKey:kXCitiesPinyin];
    [mutableDict setValue:[NSNumber numberWithDouble:self.longitude] forKey:kXCitiesLongitude];

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

    self.citiesIdentifier = [aDecoder decodeObjectForKey:kXCitiesId];
    self.latitude = [aDecoder decodeDoubleForKey:kXCitiesLatitude];
    self.name = [aDecoder decodeObjectForKey:kXCitiesName];
    self.pinyin = [aDecoder decodeObjectForKey:kXCitiesPinyin];
    self.longitude = [aDecoder decodeDoubleForKey:kXCitiesLongitude];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_citiesIdentifier forKey:kXCitiesId];
    [aCoder encodeDouble:_latitude forKey:kXCitiesLatitude];
    [aCoder encodeObject:_name forKey:kXCitiesName];
    [aCoder encodeObject:_pinyin forKey:kXCitiesPinyin];
    [aCoder encodeDouble:_longitude forKey:kXCitiesLongitude];
}

- (id)copyWithZone:(NSZone *)zone
{
    XCities *copy = [[XCities alloc] init];
    
    if (copy) {

        copy.citiesIdentifier = [self.citiesIdentifier copyWithZone:zone];
        copy.latitude = self.latitude;
        copy.name = [self.name copyWithZone:zone];
        copy.pinyin = [self.pinyin copyWithZone:zone];
        copy.longitude = self.longitude;
    }
    
    return copy;
}


@end
