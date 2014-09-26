//
//  GRItemTableViewCell.h
//  Grocery App
//
//  Created by Rishabh Tayal on 9/26/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRItemTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView* productIV;
@property (nonatomic, strong) IBOutlet UILabel* productName;
@property (nonatomic, strong) IBOutlet UILabel* priceLabel;

@end
