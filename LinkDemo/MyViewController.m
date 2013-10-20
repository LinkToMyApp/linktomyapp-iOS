//
//  MyViewController.m
//  linktomyapp-iOS
//
//  Created by Thibaut LE LEVIER on 19/10/2013.
//  Copyright (c) 2013 Thibaut LE LEVIER. All rights reserved.
//

#import "MyViewController.h"

#import "LinkToMyApp.h"

#import <AdSupport/AdSupport.h>

@interface MyViewController ()

@property (strong, nonatomic) IBOutlet UITextField *loginField;
@property (strong, nonatomic) IBOutlet UITextField *passField;

@end

@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loginField.text = @"toto";
    self.passField.text = @"qwerty";

}

-(IBAction)createAccountAction:(id)sender
{
    NSString *params = [NSString stringWithFormat:@"user[login]=%@&user[password]=%@&user[udid]=%@", self.loginField.text, self.passField.text, [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://mighty-basin-2906.herokuapp.com/users/register"]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError || [(NSHTTPURLResponse *)response statusCode] >= 400)
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                                   message:@"error"
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"ok"
                                                                         otherButtonTitles:nil];
                                   [alert show];
                                   
                                   return;
                               }
                               
                               [[LinkToMyApp linker] notifyServerForEvent:@"login" withInfos:@{@"username" : @"John"}];
                               
                           }];
}

-(IBAction)purchaseAction:(id)sender
{
    [[LinkToMyApp linker] notifyServerForEvent:@"purchase_inapp" withInfos:@{@"credits" : @"500"}];
}

@end
