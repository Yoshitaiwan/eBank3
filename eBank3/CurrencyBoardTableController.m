//
//  CurrencyBoardTableController.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 12/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CurrencyBoardTableController.h"

@implementation CurrencyBoardTableController
@synthesize images=images_;
//@synthesize 

-(void) dealloc
{
    [images_ release];
    [super  dealloc];
    
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

    dataSource_ = [[NSArray alloc] initWithObjects:@"Monkey", @"Dog", @"Lion", @"Elephant", nil];
 //   images_ = [[NSMutableArray alloc] initWithCapacity:8];
    
    self.tableView.rowHeight =60;
   // self.currentInputView.hidden = YES;
    
    //   [self.view addSubview:self.currentInputView];


}



- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataSource_ count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"basis-cell";
    
    // NSString identifier= [dataSource_ objectAtIndex:indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [self tableViewCellWithReuseIdentifier:CellIdentifier];
	}
    
    [self configureCell:cell forIndexPath:indexPath];
    
  //  cell.imageView.image = [images_ objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"20-Sept-2011 12:30:11PM";
    cell.textLabel.text = [dataSource_ objectAtIndex:indexPath.row];
    
    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton   ;
	return cell;
    
}   

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
}
#pragma mark -
#pragma mark Configuring table view cells

#define RATE_TAG 1
#define MIDDLE_COLUMN_OFFSET 130.0
#define MIDDLE_COLUMN_WIDTH 150.0
#define MAIN_FONT_SIZE 23.0
#define LABEL_HEIGHT 26.0
#define ROW_HEIGHT 60

- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier {
    /*
     Create an instance of UITableViewCell .
     */
    
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle   reuseIdentifier:identifier] autorelease];
    /*
     Create labels for the text fields; set the highlight color so that when the cell is selected it changes appropriately.
     */
    UILabel *label;
    CGRect rect;
    
    // Create a label for the time.
    rect = CGRectMake(MIDDLE_COLUMN_OFFSET, (ROW_HEIGHT - LABEL_HEIGHT) / 3.7, MIDDLE_COLUMN_WIDTH, LABEL_HEIGHT);
    label = [[UILabel alloc] initWithFrame:rect];
    label.tag = RATE_TAG;
    label.font = [UIFont systemFontOfSize:MAIN_FONT_SIZE];
    label.textAlignment = UITextAlignmentRight;
    [cell.contentView addSubview:label];
    label.highlightedTextColor = [UIColor whiteColor];
    [label release];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
	UILabel *label;
	label = (UILabel *)[cell viewWithTag:RATE_TAG];
	label.text = @"0.1234569  "; 
	
}    


@end
