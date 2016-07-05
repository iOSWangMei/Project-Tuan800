//
//  YDeal.m
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "YDeal.h"
#import "YSite.h"


NSString *const kYDealId = @"id";
NSString *const kYDealDiscount = @"discount";
NSString *const kYDealSalesVolume = @"salesVolume";
NSString *const kYDealImgBig = @"imgBig";
NSString *const kYDealAppointment = @"appointment";
NSString *const kYDealSoldOut = @"soldOut";
NSString *const kYDealListPrice = @"listPrice";
NSString *const kYDealImgSmall = @"imgSmall";
NSString *const kYDealTitle = @"title";
NSString *const kYDealPrice = @"price";
NSString *const kYDealScoreRating = @"scoreRating";
NSString *const kYDealCanBuy = @"canBuy";
NSString *const kYDealCommentsCount = @"commentsCount";
NSString *const kYDealExpireDate = @"expireDate";
NSString *const kYDealCloseTime = @"closeTime";
NSString *const kYDealSite = @"site";
NSString *const kYDealImgNormal = @"imgNormal";


@interface YDeal ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YDeal

@synthesize dealIdentifier = _dealIdentifier;
@synthesize discount = _discount;
@synthesize salesVolume = _salesVolume;
@synthesize imgBig = _imgBig;
@synthesize appointment = _appointment;
@synthesize soldOut = _soldOut;
@synthesize listPrice = _listPrice;
@synthesize imgSmall = _imgSmall;
@synthesize title = _title;
@synthesize price = _price;
@synthesize scoreRating = _scoreRating;
@synthesize canBuy = _canBuy;
@synthesize commentsCount = _commentsCount;
@synthesize expireDate = _expireDate;
@synthesize closeTime = _closeTime;
@synthesize site = _site;
@synthesize imgNormal = _imgNormal;


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
            self.dealIdentifier = [[self objectOrNilForKey:kYDealId fromDictionary:dict] doubleValue];
            self.discount = [self objectOrNilForKey:kYDealDiscount fromDictionary:dict];
            self.salesVolume = [[self objectOrNilForKey:kYDealSalesVolume fromDictionary:dict] doubleValue];
            self.imgBig = [self objectOrNilForKey:kYDealImgBig fromDictionary:dict];
            self.appointment = [[self objectOrNilForKey:kYDealAppointment fromDictionary:dict] boolValue];
            self.soldOut = [[self objectOrNilForKey:kYDealSoldOut fromDictionary:dict] boolValue];
            self.listPrice = [[self objectOrNilForKey:kYDealListPrice fromDictionary:dict] doubleValue];
            self.imgSmall = [self objectOrNilForKey:kYDealImgSmall fromDictionary:dict];
            self.title = [self objectOrNilForKey:kYDealTitle fromDictionary:dict];
            self.price = [[self objectOrNilForKey:kYDealPrice fromDictionary:dict] doubleValue];
            self.scoreRating = [[self objectOrNilForKey:kYDealScoreRating fromDictionary:dict] doubleValue];
            self.canBuy = [[self objectOrNilForKey:kYDealCanBuy fromDictionary:dict] doubleValue];
            self.commentsCount = [[self objectOrNilForKey:kYDealCommentsCount fromDictionary:dict] doubleValue];
            self.expireDate = [self objectOrNilForKey:kYDealExpireDate fromDictionary:dict];
            self.closeTime = [self objectOrNilForKey:kYDealCloseTime fromDictionary:dict];
            self.site = [YSite modelObjectWithDictionary:[dict objectForKey:kYDealSite]];
            self.imgNormal = [self objectOrNilForKey:kYDealImgNormal fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dealIdentifier] forKey:kYDealId];
    [mutableDict setValue:self.discount forKey:kYDealDiscount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.salesVolume] forKey:kYDealSalesVolume];
    [mutableDict setValue:self.imgBig forKey:kYDealImgBig];
    [mutableDict setValue:[NSNumber numberWithBool:self.appointment] forKey:kYDealAppointment];
    [mutableDict setValue:[NSNumber numberWithBool:self.soldOut] forKey:kYDealSoldOut];
    [mutableDict setValue:[NSNumber numberWithDouble:self.listPrice] forKey:kYDealListPrice];
    [mutableDict setValue:self.imgSmall forKey:kYDealImgSmall];
    [mutableDict setValue:self.title forKey:kYDealTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kYDealPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.scoreRating] forKey:kYDealScoreRating];
    [mutableDict setValue:[NSNumber numberWithDouble:self.canBuy] forKey:kYDealCanBuy];
    [mutableDict setValue:[NSNumber numberWithDouble:self.commentsCount] forKey:kYDealCommentsCount];
    [mutableDict setValue:self.expireDate forKey:kYDealExpireDate];
    [mutableDict setValue:self.closeTime forKey:kYDealCloseTime];
    [mutableDict setValue:[self.site dictionaryRepresentation] forKey:kYDealSite];
    [mutableDict setValue:self.imgNormal forKey:kYDealImgNormal];

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

    self.dealIdentifier = [aDecoder decodeDoubleForKey:kYDealId];
    self.discount = [aDecoder decodeObjectForKey:kYDealDiscount];
    self.salesVolume = [aDecoder decodeDoubleForKey:kYDealSalesVolume];
    self.imgBig = [aDecoder decodeObjectForKey:kYDealImgBig];
    self.appointment = [aDecoder decodeBoolForKey:kYDealAppointment];
    self.soldOut = [aDecoder decodeBoolForKey:kYDealSoldOut];
    self.listPrice = [aDecoder decodeDoubleForKey:kYDealListPrice];
    self.imgSmall = [aDecoder decodeObjectForKey:kYDealImgSmall];
    self.title = [aDecoder decodeObjectForKey:kYDealTitle];
    self.price = [aDecoder decodeDoubleForKey:kYDealPrice];
    self.scoreRating = [aDecoder decodeDoubleForKey:kYDealScoreRating];
    self.canBuy = [aDecoder decodeDoubleForKey:kYDealCanBuy];
    self.commentsCount = [aDecoder decodeDoubleForKey:kYDealCommentsCount];
    self.expireDate = [aDecoder decodeObjectForKey:kYDealExpireDate];
    self.closeTime = [aDecoder decodeObjectForKey:kYDealCloseTime];
    self.site = [aDecoder decodeObjectForKey:kYDealSite];
    self.imgNormal = [aDecoder decodeObjectForKey:kYDealImgNormal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_dealIdentifier forKey:kYDealId];
    [aCoder encodeObject:_discount forKey:kYDealDiscount];
    [aCoder encodeDouble:_salesVolume forKey:kYDealSalesVolume];
    [aCoder encodeObject:_imgBig forKey:kYDealImgBig];
    [aCoder encodeBool:_appointment forKey:kYDealAppointment];
    [aCoder encodeBool:_soldOut forKey:kYDealSoldOut];
    [aCoder encodeDouble:_listPrice forKey:kYDealListPrice];
    [aCoder encodeObject:_imgSmall forKey:kYDealImgSmall];
    [aCoder encodeObject:_title forKey:kYDealTitle];
    [aCoder encodeDouble:_price forKey:kYDealPrice];
    [aCoder encodeDouble:_scoreRating forKey:kYDealScoreRating];
    [aCoder encodeDouble:_canBuy forKey:kYDealCanBuy];
    [aCoder encodeDouble:_commentsCount forKey:kYDealCommentsCount];
    [aCoder encodeObject:_expireDate forKey:kYDealExpireDate];
    [aCoder encodeObject:_closeTime forKey:kYDealCloseTime];
    [aCoder encodeObject:_site forKey:kYDealSite];
    [aCoder encodeObject:_imgNormal forKey:kYDealImgNormal];
}

- (id)copyWithZone:(NSZone *)zone
{
    YDeal *copy = [[YDeal alloc] init];
    
    if (copy) {

        copy.dealIdentifier = self.dealIdentifier;
        copy.discount = [self.discount copyWithZone:zone];
        copy.salesVolume = self.salesVolume;
        copy.imgBig = [self.imgBig copyWithZone:zone];
        copy.appointment = self.appointment;
        copy.soldOut = self.soldOut;
        copy.listPrice = self.listPrice;
        copy.imgSmall = [self.imgSmall copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.price = self.price;
        copy.scoreRating = self.scoreRating;
        copy.canBuy = self.canBuy;
        copy.commentsCount = self.commentsCount;
        copy.expireDate = [self.expireDate copyWithZone:zone];
        copy.closeTime = [self.closeTime copyWithZone:zone];
        copy.site = [self.site copyWithZone:zone];
        copy.imgNormal = [self.imgNormal copyWithZone:zone];
    }
    
    return copy;
}


@end
