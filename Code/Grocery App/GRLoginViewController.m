//
//  GRLoginViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/24/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRLoginViewController.h"
#import "AppDelegate.h"

@interface GRLoginViewController ()

-(IBAction)cancelClicked:(id)sender;
-(IBAction)skipLoginClicked:(id)sender;
-(IBAction)loginWithFacebookClicked:(id)sender;
-(IBAction)loginWithTwitterClicked:(id)sender;

@end

@implementation GRLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUDUserLoggedIn] boolValue] == true) {
        [self setMainView];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelClicked:(id)sender
{
//    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)skipLoginClicked:(id)sender
{
    [self setMainView];
}

-(IBAction)loginWithFacebookClicked:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"Coming soon" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

-(IBAction)loginWithTwitterClicked:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"Coming soon" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

-(void)setMainView
{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        UIUserNotificationSettings* settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge];
    }
    
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController* mainVC = [sb instantiateViewControllerWithIdentifier:@"GRTabController"];
    
    AppDelegate* appDelegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = mainVC;
}


@end