//
//  GRCheckoutViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/26/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRCheckoutViewController.h"

@interface GRCheckoutViewController ()

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

@end