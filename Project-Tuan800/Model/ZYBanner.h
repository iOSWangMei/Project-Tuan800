//
//  ZYBanner.h
//
//  Created by mac  on 16/6/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZYBanner : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double timeout;
@property (nonatomic, strong) NSString *data;
@property (nonatomic, strong) NSString *bannerIdentifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *smallListImage;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *largeDetailImage;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *largeListImage;
@property (nonatomic, strong) NSString *smallDetailImage;
@property (nonatomic, strong) NSString *say;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
