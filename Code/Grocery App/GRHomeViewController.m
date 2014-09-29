//
//  FirstViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/24/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRHomeViewController.h"

@interface GRHomeViewController ()

- (IBAction)cartClicked:(id)sender;

@end

@implementation GRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GRWebService* caller = [[GRWebService alloc] init];
    [caller searchProductsForText:@"a" callback:^(NSArray *result, NSError *error) {
        DLog(@"%@", result);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cartClicked:(id)sender
{
    self.tabBarController.selectedIndex = 2;
}

@end
