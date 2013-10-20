//
//  LinkToMyApp.m
//  linktomyapp-iOS
//
//  Created by Thibaut LE LEVIER on 19/10/2013.
//  Copyright (c) 2013 Thibaut LE LEVIER. All rights reserved.
//

#import "LinkToMyApp.h"

#import <AdSupport/AdSupport.h>

#define LINK_CLICK_ID @"link_click_id"

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
    NSURL *installURL = [self.baseURL URLByAppendingPathComponent:@"/api/app_links/app_installed"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:installURL];
    
    [request setHTTPMethod:@"POST"];
    
    NSDictionary *dataDictionary = @{@"app_id": self.appID,
                                     @"udid": [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]};
    
    [request setHTTPBody:[LinkToMyApp encodeDictionary:dataDictionary]];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               if (connectionError || [(NSHTTPURLResponse *)response statusCode] >= 400)
                               {
                                   return;
                               }
                               else
                               {
                                   
                                   id json = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:NSJSONReadingAllowFragments
                                                                               error:nil];
                                   
                                   [[NSUserDefaults standardUserDefaults] setValue:[json valueForKey:@"link_click_id"] forKey:LINK_CLICK_ID];
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
    return [[NSUserDefaults standardUserDefaults] stringForKey:LINK_CLICK_ID];
}

-(void)notifyServerForEvent:(NSString *)event withInfos:(NSDictionary *)metaInfos
{
    if (![self installServerID])
        return;
    
    NSLog(@"_notify event: %@ with infos: %@", event, metaInfos);
    
    NSURL *eventURL = [self.baseURL URLByAppendingPathComponent:@"/api/app_links/event"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:eventURL];
    
    [request setHTTPMethod:@"POST"];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:metaInfos];
    [dictionary setValue:[self installServerID] forKey:@"link_click_id"];
    [dictionary setValue:event forKey:@"event"];
    [dictionary setValue:self.appID forKey:@"app_id"];
    [dictionary setValue:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] forKey:@"udid"];
    
    [request setHTTPBody:[LinkToMyApp encodeDictionary:dictionary]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               if (!connectionError)
                               {
                                   // success
                               }
                               
                               
                           }];
}

#pragma mark utils
+(NSData*)encodeDictionary:(NSDictionary*)dictionary
{
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}

@end
