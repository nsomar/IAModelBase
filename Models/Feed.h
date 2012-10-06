//
//  Feed.h
//  RKTestApp
//
//  Created by Omar on 10/6/12.
//  Copyright (c) 2012 InfusionApps. All rights reserved.
//

#import "IAModelBase.h"

@interface Feed : IAModelBase

@property (nonatomic, strong) NSString *xmlns$app;
@property (nonatomic, strong) NSString *xmlns;
@property (nonatomic, strong) NSString *mediaXMLNS;

@property (nonatomic, strong) NSArray *links;
//The name of the property is important it will be matched using introspection
//to find the correct class that will hold the items of this array

//@property (nonatomic, retain) NSArray *linkCollection;
//@property (nonatomic, retain) NSArray *linkArray;

@end
