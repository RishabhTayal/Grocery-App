//
//  GRTabViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/26/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRTabViewController.h"

@interface GRTabViewController ()

@end

@implementation GRTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addedToCart
{
    UITabBarItem* tbi = ((UIViewController*)self.viewControllers[2]).tabBarItem;
    tbi.badgeValue = [NSString stringWithFormat:@"%d", [tbi.badgeValue intValue] + 1];
}

-(void)removeFromCart
{
    UITabBarItem* tbi = ((UIViewController*)self.viewControllers[2]).tabBarItem;
    tbi.badgeValue = [NSString stringWithFormat:@"%d", [tbi.badgeValue intValue] - 1];
    if ([tbi.badgeValue intValue] <= 0) {
        tbi.badgeValue = nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
