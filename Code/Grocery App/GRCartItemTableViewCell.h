//
//  GRCartItemTableViewCell.h
//  Grocery App
//
//  Created by Rishabh Tayal on 9/26/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRCartItemTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView* itemImageView;
@property (nonatomic, strong) IBOutlet UILabel* itemNameLabel;
@property (nonatomic, strong) IBOutlet UILabel* priceLabel;
@property (nonatomic, strong) IBOutlet UILabel* quantityLabel;

@end
