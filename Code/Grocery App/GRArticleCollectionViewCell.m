//
//  GRArticleCollectionViewCell.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/29/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRArticleCollectionViewCell.h"

@implementation GRArticleCollectionViewCell

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.layer.borderColor = [[UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0] CGColor];
    self.layer.borderWidth = 1.0;
//    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.layer.shadowOffset = CGSizeMake(0, 0);
//    self.layer.shadowRadius = 3;
//    self.layer.masksToBounds = NO;
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds    ].CGPath;
//    self.layer.shadowOpacity = 0.75f;
}

@end
