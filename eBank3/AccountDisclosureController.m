//
//  AccountDisclosureController.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 23/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AccountDisclosureController.h"

@implementation AccountDisclosureController


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
    keys_ = [[NSArray alloc] initWithObjects:@"", @"Markets", @"Information",  nil];
    NSArray* object1 = [NSArray arrayWithObjects:@"Offer", @"Review", @"Delivery Record", @"Web Site", nil];
    NSArray* object2 = [NSArray arrayWithObjects:@"Transaction Volume", @"Price Board", nil];
    NSArray* object3 = [NSArray arrayWithObjects:@"Trade Ranking", @"Rich Ranking", nil];
    NSArray* objects = [NSArray arrayWithObjects:object1, object2, object3, nil];
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



#pragma mark ----- Responder -----

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    NSLog(@"Pressed");
}

@end
