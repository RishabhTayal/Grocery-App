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
#import <UIImageView+AFNetworking.h>
#import <AFNetworking/AFNetworking.h>

@interface GRItemDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UIImageView* mainIV;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIStepper *quantityStepper;
@property (strong, nonatomic) IBOutlet UILabel *quantityLabel;
@property (nonatomic, strong) IBOutlet UILabel* productDescLabel;;
@property (nonatomic, strong) IBOutlet UILabel* priceLabel;

//@property (nonatomic, strong) NSMutableArray* datasource;
@property (nonatomic, strong) NSMutableDictionary* productDict;

- (IBAction)stepperChanged:(UIStepper*)sender;

@end

@implementation GRItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(addToCartClicked:)];
    
   
    GRWebService* caller = [[GRWebService alloc] init];
    [caller getProductInfo:self.productId callback:^(id result, NSError *error) {
        
        self.productDict = [NSMutableDictionary dictionaryWithDictionary:result];
        AFImageResponseSerializer* serializer = [[AFImageResponseSerializer alloc] init];
        serializer.acceptableContentTypes = [serializer.acceptableContentTypes setByAddingObject:@"image/jpg"];
        self.mainIV.imageResponseSerializer = serializer;
        
        [self.mainIV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kProductImageUrlPrefix, self.productDict[@"primaryMedia"][@"url"]]]];
        
        self.titleLabel.text = self.productDict[@"name"];
        self.productDescLabel.text = self.productDict[@"longDescription"];
        self.priceLabel.text = self.productDict[@"retailPrice"][@"amount"];
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addToCartClicked:(id)sender
{
    //    Cart* cart = [Cart MR_createEntity];
    //    cart.title = _titleLabel.text;
    //    NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
    //    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    //    cart.price =  [f numberFromString:[self.productDict objectForKey:@"retailPrice"][@"amount"]];
    //    cart.quantity = [NSNumber numberWithDouble:self.quantityStepper.value];
    //
    //    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
    //        self.navigationItem.rightBarButtonItem.title = @"Added to cart";
    //        self.navigationItem.rightBarButtonItem.enabled = NO;
    //
    //        [((GRTabViewController*)self.tabBarController) cartUpdated];
    //    }];
    
    GRWebService* caller = [[GRWebService alloc] init];
    //TODO:Replace with Skuid
    [caller addToCartCategory:self.categoryId productId:self.productDict[@"id"] skuId:self.productDict[@"id"] callback:^(id result, NSError *error) {
        DLog(@"%@", result);
        if (result[@"httpStatusCode"] != nil) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not add to cart" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil] show];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Item added to your cart" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
//            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

-(IBAction)stepperChanged:(UIStepper*)sender
{
    _quantityLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

@end