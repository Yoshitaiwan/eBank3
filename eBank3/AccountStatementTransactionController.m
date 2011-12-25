//
//  AccountStatementDetailController.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 26/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AccountStatementTransactionController.h"
#import "StatementRecordEntity.h"
#import "DateTimeHelper.h"

#define kTagViewForTransition 1.0
#define kTransitionDuration   0.70
#define kAnimationDuration    1.00

@implementation AccountStatementTransactionController

@synthesize transactionDetailView_1, transactionDetailView_2,amount_1,amount_2,narrative_1,narrative_2, page_1,page_2,timeStamp_1,timeStamp_2,account_1,account_2;
@synthesize transitioning;
@synthesize formatter ;
@synthesize previouslyObtainedFetchedResultsController,containerView ;
@synthesize lastSelectedIndexPath;
@synthesize pageCount;

-(void) dealloc
{
    [transactionDetailView_1 dealloc];
    [transactionDetailView_2 dealloc];
    [amount_1 dealloc];
    [amount_2 dealloc];
    [narrative_1 dealloc];
    [narrative_2 dealloc];
    
    [formatter dealloc];
    [previouslyObtainedFetchedResultsController dealloc];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    // Do any additional setup after loading the view from its nib.
    
    [self.containerView addSubview:self.transactionDetailView_1];
    [self.containerView addSubview:self.transactionDetailView_2];
    
    self.transactionDetailView_1.hidden = NO;
    self.transactionDetailView_2.hidden = YES;
    self.transitioning = NO;
    
    
    formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
   // self.navigationItem.title =kAccounts;
   // self.navigationItem.leftBarButtonItem =self.menuButton;
    
    
  
}

-(void)viewWillAppear:(BOOL)animated
{
    StatementRecordEntity* recordEntity =[self.previouslyObtainedFetchedResultsController  objectAtIndexPath:self.lastSelectedIndexPath];
    
    pageCount = [self.previouslyObtainedFetchedResultsController.fetchedObjects  count];
    
    self.account_1.text= [recordEntity account];    
    self.amount_1.text= [[formatter stringFromNumber:recordEntity.amount] stringByAppendingString:@" pt."];    
    self.narrative_1.text= [recordEntity narrative];
    self.page_1.text =[NSString stringWithFormat:@"%d/%d", lastSelectedIndexPath.row +1,pageCount]; 
    self.timeStamp_1.text =[DateTimeHelper  convertNSNumberToDate:recordEntity.timeStampInserted withTime:TRUE ];
    
}
 
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath 
{
    StatementRecordEntity* record =[previouslyObtainedFetchedResultsController objectAtIndexPath:indexPath];
    self.amount_2.text = [formatter stringFromNumber: record.accumBal];    
    
    [self nextTransition];
}    


-(void)performTransition
{
    
	// First create a CATransition object to describe the transition
	CATransition *transition = [CATransition animation];
	// Animate over 3/4 of a second
	transition.duration = kTransitionDuration;
	// using the ease in/out timing function
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionMoveIn;
	transition.subtype = kCATransitionFromRight;
	// Finally, to avoid overlapping transitions we assign ourselves as the delegate for the animation and wait for the
	// -animationDidStop:finished: message. When it comes in, we will flag that we are no longer transitioning.
	transitioning = YES;
    transition.delegate = self;
	
	// Next add it to the containerView's layer. This will perform the transition based on how we change its contents.
	[self.containerView.layer addAnimation:transition forKey:nil];
	
	// Here we hide view1, and show view2, which will cause Core Animation to animate view1 away and view2 in.
	self.transactionDetailView_1.hidden = YES;
	self.transactionDetailView_2.hidden = NO;
	
	// And so that we will continue to swap between our two images, we swap the instance variables referencing them.
	UIView *tmp = self.transactionDetailView_1;
	self.transactionDetailView_2 = self.transactionDetailView_1;
	self.transactionDetailView_1 = tmp;
    
    UILabel *tmpLabel =self.amount_2;
    self.amount_2 = self.amount_1;
    self.amount_1 = tmpLabel;
    
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


@end
