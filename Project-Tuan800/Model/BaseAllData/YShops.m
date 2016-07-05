//
//  YShops.m
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "YShops.h"
#import "YTag.h"
#import "YDeal.h"


NSString *const kYShopsRating = @"rating";
NSString *const kYShopsId = @"id";
NSString *const kYShopsDealsCount = @"dealsCount";
NSString *const kYShopsMinPrice = @"minPrice";
NSString *const kYShopsLongitude = @"longitude";
NSString *const kYShopsUrl = @"url";
NSString *const kYShopsLatitude = @"latitude";
NSString *const kYShopsTag = @"tag";
NSString *const kYShopsAddress = @"address";
NSString *const kYShopsBrandName = @"brandName";
NSString *const kYShopsDeal = @"deal";
NSString *const kYShopsName = @"name";
NSString *const kYShopsMaxPrice = @"maxPrice";


@interface YShops ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YShops

@synthesize rating = _rating;
@synthesize shopsIdentifier = _shopsIdentifier;
@synthesize dealsCount = _dealsCount;
@synthesize minPrice = _minPrice;
@synthesize longitude = _longitude;
@synthesize url = _url;
@synthesize latitude = _latitude;
@synthesize tag = _tag;
@synthesize address = _address;
@synthesize brandName = _brandName;
@synthesize deal = _deal;
@synthesize name = _name;
@synthesize maxPrice = _maxPrice;


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
            self.rating = [[self objectOrNilForKey:kYShopsRating fromDictionary:dict] doubleValue];
            self.shopsIdentifier = [[self objectOrNilForKey:kYShopsId fromDictionary:dict] doubleValue];
            self.dealsCount = [[self objectOrNilForKey:kYShopsDealsCount fromDictionary:dict] doubleValue];
            self.minPrice = [[self objectOrNilForKey:kYShopsMinPrice fromDictionary:dict] doubleValue];
            self.longitude = [[self objectOrNilForKey:kYShopsLongitude fromDictionary:dict] doubleValue];
            self.url = [self objectOrNilForKey:kYShopsUrl fromDictionary:dict];
            self.latitude = [[self objectOrNilForKey:kYShopsLatitude fromDictionary:dict] doubleValue];
            self.tag = [YTag modelObjectWithDictionary:[dict objectForKey:kYShopsTag]];
            self.address = [self objectOrNilForKey:kYShopsAddress fromDictionary:dict];
            self.brandName = [self objectOrNilForKey:kYShopsBrandName fromDictionary:dict];
            self.deal = [YDeal modelObjectWithDictionary:[dict objectForKey:kYShopsDeal]];
            self.name = [self objectOrNilForKey:kYShopsName fromDictionary:dict];
            self.maxPrice = [[self objectOrNilForKey:kYShopsMaxPrice fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.rating] forKey:kYShopsRating];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shopsIdentifier] forKey:kYShopsId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dealsCount] forKey:kYShopsDealsCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.minPrice] forKey:kYShopsMinPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.longitude] forKey:kYShopsLongitude];
    [mutableDict setValue:self.url forKey:kYShopsUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.latitude] forKey:kYShopsLatitude];
    [mutableDict setValue:[self.tag dictionaryRepresentation] forKey:kYShopsTag];
    [mutableDict setValue:self.address forKey:kYShopsAddress];
    [mutableDict setValue:self.brandName forKey:kYShopsBrandName];
    [mutableDict setValue:[self.deal dictionaryRepresentation] forKey:kYShopsDeal];
    [mutableDict setValue:self.name forKey:kYShopsName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.maxPrice] forKey:kYShopsMaxPrice];

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

    self.rating = [aDecoder decodeDoubleForKey:kYShopsRating];
    self.shopsIdentifier = [aDecoder decodeDoubleForKey:kYShopsId];
    self.dealsCount = [aDecoder decodeDoubleForKey:kYShopsDealsCount];
    self.minPrice = [aDecoder decodeDoubleForKey:kYShopsMinPrice];
    self.longitude = [aDecoder decodeDoubleForKey:kYShopsLongitude];
    self.url = [aDecoder decodeObjectForKey:kYShopsUrl];
    self.latitude = [aDecoder decodeDoubleForKey:kYShopsLatitude];
    self.tag = [aDecoder decodeObjectForKey:kYShopsTag];
    self.address = [aDecoder decodeObjectForKey:kYShopsAddress];
    self.brandName = [aDecoder decodeObjectForKey:kYShopsBrandName];
    self.deal = [aDecoder decodeObjectForKey:kYShopsDeal];
    self.name = [aDecoder decodeObjectForKey:kYShopsName];
    self.maxPrice = [aDecoder decodeDoubleForKey:kYShopsMaxPrice];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_rating forKey:kYShopsRating];
    [aCoder encodeDouble:_shopsIdentifier forKey:kYShopsId];
    [aCoder encodeDouble:_dealsCount forKey:kYShopsDealsCount];
    [aCoder encodeDouble:_minPrice forKey:kYShopsMinPrice];
    [aCoder encodeDouble:_longitude forKey:kYShopsLongitude];
    [aCoder encodeObject:_url forKey:kYShopsUrl];
    [aCoder encodeDouble:_latitude forKey:kYShopsLatitude];
    [aCoder encodeObject:_tag forKey:kYShopsTag];
    [aCoder encodeObject:_address forKey:kYShopsAddress];
    [aCoder encodeObject:_brandName forKey:kYShopsBrandName];
    [aCoder encodeObject:_deal forKey:kYShopsDeal];
    [aCoder encodeObject:_name forKey:kYShopsName];
    [aCoder encodeDouble:_maxPrice forKey:kYShopsMaxPrice];
}

- (id)copyWithZone:(NSZone *)zone
{
    YShops *copy = [[YShops alloc] init];
    
    if (copy) {

        copy.rating = self.rating;
        copy.shopsIdentifier = self.shopsIdentifier;
        copy.dealsCount = self.dealsCount;
        copy.minPrice = self.minPrice;
        copy.longitude = self.longitude;
        copy.url = [self.url copyWithZone:zone];
        copy.latitude = self.latitude;
        copy.tag = [self.tag copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.brandName = [self.brandName copyWithZone:zone];
        copy.deal = [self.deal copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.maxPrice = self.maxPrice;
    }
    
    return copy;
}


@end
