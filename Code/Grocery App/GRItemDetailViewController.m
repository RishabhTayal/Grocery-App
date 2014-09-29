//
//  GRItemDetailViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/26/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRItemDetailViewController.h"
#import "Cart.h"
#import "GRTabViewController.h"

@interface GRItemDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UIImageView* mainIV;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIStepper *quantityStepper;
@property (strong, nonatomic) IBOutlet UILabel *quantityLabel;

@property (nonatomic, strong) NSMutableArray* datasource;

- (IBAction)stepperChanged:(UIStepper*)sender;

@end

@implementation GRItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(addToCartClicked:)];
    
    self.mainIV.image = [UIImage imageNamed:@"sev"];
    self.titleLabel.text = @"Sev";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addToCartClicked:(id)sender
{
    Cart* cart = [Cart MR_createEntity];
    cart.title = _titleLabel.text;
    cart.price = [NSNumber numberWithFloat:4.99];
    cart.quantity = [NSNumber numberWithDouble:self.quantityStepper.value];
//    cart.desc =
//    cart.q
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        self.navigationItem.rightBarButtonItem.title = @"Added to cart";
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
        [((GRTabViewController*)self.tabBarController) cartUpdated];
    }];
    
//    GRTabViewController* tabBar = (GRTabViewController*)self.tabBarController;
//    [tabBar addedToCart];    
}

-(IBAction)stepperChanged:(UIStepper*)sender
{
    _quantityLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

@end