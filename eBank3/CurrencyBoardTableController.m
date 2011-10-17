//
//  CurrencyBoardTableController.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 16/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CurrencyBoardTableController.h"
#import "CurrencyBoardInputController.h"
#import "CurrencyMarket.h"

#define ROW_HEIGHT 100

@implementation CurrencyBoardTableController
@synthesize cellForCurrencyBoard=cellForCurrencyBoard_;
@synthesize editButton=editButton_;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

     self.navigationItem.rightBarButtonItem = self.editButtonItem;
     self.tableView.rowHeight =ROW_HEIGHT;   
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CurrencyBoardCell" owner:self options:nil];
		cell = self.cellForCurrencyBoard;
		self.cellForCurrencyBoard = nil;
    
    }
    return cell;
}


-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *addViewController = [[CurrencyMarket alloc] initWithNibName:@"CurrencyMarket" bundle:nil];
    [self.navigationController pushViewController:addViewController animated:YES]; 
    addViewController.title = @"Rakuten : Amazon";
	[addViewController release];
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController *addViewController = [[CurrencyBoardInputController alloc] initWithNibName:@"CurrencyBoardInputController" bundle:nil];
    addViewController.title= @"Edit";
    addViewController.navigationItem.rightBarButtonItem = editButton_;
  	[self.navigationController pushViewController:addViewController animated:YES]; 
	[addViewController release];
    
    
    
}

@end
