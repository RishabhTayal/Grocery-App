//
//  GRCartViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/24/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRCartViewController.h"
#import "Cart.h"
#import <UITableView-NXEmptyView/UITableView+NXEmptyView.h>
#import "GRCartItemTableViewCell.h"
#import "GRCheckoutViewController.h"
#import "GRTabViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <UIImageView+AFNetworking.h>

@interface GRCartViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) IBOutlet UILabel* totalPriceLabel;

@property (nonatomic, strong) NSMutableArray* datasource;
@property (nonatomic, strong) NSMutableDictionary* cartDict;

@end

@implementation GRCartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.nxEV_emptyView = [[[NSBundle mainBundle] loadNibNamed:@"EmptyCartView" owner:self options:nil] objectAtIndex:0];
    self.tableView.nxEV_hideSeparatorLinesWheyShowingEmptyView = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Checkout" style:UIBarButtonItemStyleBordered target:self action:@selector(checkoutClicked:)];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    GRWebService* caller = [[GRWebService alloc] init];
    [caller getCartWithCallback:^(id result, NSError *error) {
        _cartDict = [NSMutableDictionary dictionaryWithDictionary:result];
        _datasource = [NSMutableArray arrayWithArray:result[@"orderItems"]];
        
        if (_datasource.count != 0) {
            self.navigationItem.leftBarButtonItem = self.editButtonItem;
            self.navigationItem.rightBarButtonItem.enabled = YES;
        } else {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:animated];
}

-(void)checkoutClicked:(id)sender
{
    GRCheckoutViewController* checkoutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GRCheckoutViewController"];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:checkoutVC] animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datasource.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (_datasource.count == 0) {
        return nil;
    }
    UIView* footerView = [[NSBundle mainBundle] loadNibNamed:@"GRCartFooterView" owner:self options:nil][0];
    footerView.frame = CGRectMake(0, 0, self.view.frame.size.width, footerView.frame.size.height);
//    float totalPrice = 0.0;
//    for (Cart* item in _datasource) {
//        totalPrice = totalPrice + ([item.price floatValue] * [item.quantity integerValue]);
//    }
    _totalPriceLabel.text = self.cartDict[@"total"][@"amount"];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_datasource.count == 0) {
        return 0;
    }
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GRCartItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(GRCartItemTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Cart* item = _datasource[indexPath.row];

    GRWebService* caller = [[GRWebService alloc] init];
    [caller getMediaListForProduct:self.datasource[indexPath.row][@"productId"] callback:^(id result, NSError *error) {
        DLog(@"%@", result);
        

    }];
    cell.itemNameLabel.text = self.datasource[indexPath.row][@"name"];
    cell.quantityLabel.text = [NSString stringWithFormat:@"%@", self.datasource[indexPath.row][@"quantity"]];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@", self.datasource[indexPath.row][@"retailPrice"][@"amount"]];
}

#pragma mark - UITableView Edititing

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.editing) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        Cart* item = _datasource[indexPath.row];
//        [item MR_deleteEntity];
//        
//        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
//            [((GRTabViewController*)self.tabBarController) cartUpdated];
//        }];
        
        [_datasource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //        [((GRTabViewController*)self.tabBarController) removeFromCart];
        
        
        if (_datasource.count == 0) {
            self.navigationItem.leftBarButtonItem = nil;
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end