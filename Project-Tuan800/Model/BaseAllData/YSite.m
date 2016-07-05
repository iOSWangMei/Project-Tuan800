//
//  YSite.m
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "YSite.h"


NSString *const kYSiteLogoUrl = @"logoUrl";
NSString *const kYSiteId = @"id";
NSString *const kYSiteName = @"name";
NSString *const kYSiteSiteUrl = @"siteUrl";
NSString *const kYSiteRating = @"rating";


@interface YSite ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YSite

@synthesize logoUrl = _logoUrl;
@synthesize siteIdentifier = _siteIdentifier;
@synthesize name = _name;
@synthesize siteUrl = _siteUrl;
@synthesize rating = _rating;


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
            self.logoUrl = [self objectOrNilForKey:kYSiteLogoUrl fromDictionary:dict];
            self.siteIdentifier = [[self objectOrNilForKey:kYSiteId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kYSiteName fromDictionary:dict];
            self.siteUrl = [self objectOrNilForKey:kYSiteSiteUrl fromDictionary:dict];
            self.rating = [[self objectOrNilForKey:kYSiteRating fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.logoUrl forKey:kYSiteLogoUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.siteIdentifier] forKey:kYSiteId];
    [mutableDict setValue:self.name forKey:kYSiteName];
    [mutableDict setValue:self.siteUrl forKey:kYSiteSiteUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.rating] forKey:kYSiteRating];

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

    self.logoUrl = [aDecoder decodeObjectForKey:kYSiteLogoUrl];
    self.siteIdentifier = [aDecoder decodeDoubleForKey:kYSiteId];
    self.name = [aDecoder decodeObjectForKey:kYSiteName];
    self.siteUrl = [aDecoder decodeObjectForKey:kYSiteSiteUrl];
    self.rating = [aDecoder decodeDoubleForKey:kYSiteRating];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_logoUrl forKey:kYSiteLogoUrl];
    [aCoder encodeDouble:_siteIdentifier forKey:kYSiteId];
    [aCoder encodeObject:_name forKey:kYSiteName];
    [aCoder encodeObject:_siteUrl forKey:kYSiteSiteUrl];
    [aCoder encodeDouble:_rating forKey:kYSiteRating];
}

- (id)copyWithZone:(NSZone *)zone
{
    YSite *copy = [[YSite alloc] init];
    
    if (copy) {

        copy.logoUrl = [self.logoUrl copyWithZone:zone];
        copy.siteIdentifier = self.siteIdentifier;
        copy.name = [self.name copyWithZone:zone];
        copy.siteUrl = [self.siteUrl copyWithZone:zone];
        copy.rating = self.rating;
    }
    
    return copy;
}


@end
