//
//  FirstViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/24/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRHomeViewController.h"
#import "GRContainerTableViewCell.h"
#import "GRItemDetailViewController.h"

@interface GRHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* datasource;

- (IBAction)cartClicked:(id)sender;

@end

@implementation GRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    GRWebService* caller = [[GRWebService alloc] init];
//    [caller getCategoriesWithCallback:^(NSArray *result, NSError *error) {
//        _datasource = [NSMutableArray arrayWithArray:[result valueForKey:@"category"]];
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }];
    
    self.datasource = @[ @{ @"description": @"Section A",
                            @"articles": @[ @{ @"title": @"Article A1" },
                                            @{ @"title": @"Article A2" },
                                            @{ @"title": @"Article A3" },
                                            @{ @"title": @"Article A4" },
                                            @{ @"title": @"Article A5" }
                                            ]
                            },
                         @{ @"description": @"Section B",
                            @"articles": @[ @{ @"title": @"Article B1" },
                                            @{ @"title": @"Article B2" },
                                            @{ @"title": @"Article B3" },
                                            @{ @"title": @"Article B4" },
                                            @{ @"title": @"Article B5" }
                                            ]
                            },
                         @{ @"description": @"Section C",
                            @"articles": @[ @{ @"title": @"Article C1" },
                                            @{ @"title": @"Article C2" },
                                            @{ @"title": @"Article C3" },
                                            @{ @"title": @"Article C4" },
                                            @{ @"title": @"Article C5" }
                                            ]
                            },
                         @{ @"description": @"Section D",
                            @"articles": @[ @{ @"title": @"Article D1" },
                                            @{ @"title": @"Article D2" },
                                            @{ @"title": @"Article D3" },
                                            @{ @"title": @"Article D4" },
                                            @{ @"title": @"Article D5" }
                                            ]
                            },
                         @{ @"description": @"Section E",
                            @"articles": @[ @{ @"title": @"Article E1" },
                                            @{ @"title": @"Article E2" },
                                            @{ @"title": @"Article E3" },
                                            @{ @"title": @"Article E4" },
                                            @{ @"title": @"Article E5" }
                                            ]
                            },
                         @{ @"description": @"Section F",
                            @"articles": @[ @{ @"title": @"Article F1" },
                                            @{ @"title": @"Article F2" },
                                            @{ @"title": @"Article F3" },
                                            @{ @"title": @"Article F4" },
                                            @{ @"title": @"Article F5" }
                                            ]
                            },
                         ];
    

    DLog(@"%@", _datasource);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectItemFromCollectionView:) name:@"didSelectItemFromCollectionView" object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"didSelectItemFromCollectionView" object:nil];
}
-(IBAction)cartClicked:(id)sender
{
    self.tabBarController.selectedIndex = 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    GRContainerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(GRContainerTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    cell.textLabel.text = _datasource[indexPath.row][@"name"];
    NSDictionary* cellData = [_datasource objectAtIndex:indexPath.section];
    NSArray* articleData = [cellData objectForKey:@"articles"];
    [cell setCollectionData:articleData];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary* sectionData = [_datasource objectAtIndex:section];
    NSString* header = [sectionData objectForKey:@"description"];
    
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

-(void)didSelectItemFromCollectionView:(NSNotification*)notification
{
    NSDictionary* cellData = [notification object];
    if (cellData) {
        DLog(@"Selected: %@", cellData);
        GRItemDetailViewController* detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GRItemDetailViewController"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

@end
