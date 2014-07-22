//
//  ModelCollectionBaseClass.h
//  RKTestApp
//
//  Created by Omar on 8/25/12.
//  Copyright (c) 2012 InfusionApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAModelBase.h"

@interface IAModelCollectionBase : NSObject

- (Class) classForModelBase;

- (NSUInteger) count;
- (void) addEntry:(IAModelBase*) entry;
- (IAModelBase*) entryAtIndex:(int)index;
@end
