//
//  AccountMenuDataSource.m
//  eBank
//
//  Created by Yoshiyuki Matsuoka on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuController.h"
#import "CurrencyBoardController.h"

@implementation MenuController

-(void) dealloc
{
    [super dealloc];   
    [keys_ release];
    [dataSource_ release];
    
}
- (id)init
{
    self = [super init];
    
    if (nil !=self) {
        // Initialization code here.
        keys_ = [[NSArray alloc] initWithObjects:@"", @"Markets", @"Information", nil];
        NSArray* object1 = [NSArray arrayWithObjects:@"Accounts", @"Transfer", @"Delivery", nil];
        NSArray* object2 = [NSArray arrayWithObjects:@"Gobal Call Markets", @"My Currency Board", nil];
        NSArray* object3 = [NSArray arrayWithObjects:@"Trade Ranking", @"Rich Ranking",@"Broadcast", nil];
        NSArray* objects = [NSArray arrayWithObjects:object1, object2, object3,  nil];
        dataSource_ = [[NSDictionary alloc] initWithObjects:objects forKeys:keys_];
    }
    return self;
}




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


 


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id key = [keys_ objectAtIndex:indexPath.section];
    NSString* tmp  = [[dataSource_ objectForKey:key] objectAtIndex:indexPath.row];
    NSLog (tmp);
    
   // UITableViewController *addViewController = [[CurrencyBoardController alloc] initWithNibName:@"CurrencyBoardController" bundle:nil];
    UITableViewController *addViewController = [[UITableViewController alloc] init ];
    addViewController.title= @"Currency Board";
  	[self.navigationController pushViewController:addViewController animated:YES]; 
	[addViewController release];
    
    
}


@end
