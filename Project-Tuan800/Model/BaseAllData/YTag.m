//
//  YTag.m
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "YTag.h"


NSString *const kYTagId = @"id";
NSString *const kYTagName = @"name";


@interface YTag ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YTag

@synthesize tagIdentifier = _tagIdentifier;
@synthesize name = _name;


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
            self.tagIdentifier = [[self objectOrNilForKey:kYTagId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kYTagName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tagIdentifier] forKey:kYTagId];
    [mutableDict setValue:self.name forKey:kYTagName];

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

    self.tagIdentifier = [aDecoder decodeDoubleForKey:kYTagId];
    self.name = [aDecoder decodeObjectForKey:kYTagName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_tagIdentifier forKey:kYTagId];
    [aCoder encodeObject:_name forKey:kYTagName];
}

- (id)copyWithZone:(NSZone *)zone
{
    YTag *copy = [[YTag alloc] init];
    
    if (copy) {

        copy.tagIdentifier = self.tagIdentifier;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
