//
//  CurrencyBoardController.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 27/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CurrencyBoardController.h"
#import <QuartzCore/QuartzCore.h>

@implementation CurrencyBoardController
@synthesize currentInputView=currencyInputView_;
@synthesize transitioning;
@synthesize shopName=shopName_;
@synthesize shopImage = shopImage_;

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
    [images_ release];
    [details_ release];
    [dataSource_ release];
    [currencyInputView_ release];
    [shopName_ release];
    [super dealloc];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource_ = [[NSArray alloc] initWithObjects:@"Monkey", @"Dog", @"Lion", @"Elephant", nil];
    images_ = [[NSMutableArray alloc] initWithCapacity:8];
    for ( NSString* name in dataSource_ ) {
        NSString* imageName = [NSString stringWithFormat:@"%@.png", name];
        UIImage* image = [UIImage imageNamed:imageName];
        [images_ addObject:image];
    }
    
    self.tableView.rowHeight =60;
	self.currentInputView.hidden = YES;
    
    [self.view addSubview:self.currentInputView];
    
    
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

    cell.imageView.image = [images_ objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"20-Sept-2011 12:30:11PM";
    cell.textLabel.text = [dataSource_ objectAtIndex:indexPath.row];
    
    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton   ;
	return cell;

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


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath 
{
    self.shopName.text=[dataSource_ objectAtIndex:indexPath.row];  
    self.shopImage.image = [images_ objectAtIndex:indexPath.row];
    [self nextTransition];
    
}    


-(void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
	self.transitioning = NO;
}

-(void)nextTransition 
{
	if(!self.transitioning)
	{
		[self performTransition];
	}
}

#define kTagViewForTransition 1.0
#define kTransitionDuration   0.70
#define kAnimationDuration    1.00


-(void)performTransition
{
    
	// First create a CATransition object to describe the transition
	CATransition *transition = [CATransition animation];
	// Animate over 3/4 of a second
	transition.duration = kTransitionDuration;
	// using the ease in/out timing function
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionFade ;
//	transition.subtype = kCATransitionFromTop;
	// Finally, to avoid overlapping transitions we assign ourselves as the delegate for the animation and wait for the
	// -animationDidStop:finished: message. When it comes in, we will flag that we are no longer transitioning.
	transitioning = YES;
    transition.delegate = self;
	
	// Next add it to the containerView's layer. This will perform the transition based on how we change its contents.
    [self.view.layer addAnimation:transition forKey:nil];
	
	// Here we hide view1, and show view2, which will cause Core Animation to animate view1 away and view2 in.
	self.currentInputView.hidden = NO;
	
/*	// And so that we will continue to swap between our two images, we swap the instance variables referencing them.
	UIView *tmp = self.accountDetailTopScreenView_2;
	self.accountDetailTopScreenView_2 = self.accountDetailTopScreenView_1;
	self.accountDetailTopScreenView_1 = tmp;
    
    UILabel *tmpLabel =self.amount_2;
    self.amount_2 = self.amount_1;
    self.amount_1 = tmpLabel;
  */  
}


@end
