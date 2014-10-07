//
//  GRCheckoutViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/26/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRCheckoutViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface GRCheckoutViewController ()<ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic, strong) ABPeoplePickerNavigationController *addressBookController;

-(IBAction)importFromContactsClicked:(id)sender;

@end

@implementation GRCheckoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Checkout";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissViewController:)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissViewController:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)importFromContactsClicked:(id)sender
{
    _addressBookController = [[ABPeoplePickerNavigationController alloc] init];
    [_addressBookController setPeoplePickerDelegate:self];
    [self presentViewController:_addressBookController animated:YES completion:nil];

}

@end