//
//  GRTabViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/26/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRTabViewController.h"
#import "Customer.h"
#import "Cart.h"

@interface GRTabViewController ()

@end

@implementation GRTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self cartUpdated];
    
    
    Customer* cust = [Customer MR_findFirst];
    if (!cust) {
        //Create cart and save in core data
        GRWebService* caller = [[GRWebService alloc] init];
        [caller createCartcallBack:^(id result, NSError *error) {
            DLog(@"%@", result);
            
            
            Customer* newCust = [Customer MR_createEntity];
            newCust.cartId = [NSString stringWithFormat:@"%@", result[@"id"]];
            newCust.customerId = [NSString stringWithFormat:@"%@", result[@"customer"][@"id"]];
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                [self loadCart];
            }];

        }];
    } else {
        [self loadCart];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cartUpdated
{
    NSInteger totalItem = [Cart MR_countOfEntities];
    
    UITabBarItem* tbi = ((UIViewController*)self.viewControllers[2]).tabBarItem;
    if (totalItem <= 0) {
        tbi.badgeValue = nil;
    } else {
        tbi.badgeValue = [NSString stringWithFormat:@"%d", totalItem];
    }
}

-(void)loadCart
{
    GRWebService* caller = [[GRWebService alloc] init];
    [caller getCartWithCallback:^(NSArray *result, NSError *error) {
        DLog(@"%@", result);
    }];
}

@end
