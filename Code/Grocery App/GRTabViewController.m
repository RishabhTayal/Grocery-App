//
//  GRTabViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/26/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRTabViewController.h"
#import "Cart.h"

@interface GRTabViewController ()

@end

@implementation GRTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self cartUpdated];
    // Do any additional setup after loading the view.
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

@end
