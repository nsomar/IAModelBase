//
//  ViewController.m
//  RKTestApp
//
//  Created by Omar on 8/25/12.
//  Copyright (c) 2012 InfusionApps. All rights reserved.
//

#import "ViewController.h"

#import "JSON.h"
#import "MostPopular.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:@"http://gdata.youtube.com/feeds/api/standardfeeds/most_popular?v=2&alt=json"];
    
    NSString *str = [NSString stringWithContentsOfURL:url
                                             encoding:NSUTF8StringEncoding
                                                error:NULL];
    
    NSDictionary *dic = [str JSONValue];
    
    MostPopular *mostPopular = [[MostPopular alloc] initWithDictionary:dic];
}

@end
