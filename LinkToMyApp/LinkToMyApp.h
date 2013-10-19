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

-(id)initWithBaseURL:(NSURL *)url;

+(LinkToMyApp *)startLinkerOnEndpoint:(NSURL *)baseURL;
+(LinkToMyApp *)linker;

-(void)notifyServer;

@end
