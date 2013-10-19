//
//  LinkToMyApp.h
//  linktomyapp-iOS
//
//  Created by Thibaut LE LEVIER on 19/10/2013.
//  Copyright (c) 2013 Thibaut LE LEVIER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkToMyApp : NSObject

@property (strong, nonatomic) NSURL *baseURL;
@property (strong, nonatomic) NSString *appID;

+(LinkToMyApp *)startLinkerOnEndpoint:(NSURL *)baseURL andAppID:(NSString *)appID;
+(LinkToMyApp *)linker;

-(void)notifyInstall;
-(BOOL)shouldNotifyInstall;

-(NSString *)installServerID;

-(void)notifyServerForEvent:(NSString *)event withInfos:(NSDictionary *)metaInfos;

+(NSData*)encodeDictionary:(NSDictionary*)dictionary;

@end
