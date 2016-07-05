//
//  YLinks.m
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "YLinks.h"


NSString *const kYLinksSelf = @"self";
NSString *const kYLinksLast = @"last";
NSString *const kYLinksNext = @"next";


@interface YLinks ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YLinks

@synthesize linksSelf = _linksSelf;
@synthesize last = _last;
@synthesize next = _next;


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
            self.linksSelf = [self objectOrNilForKey:kYLinksSelf fromDictionary:dict];
            self.last = [self objectOrNilForKey:kYLinksLast fromDictionary:dict];
            self.next = [self objectOrNilForKey:kYLinksNext fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.linksSelf forKey:kYLinksSelf];
    [mutableDict setValue:self.last forKey:kYLinksLast];
    [mutableDict setValue:self.next forKey:kYLinksNext];

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

    self.linksSelf = [aDecoder decodeObjectForKey:kYLinksSelf];
    self.last = [aDecoder decodeObjectForKey:kYLinksLast];
    self.next = [aDecoder decodeObjectForKey:kYLinksNext];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_linksSelf forKey:kYLinksSelf];
    [aCoder encodeObject:_last forKey:kYLinksLast];
    [aCoder encodeObject:_next forKey:kYLinksNext];
}

- (id)copyWithZone:(NSZone *)zone
{
    YLinks *copy = [[YLinks alloc] init];
    
    if (copy) {

        copy.linksSelf = [self.linksSelf copyWithZone:zone];
        copy.last = [self.last copyWithZone:zone];
        copy.next = [self.next copyWithZone:zone];
    }
    
    return copy;
}


@end
