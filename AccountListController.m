//
//  AccountList.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 17/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AccountListController.h"
#import "AccountDisclosureController.h"
@implementation AccountListController


- (void)dealloc
{
    [keys_ release];
    [dataSource_ release];
    [super dealloc];
}


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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.navigationItem.title =@"Edit Accounts";
    
    self.navigationItem.rightBarButtonItem = [self editButtonItem];

    // 表示するデータを作成
    keys_ = [[NSArray alloc] initWithObjects:@"Singapore", @"U.K.", @"Malaysia", @"Indonesia", nil];
    NSArray* object1 = [NSArray arrayWithObjects:@"Amazon", @"Rakten", @"Lion", @"Elephant", nil];
    NSArray* object2 = [NSArray arrayWithObjects:@"Snake", @"Gecko", nil];
    NSArray* object3 = [NSArray arrayWithObjects:@"Frog", @"Newts", nil];
    NSArray* object4 = [NSArray arrayWithObjects:@"Shark", @"Salmon", nil];
    NSArray* objects = [NSArray arrayWithObjects:object1, object2, object3, object4, nil];
    dataSource_ = [[NSDictionary alloc] initWithObjects:objects forKeys:keys_];
    

}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section 
{
    id key = [keys_ objectAtIndex:section];
    return [[dataSource_ objectForKey:key] count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* identifier = @"basis-cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( nil == cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
        [cell autorelease];
    }
    id key = [keys_ objectAtIndex:indexPath.section];
    NSString* text = [[dataSource_ objectForKey:key] objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator   ;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return [keys_ count];
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section 
{
    return [keys_ objectAtIndex:section];
}

/*
- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView
{
    return keys_;
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    id key = [keys_ objectAtIndex:indexPath.section];
    NSString* tmp  = [[dataSource_ objectForKey:key] objectAtIndex:indexPath.row];
    NSLog (tmp);
    
    
    UIViewController *addViewController = [[AccountDisclosureController alloc] initWithNibName:@"AccountDisclosureController" bundle:nil];
    addViewController.title= tmp;
  	[self.navigationController pushViewController:addViewController animated:YES]; 
	[addViewController release];
    
}

@end
