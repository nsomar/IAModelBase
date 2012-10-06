//
//  Link.h
//  RKTestApp
//
//  Created by Omar on 10/6/12.
//  Copyright (c) 2012 InfusionApps. All rights reserved.
//

#import "IAModelBase.h"

@interface Link : IAModelBase

@property (nonatomic, strong) NSString *rel;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *href;

@end
