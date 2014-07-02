//
//  ModelBaseClass.m
//  RKTestApp
//
//  Created by Omar on 8/25/12.
//  Copyright (c) 2012 InfusionApps. All rights reserved.
//

#import "IAModelBase.h"
#import <objc/runtime.h>

@interface IAModelBase ()
@property (nonatomic, strong) NSDictionary *dictionaryOfKeysToKeys;
@property (nonatomic, strong) NSDictionary *dictionaryOfKeysClasses;
@end

@implementation IAModelBase
@synthesize dictionaryOfKeysToKeys;
@synthesize dictionaryOfKeysClasses;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    NSString *realKey = [dictionaryOfKeysToKeys valueForKey:key];
    
    if (!realKey)
        realKey = key;
    
    if([self isArrayOrDictionary:value])
    {
        [self setValue:value forModelKey:realKey];
    }
    else
    {
        [super setValue:value forKey:realKey];
    }
}

- (BOOL) isArrayOrDictionary:(id)value
{
    return [value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]];
}

- (Class) classForKey:(NSString*) key
{
    Class objectClass = [self class];
    NSString * accessorKey = key;
    
    objc_property_t theProperty =
    class_getProperty(objectClass, [accessorKey UTF8String]);
    
    if(!theProperty)
        return nil;
    
    const char * propertyAttrs = property_getAttributes(theProperty);
    NSString *propertyString = [NSString stringWithUTF8String:propertyAttrs];
    
    NSString *startingString = @"T@\"";
    NSString *endingString = @"\",";
    
    int startingIndex = [propertyString rangeOfString:startingString].location +
    startingString.length;
    
    NSString *propType = [propertyString substringFromIndex:startingIndex];

    int endingIndex = [propType rangeOfString:endingString].location;
    
    propType = [propType substringToIndex:endingIndex];
    
    Class propClass = NSClassFromString(propType);
    
    return propClass;
}

- (void) setValue:(id)value forModelKey:(NSString *)key
{
    Class cls = [self classForKey:key];
    
    BOOL isArray = [cls instancesRespondToSelector:@selector(initWithObjects:)];

    if (isArray)
    {
        BOOL isModelArray = [cls instancesRespondToSelector:@selector(classForModelBase)];

        if (isModelArray)
        {
            id object = [[cls alloc] initWithArray:value];
            [super setValue:object forKey:key];
        }
        else
        {
            Class arrayElementClass = [self classForKeyInCollection:key];
            if (arrayElementClass)
                [self fillArrayWithArray:value
                                  forKey:key
                          withEntryClass:arrayElementClass];
            else
                [super setValue:value forKey:key];
        }
    }
    else //Dictionary
    {
        BOOL isModel = [cls instancesRespondToSelector:@selector(classForKeyInCollection:)];
        if (isModel)
            [self fillObjectWithDictionary:value
                                    forKey:key
                            withEntryClass:cls];
        else
            [super setValue:value forKey:key];
    }

}

- (void) fillObjectWithDictionary:(NSDictionary*)dic
                           forKey:(NSString*)key
                   withEntryClass:(Class) class
{
    id modelObject = [[class alloc] initWithDictionary:dic];
    [super setValue:modelObject forKey:key];
}

- (void) fillArrayWithArray:(NSArray*) array
                     forKey:(NSString*)key
             withEntryClass:(Class) class
{
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    if ([array isKindOfClass:[NSDictionary class]]) {
        id entry = [[class alloc] initWithDictionary:(NSDictionary *)array];
        [retArray addObject:entry];
    } else
    for (id arrayEntry in array) {
        id entry = [[class alloc] initWithDictionary:arrayEntry];
        [retArray addObject:entry];
    }
    
    [super setValue:retArray forKey:key];
}

- (Class) classForKeyInCollection:(NSString*) key
{
    NSString *className = [dictionaryOfKeysClasses objectForKey:key];
    
    if(!className)
    {
        return [self classForKeyByProcessingName:key];
    }
    else
    {
        return NSClassFromString(className);
    }
    
    return nil;
}

- (Class) classForKeyByProcessingName:(NSString*) key
{
    NSArray *suffixes = CollectionSuffiex;
    NSString *keyWithNoSuffix = nil;
    
    if (key) {
        for (NSString *suffix in suffixes)
        {
            if ([key hasSuffix:suffix])
            {
                keyWithNoSuffix = [self keyNameByRemovingSuffixOrNil:key
                                                              suffix:suffix];
                break;
            }
        }
    }
    
    if (!keyWithNoSuffix) {
        keyWithNoSuffix = [self keyByRemovingFinalSuffixOrNil:key];
    }
    // this will change the class name to lowercase
    // if the class has more uppercase characters this function will occer a bug
//    if (keyWithNoSuffix) {
//        keyWithNoSuffix = [keyWithNoSuffix capitalizedString];
//    }
    
    return NSClassFromString(keyWithNoSuffix);
}

- (NSString *) keyNameByRemovingSuffixOrNil:(NSString *)key
                                     suffix:(NSString*) suffix
{
    int location = key.length - suffix.length;
    NSString *keyWithNoSuffix = [key substringToIndex:location];
    
    
    return keyWithNoSuffix;
}

- (NSString *) keyByRemovingFinalSuffixOrNil:(NSString *)key
{
    NSString *finalSuffix = [key substringFromIndex:key.length - 1];
    NSString *keyWithNoSuffix = nil;
    
    if ([finalSuffix isEqualToString:@"s"]) {
        keyWithNoSuffix = [key substringToIndex:key.length - 1];
    }
    
    return keyWithNoSuffix;
}

- (id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    
    if (self) {
        self.dictionaryOfKeysToKeys = [self propertiesToDictionaryEntriesMapping];
        self.dictionaryOfKeysClasses = [self classesForArrayEntries];
    
        [self setValuesForKeysWithDictionary:dictionary];
    }
    
    return self;
}

- (NSDictionary*) propertiesToDictionaryEntriesMapping
{
    /*
     //create a dictionary that maps the correct property name
     //with the parameter name returned form json
     
     //<object of the retruned dictionary>
     //staffID = is the correct name of the property
     
     //<key of the retruned dictionary>
     //id = is the name of the key in the dictionary that you want to map
     
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"staffID",
            @"id",
            nil];
     */
    
    return nil;
}

- (NSDictionary *)classesForArrayEntries
{
    /*
     //Since objective c does not have strongly templated collections
     //This is a work around to template a collection
     //You will have to retrun a dictionary that has the following
     
     //<object of the retruned dictionary>
     //Experience = the name of the class for the selected property
     
     //<key of the retruned dictionary>
     //experiences = name of the property
     
     //the property will be like
     //@property NSArray *experiences;
     
     //using ModelBaseClass experiences will contain an array of 
     //Experience objects
     
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"Experience",
            @"experiences",
            nil];
     */
    return nil;
}

@end
