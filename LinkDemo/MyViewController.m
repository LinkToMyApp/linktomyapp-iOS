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
//    NSString *params = [
    
    
    [[LinkToMyApp linker] notifyServerForEvent:@"login" withInfos:@{@"username" : @"John"}];
}

-(IBAction)purchaseAction:(id)sender
{
    [[LinkToMyApp linker] notifyServerForEvent:@"purchase_inapp" withInfos:@{@"credits" : @"500"}];
}

@end
