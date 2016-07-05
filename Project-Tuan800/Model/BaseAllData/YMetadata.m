//
//  YMetadata.m
//
//  Created by mac  on 16/7/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "YMetadata.h"
#import "YLinks.h"


NSString *const kYMetadataLinks = @"links";
NSString *const kYMetadataTotalPages = @"totalPages";
NSString *const kYMetadataCurrentPage = @"currentPage";


@interface YMetadata ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YMetadata

@synthesize links = _links;
@synthesize totalPages = _totalPages;
@synthesize currentPage = _currentPage;


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
            self.links = [YLinks modelObjectWithDictionary:[dict objectForKey:kYMetadataLinks]];
            self.totalPages = [[self objectOrNilForKey:kYMetadataTotalPages fromDictionary:dict] doubleValue];
            self.currentPage = [[self objectOrNilForKey:kYMetadataCurrentPage fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.links dictionaryRepresentation] forKey:kYMetadataLinks];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalPages] forKey:kYMetadataTotalPages];
    [mutableDict setValue:[NSNumber numberWithDouble:self.currentPage] forKey:kYMetadataCurrentPage];

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

    self.links = [aDecoder decodeObjectForKey:kYMetadataLinks];
    self.totalPages = [aDecoder decodeDoubleForKey:kYMetadataTotalPages];
    self.currentPage = [aDecoder decodeDoubleForKey:kYMetadataCurrentPage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_links forKey:kYMetadataLinks];
    [aCoder encodeDouble:_totalPages forKey:kYMetadataTotalPages];
    [aCoder encodeDouble:_currentPage forKey:kYMetadataCurrentPage];
}

- (id)copyWithZone:(NSZone *)zone
{
    YMetadata *copy = [[YMetadata alloc] init];
    
    if (copy) {

        copy.links = [self.links copyWithZone:zone];
        copy.totalPages = self.totalPages;
        copy.currentPage = self.currentPage;
    }
    
    return copy;
}


@end
