//
//  LinkToMyApp.m
//  linktomyapp-iOS
//
//  Created by Thibaut LE LEVIER on 19/10/2013.
//  Copyright (c) 2013 Thibaut LE LEVIER. All rights reserved.
//

#import "LinkToMyApp.h"

#define INSTAL_SERVER_ID @"install_server_id"

@implementation LinkToMyApp

static LinkToMyApp *_linker;

+(LinkToMyApp *)startLinkerOnEndpoint:(NSURL *)baseURL andAppID:(NSString *)appID
{
    if (!baseURL)
    {
        NSLog(@"ERROR: SERVER URL NOT SET");
        return nil;
    }
    
    if (!appID)
    {
        NSLog(@"ERROR: APP ID NOT SET");
        return nil;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _linker = [[LinkToMyApp alloc] init];
        _linker.baseURL = baseURL;
        _linker.appID = appID;
        
        if ([_linker shouldNotifyInstall])
            [_linker notifyInstall];
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
    
    if (!_linker.appID)
    {
        NSLog(@"ERROR: APP ID NOT SET");
        return nil;
    }
    
    return _linker;
}

-(void)notifyInstall
{
    NSLog(@"_notifyInstall");
    NSURL *installURL = [self.baseURL URLByAppendingPathComponent:@"/"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:installURL];
    
    [request setHTTPMethod:@"POST"];
    
//    [request setHTTPBody:<#(NSData *)#>]
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:installURL]
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               if (!connectionError)
                               {
                                   [[NSUserDefaults standardUserDefaults] setValue:@"id1234" forKey:INSTAL_SERVER_ID];
                                   [[NSUserDefaults standardUserDefaults] synchronize];
                               }
                               
                               
                           }];
}

-(BOOL)shouldNotifyInstall
{
    return ![self installServerID];
}

-(NSString *)installServerID
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:INSTAL_SERVER_ID];
}

-(void)notifyServerForEvent:(NSString *)event withInfos:(NSDictionary *)metaInfos
{
    NSLog(@"_notify event: %@ with infos: %@", event, metaInfos);
    
    NSURL *installURL = [self.baseURL URLByAppendingPathComponent:@"/"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:installURL];
    
    [request setHTTPMethod:@"POST"];
    
    //    [request setHTTPBody:<#(NSData *)#>]
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:installURL]
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               if (!connectionError)
                               {
                                   // success
                               }
                               
                               
                           }];
}

@end
