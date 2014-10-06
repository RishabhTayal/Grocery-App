//
//  GRItemDetailViewController.h
//  Grocery App
//
//  Created by Rishabh Tayal on 9/26/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRItemDetailViewController : UITableViewController

@property (nonatomic, strong) NSString* productId;
@property (nonatomic, strong) NSString* categoryId;

@end
