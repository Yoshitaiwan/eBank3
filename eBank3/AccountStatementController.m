//
//  AccountStatementController.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 25/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AccountStatementController.h"
#import "AccountStatementDetailController.h"

@implementation AccountStatementController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)dealloc
{
    [keys_ release];
    [dataSource_ release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title =@"Transactions";
    
   
    // 表示するデータを作成
    keys_ = [[NSArray alloc] initWithObjects:@"21-Septempber-2011", @"01-October-2011", @"11-October-2011", @"21-October-2011", nil];
    NSArray* object1 = [NSArray arrayWithObjects:@"Pay to Thomas", @"From Ken by Transfer", @"From Tom by Bump", @"From Market ", nil];
    NSArray* object2 = [NSArray arrayWithObjects:@"Snake", @"Gecko", nil];
    NSArray* object3 = [NSArray arrayWithObjects:@"Frog", @"Newts", nil];
    NSArray* object4 = [NSArray arrayWithObjects:@"Shark", @"Salmon", nil];
    NSArray* objects = [NSArray arrayWithObjects:object1, object2, object3, object4, nil];
    dataSource_ = [[NSDictionary alloc] initWithObjects:objects forKeys:keys_];
    
   // details_ = [[NSArray alloc] initWithObjects:@"猿（サル）", @"犬（イヌ）", @"獅子（ライオン）", @"象（ゾウ）",   nil];
    
    
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
    static NSString* identifier = @"style-value2";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( nil == cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:identifier];
        [cell autorelease];
    }
    id key = [keys_ objectAtIndex:indexPath.section];
    NSString* text = [[dataSource_ objectForKey:key] objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    cell.detailTextLabel.text = @"3000";
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


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath 
{
    id key = [keys_ objectAtIndex:indexPath.section];
    NSString* message  = [[dataSource_ objectForKey:key] objectAtIndex:indexPath.row];
 //   NSString *tmp = [message stringByAppendingString:@" current balance"] ;
 //   self.amount_2.text = tmp; 

    NSLog(message);

    UIViewController *addViewController = [[AccountStatementDetailController alloc] initWithNibName:@"AccountStatementDetailController" bundle:nil];
    addViewController.title= @"Details";
  	[self.navigationController pushViewController:addViewController animated:YES]; 
	[addViewController release];
    

}    



@end
