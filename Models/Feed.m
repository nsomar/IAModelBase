//
//  Feed.m
//  RKTestApp
//
//  Created by Omar on 10/6/12.
//  Copyright (c) 2012 InfusionApps. All rights reserved.
//

#import "Feed.h"

@implementation Feed

- (NSDictionary *)propertiesToDictionaryEntriesMapping
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"mediaXMLNS", @"xmlns$media", //correct name, name in dic
            @"links", @"link", //correct name, name in dic
            nil];
}

@end
