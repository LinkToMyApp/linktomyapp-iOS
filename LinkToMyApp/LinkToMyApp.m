//
//  LinkToMyApp.m
//  linktomyapp-iOS
//
//  Created by Thibaut LE LEVIER on 19/10/2013.
//  Copyright (c) 2013 Thibaut LE LEVIER. All rights reserved.
//

#import "LinkToMyApp.h"

@implementation LinkToMyApp

static LinkToMyApp *_linker;

-(id)initWithBaseURL:(NSURL *)url
{
    self = [super init];
    if (self)
    {
        _baseURL = url;
    }
    return self;
}

+(LinkToMyApp *)startLinkerOnEndpoint:(NSURL *)baseURL
{
    if (!baseURL)
        return nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _linker = [[LinkToMyApp alloc] initWithBaseURL:baseURL];
    });

    return _linker;
}

+(LinkToMyApp *)linker
{
    if (!_linker.baseURL)
    {
        NSLog(@"ERROR: SERVER URL NOT SET");
        return nil;
    }
    
    return _linker;
}

-(void)notifyServer
{
    
}

@end
