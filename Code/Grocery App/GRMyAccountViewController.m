//
//  GRMyAccountViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/24/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRMyAccountViewController.h"
#import "GRLoginViewController.h"
#import <CardIO/CardIO.h>
#import "GROrderHistoryViewController.h"

@interface GRMyAccountViewController ()<UITableViewDelegate, UITableViewDataSource, CardIOPaymentViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@end

@implementation GRMyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Order History";
            cell.imageView.image = [UIImage imageNamed:@"history_icn"];
            break;
        case 1:
            cell.textLabel.text = @"Shipping";
            cell.imageView.image = [UIImage imageNamed:@"shipping_icn"];
            break;
        case 2:
            cell.textLabel.text = @"Payment info";
            cell.imageView.image = [UIImage imageNamed:@"billing_icn"];
            break;
        case 3:
            cell.textLabel.text = @"Favorites";
            cell.imageView.image = [UIImage imageNamed:@"billing_icn"];
            break;
        default:
            cell.textLabel.text = @"Account Info";
            cell.imageView.image = [UIImage imageNamed:@"account_icn"];
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
            case 0:
        {
            GROrderHistoryViewController* orderHistroryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GROrderHistoryViewController"];
            [self.navigationController pushViewController:orderHistroryVC animated:YES];
        }
            break;
            case 2:
        {
            CardIOPaymentViewController* scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
            scanViewController.appToken = @"db60839a7e194c93bbe3acf52c976397";
            [self presentViewController:scanViewController animated:YES completion:nil];
        }
            break;
        case 4:
        {
            GRLoginViewController* loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GRLoginViewController"];
            loginVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissLoginView:)];
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:loginVC] animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

-(void)dismissLoginView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CardIO Delegate Methods

-(void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)cardInfo inPaymentViewController:(CardIOPaymentViewController *)paymentViewController
{
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController
{
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
}

@end