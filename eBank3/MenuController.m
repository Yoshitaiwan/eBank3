//
//  AccountMenuDataSource.m
//  eBank
//
//  Created by Yoshiyuki Matsuoka on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuController.h"
#import "CurrencyBoardController.h"
#import "TransferAmountController.h"
#import "RootViewController.h"
//#import "ExchangeMarketsController.h"

//#define kMyCurrencyBoard @"My Currency Board"
#define kTransfer        @"Transfer"
#define kExchangeMarkets @"Exchange Markets"
#define kAccounts        @"My Accounts"
#define kDelivery        @"Get Delivery"

@implementation MenuController
@synthesize  mainViewContainer= mainViewContainer_;

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
        keys_ = [[NSArray alloc] initWithObjects:@"", @"Markets", @"Ranking",@"Setting", nil];
        NSArray* object1 = [NSArray arrayWithObjects:kAccounts,kTransfer, kDelivery, @"My Offer", nil];
        NSArray* object2 = [NSArray arrayWithObjects:kExchangeMarkets, nil];
        NSArray* object3 = [NSArray arrayWithObjects:@"Trade Volumne",@"News", nil];
        NSArray* object4 = [NSArray arrayWithObjects:@"My Setting", nil];
        
        NSArray* objects = [NSArray arrayWithObjects:object1, object2, object3,object4,  nil];
    
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
    UIViewController *addViewController =nil;
    
   
    id key = [keys_ objectAtIndex:indexPath.section];
    NSString* tmp  = [[dataSource_ objectForKey:key] objectAtIndex:indexPath.row];
    
/*    if ( [tmp isEqualToString:kMyCurrencyBoard])
    {
        addViewController = [[CurrencyBoardController alloc] initWithNibName:@"CurrencyBoardControll" bundle:nil];
     //   addViewController = [[UITabBarController alloc] init];
        addViewController.title= kMyCurrencyBoard;
   
    }
    else 
*/    
    if ([tmp isEqualToString:kTransfer]) 
    {
        addViewController = [[TransferAmountController alloc] initWithNibName:@"TransferAmountController" bundle:nil];
        addViewController.title= @"Transfer 1/3";
  
    
    }  
    else if ([tmp isEqualToString:kAccounts]) 
    { 
        addViewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
        
    }
    else if ([tmp isEqualToString:kDelivery]) 
    { 
        addViewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
        addViewController.title =@"Delivery 1/3";
    }
    else if ([tmp isEqualToString:kExchangeMarkets]) 
    { 
        addViewController = [[CurrencyBoardController alloc] initWithNibName:@"CurrencyBoardControll" bundle:nil];
        addViewController.title= kExchangeMarkets;
      
        
    }else {
        addViewController = [[TransferAmountController alloc] initWithNibName:@"TransferAmountController" bundle:nil];
        addViewController.title= @"Others 1/3";
    }
  
    
    [mainViewContainer_.navigationController pushViewController:addViewController animated:YES]; 
	[addViewController release];
    
    
    
    
}


@end
