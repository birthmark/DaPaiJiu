//
//  helpViewController.m
//  PJ
//
//  Created by XiaoG on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "helpViewController.h"
#import "PJHelpDetailViewController.h"

@implementation helpViewController

@synthesize items;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.title = @"帮助";
    items = [[NSArray alloc] initWithObjects:@"大牌九规则",@"牌九的传说",@"关于", nil];
    
    UIBarButtonItem* backBtn = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    //[navController navigationBar];
    self.navigationItem.leftBarButtonItem = backBtn;
    [backBtn release];

    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)dealloc
{
    [items release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"helpViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSUInteger row = [indexPath row];
    
    cell.textLabel.text = [items objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     PJHelpDetailViewController *detailController = [[PJHelpDetailViewController alloc] initWithNibName:@"PJHelpDetailViewController" bundle:nil];
    NSUInteger row = [indexPath row];
    detailController.title = [items objectAtIndex:row];
    
    [self.navigationController pushViewController:detailController animated:YES];
    if (row == 0)
    {
        [detailController setDescription:KGuiZe];
    }
    else if (row == 1)
    {
        [detailController setDescription:KChuanshuo];
    }
    else if (row == 2)
    {
        [detailController setDescription:KGuanyu];
    }
    
    [detailController release];
}

- (IBAction)back:(id)sender
{
    [observer backToView];
}

- (void)setObeserver:(id)obj
{
    observer = obj;
}

@end
