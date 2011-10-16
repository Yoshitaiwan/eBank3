//
//  CurrencyBoardInputController.m
//  currencyboard
//
//  Created by Yoshiyuki Matsuoka on 15/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CurrencyBoardInputController.h"

@implementation CurrencyBoardInputController

-(void) dealloc
{
    [keys_ release];
    [dataSource_ release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    keys_ = [[NSArray alloc] initWithObjects:@"Pair", @"Price", @"Amount", nil];
    NSArray* object1 = [NSArray arrayWithObjects:@"Rakuten", @"Amaon", nil];
    NSArray* object2 = [NSArray arrayWithObjects:@"1", @"1.23", nil];
    NSArray* object3 = [NSArray arrayWithObjects:@"10000", @"12300", nil];
    NSArray* objects = [NSArray arrayWithObjects:object1, object2, object3, nil];
    dataSource_ = [[NSDictionary alloc] initWithObjects:objects forKeys:keys_];
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
   // return 0;
   return [keys_ count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
 //   return 0;
//        return [keys_ count];
    id key = [keys_ objectAtIndex:section];
    return [[dataSource_ objectForKey:key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"style-value2";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( nil == cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                      reuseIdentifier:identifier];
        [cell autorelease];
    }
    id key = [keys_ objectAtIndex:indexPath.section];
    NSString* text = [[dataSource_ objectForKey:key] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text =text; 
    
    if( [key isEqualToString:@"Pair"] )
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator   ;
 
    if( [key isEqualToString:@"Price"] && (indexPath.row % 2 )  )
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator   ;
    
    if( [key isEqualToString:@"Amount"] && !(indexPath.row % 2 )  )
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator   ;
    
    
    if (indexPath.row % 2 ) 
    {
      cell.textLabel.text =@"Sell"; 
    }
    else
    {    
      cell.textLabel.text =@"Buy"; 
    }
    return cell;

}


- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section 
{
    return [keys_ objectAtIndex:section];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"test");
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     CurrencyBoardInputController *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
 
    
}

@end
