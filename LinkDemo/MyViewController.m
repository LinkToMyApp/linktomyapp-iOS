//
//  MyViewController.m
//  linktomyapp-iOS
//
//  Created by Thibaut LE LEVIER on 19/10/2013.
//  Copyright (c) 2013 Thibaut LE LEVIER. All rights reserved.
//

#import "MyViewController.h"

#import "LinkToMyApp.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(IBAction)createAccountAction:(id)sender
{
    [[LinkToMyApp linker] notifyServerForEvent:@"create_account" withInfos:@{@"username" : @"John"}];
}

-(IBAction)purchaseAction:(id)sender
{
    [[LinkToMyApp linker] notifyServerForEvent:@"purchase_inapp" withInfos:@{@"credits" : @500}];
}

@end
