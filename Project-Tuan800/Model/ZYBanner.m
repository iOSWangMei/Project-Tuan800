//
//  ZYBanner.m
//
//  Created by mac  on 16/6/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ZYBanner.h"


NSString *const kZYBannerTimeout = @"timeout";
NSString *const kZYBannerData = @"data";
NSString *const kZYBannerId = @"id";
NSString *const kZYBannerTitle = @"title";
NSString *const kZYBannerSmallListImage = @"small_list_image";
NSString *const kZYBannerMessage = @"message";
NSString *const kZYBannerLargeDetailImage = @"large_detail_image";
NSString *const kZYBannerType = @"type";
NSString *const kZYBannerLargeListImage = @"large_list_image";
NSString *const kZYBannerSmallDetailImage = @"small_detail_image";
NSString *const kZYBannerSay = @"say";


@interface ZYBanner ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZYBanner

@synthesize timeout = _timeout;
@synthesize data = _data;
@synthesize bannerIdentifier = _bannerIdentifier;
@synthesize title = _title;
@synthesize smallListImage = _smallListImage;
@synthesize message = _message;
@synthesize largeDetailImage = _largeDetailImage;
@synthesize type = _type;
@synthesize largeListImage = _largeListImage;
@synthesize smallDetailImage = _smallDetailImage;
@synthesize say = _say;


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
            self.timeout = [[self objectOrNilForKey:kZYBannerTimeout fromDictionary:dict] doubleValue];
            self.data = [self objectOrNilForKey:kZYBannerData fromDictionary:dict];
            self.bannerIdentifier = [self objectOrNilForKey:kZYBannerId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kZYBannerTitle fromDictionary:dict];
            self.smallListImage = [self objectOrNilForKey:kZYBannerSmallListImage fromDictionary:dict];
            self.message = [self objectOrNilForKey:kZYBannerMessage fromDictionary:dict];
            self.largeDetailImage = [self objectOrNilForKey:kZYBannerLargeDetailImage fromDictionary:dict];
            self.type = [self objectOrNilForKey:kZYBannerType fromDictionary:dict];
            self.largeListImage = [self objectOrNilForKey:kZYBannerLargeListImage fromDictionary:dict];
            self.smallDetailImage = [self objectOrNilForKey:kZYBannerSmallDetailImage fromDictionary:dict];
            self.say = [self objectOrNilForKey:kZYBannerSay fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.timeout] forKey:kZYBannerTimeout];
    [mutableDict setValue:self.data forKey:kZYBannerData];
    [mutableDict setValue:self.bannerIdentifier forKey:kZYBannerId];
    [mutableDict setValue:self.title forKey:kZYBannerTitle];
    [mutableDict setValue:self.smallListImage forKey:kZYBannerSmallListImage];
    [mutableDict setValue:self.message forKey:kZYBannerMessage];
    [mutableDict setValue:self.largeDetailImage forKey:kZYBannerLargeDetailImage];
    [mutableDict setValue:self.type forKey:kZYBannerType];
    [mutableDict setValue:self.largeListImage forKey:kZYBannerLargeListImage];
    [mutableDict setValue:self.smallDetailImage forKey:kZYBannerSmallDetailImage];
    [mutableDict setValue:self.say forKey:kZYBannerSay];

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

    self.timeout = [aDecoder decodeDoubleForKey:kZYBannerTimeout];
    self.data = [aDecoder decodeObjectForKey:kZYBannerData];
    self.bannerIdentifier = [aDecoder decodeObjectForKey:kZYBannerId];
    self.title = [aDecoder decodeObjectForKey:kZYBannerTitle];
    self.smallListImage = [aDecoder decodeObjectForKey:kZYBannerSmallListImage];
    self.message = [aDecoder decodeObjectForKey:kZYBannerMessage];
    self.largeDetailImage = [aDecoder decodeObjectForKey:kZYBannerLargeDetailImage];
    self.type = [aDecoder decodeObjectForKey:kZYBannerType];
    self.largeListImage = [aDecoder decodeObjectForKey:kZYBannerLargeListImage];
    self.smallDetailImage = [aDecoder decodeObjectForKey:kZYBannerSmallDetailImage];
    self.say = [aDecoder decodeObjectForKey:kZYBannerSay];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_timeout forKey:kZYBannerTimeout];
    [aCoder encodeObject:_data forKey:kZYBannerData];
    [aCoder encodeObject:_bannerIdentifier forKey:kZYBannerId];
    [aCoder encodeObject:_title forKey:kZYBannerTitle];
    [aCoder encodeObject:_smallListImage forKey:kZYBannerSmallListImage];
    [aCoder encodeObject:_message forKey:kZYBannerMessage];
    [aCoder encodeObject:_largeDetailImage forKey:kZYBannerLargeDetailImage];
    [aCoder encodeObject:_type forKey:kZYBannerType];
    [aCoder encodeObject:_largeListImage forKey:kZYBannerLargeListImage];
    [aCoder encodeObject:_smallDetailImage forKey:kZYBannerSmallDetailImage];
    [aCoder encodeObject:_say forKey:kZYBannerSay];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZYBanner *copy = [[ZYBanner alloc] init];
    
    if (copy) {

        copy.timeout = self.timeout;
        copy.data = [self.data copyWithZone:zone];
        copy.bannerIdentifier = [self.bannerIdentifier copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.smallListImage = [self.smallListImage copyWithZone:zone];
        copy.message = [self.message copyWithZone:zone];
        copy.largeDetailImage = [self.largeDetailImage copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.largeListImage = [self.largeListImage copyWithZone:zone];
        copy.smallDetailImage = [self.smallDetailImage copyWithZone:zone];
        copy.say = [self.say copyWithZone:zone];
    }
    
    return copy;
}


@end
