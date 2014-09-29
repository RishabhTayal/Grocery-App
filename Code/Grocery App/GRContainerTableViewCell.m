//
//  GRContainerTableViewCell.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/29/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRContainerTableViewCell.h"
#import "GRArticleCollectionViewCell.h"

@interface GRContainerTableViewCell()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView* collectionView;

@property (nonatomic, strong) NSArray* collectionData;

@end

@implementation GRContainerTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCollectionData:(NSArray *)collectionData {
//    [_collectionView setCollectionData:collectionData];
    _collectionData = collectionData;
    [_collectionView setContentOffset:CGPointZero animated:NO];
    [_collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collectionData count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GRArticleCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    NSDictionary* cellData = [self.collectionData objectAtIndex:indexPath.row];
    cell.articleTitle.text = [cellData objectForKey:@"title"];
    cell.articleImage.image = [UIImage imageNamed:@"sev"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* cellData = [self.collectionData objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectItemFromCollectionView" object:cellData];
}

@end
