//
//  ZYBaseModel.m
//
//  Created by mac  on 16/6/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ZYBaseModel.h"
#import "ZYBanner.h"


NSString *const kZYBaseModelBanner = @"banner";


@interface ZYBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZYBaseModel

@synthesize banner = _banner;


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
    NSObject *receivedZYBanner = [dict objectForKey:kZYBaseModelBanner];
    NSMutableArray *parsedZYBanner = [NSMutableArray array];
    if ([receivedZYBanner isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZYBanner) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZYBanner addObject:[ZYBanner modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZYBanner isKindOfClass:[NSDictionary class]]) {
       [parsedZYBanner addObject:[ZYBanner modelObjectWithDictionary:(NSDictionary *)receivedZYBanner]];
    }

    self.banner = [NSArray arrayWithArray:parsedZYBanner];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForBanner = [NSMutableArray array];
    for (NSObject *subArrayObject in self.banner) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBanner addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBanner addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBanner] forKey:kZYBaseModelBanner];

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

    self.banner = [aDecoder decodeObjectForKey:kZYBaseModelBanner];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_banner forKey:kZYBaseModelBanner];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZYBaseModel *copy = [[ZYBaseModel alloc] init];
    
    if (copy) {

        copy.banner = [self.banner copyWithZone:zone];
    }
    
    return copy;
}


@end
