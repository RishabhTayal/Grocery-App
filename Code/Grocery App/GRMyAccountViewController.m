//
//  GRMyAccountViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/24/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRMyAccountViewController.h"

@interface GRMyAccountViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@end

@implementation GRMyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"a";
            break;
        case 1:
            cell.textLabel.text = @"a";
            break;
        case 2:
            cell.textLabel.text = @"a";
            break;
        case 3:
            cell.textLabel.text = @"a";
            break;
        default:
            cell.textLabel.text = @"a";
            break;
    }
}

@end
