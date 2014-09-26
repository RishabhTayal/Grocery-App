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

@interface GRCartViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* datasource;

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
    
    _datasource = [NSMutableArray arrayWithArray:[Cart MR_findAll]];
    
    if (_datasource.count != 0) {
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
    [self.tableView reloadData];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GRCartItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(GRCartItemTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cart* item = _datasource[indexPath.row];
    
    cell.itemImageView.image = [UIImage imageNamed:@"sev"];
    cell.itemNameLabel.text = item.title;
    cell.quantityLabel.text = [NSString stringWithFormat:@"%@", item.quantity];
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
        Cart* item = _datasource[indexPath.row];
        [item MR_deleteEntity];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            
        }];
        
        [_datasource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [((GRTabViewController*)self.tabBarController) removeFromCart];
        
        if (_datasource.count == 0) {
            self.navigationItem.leftBarButtonItem = nil;
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
    }
}

@end