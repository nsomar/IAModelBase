//
//  MostPopular.h
//  RKTestApp
//
//  Created by Omar on 10/6/12.
//  Copyright (c) 2012 InfusionApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAModelBase.h"
#import "Feed.h"

@interface MostPopular : IAModelBase

@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *encoding;
@property (nonatomic, strong) Feed *feed;

@end
