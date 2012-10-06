//
//  ModelBaseClass.h
//  RKTestApp
//
//  Created by Omar on 8/25/12.
//  Copyright (c) 2012 InfusionApps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CollectionSuffiex @[@"Array", @"Items", @"List", @"Collection"];

@interface IAModelBase : NSObject

- (NSDictionary*) propertiesToDictionaryEntriesMapping;
- (NSDictionary *)classesForArrayEntries;

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
