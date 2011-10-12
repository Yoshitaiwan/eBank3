//
//  RootViewController.m
//  eBank2
//
//  Created by Yoshiyuki Matsuoka on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AccountListController.h"
#import "AccountStatementController.h"

#define kTagViewForTransition 1.0
#define kTransitionDuration   0.70
#define kAnimationDuration    1.00

#define kAccounts        @"My Accounts"
#define kMenu            @"Menu"


@implementation RootViewController

@synthesize amount_1 = amount_1_;
@synthesize accountDetailTopScreenView_1 = accountDetailView_1_;
@synthesize amount_2 = amount_2_;
@synthesize accountDetailTopScreenView_2= accountDetailView_2_;

@synthesize transitioning;
@synthesize editAccountButton=editAccountButton_;
@synthesize menuButton=menuButton_;

@synthesize containerView =containerView_;
@synthesize  myDataSource=myDataSource_;
@synthesize images = images_;


- (void)dealloc
{
    [keys_ release];
    [dataSource_ release];
    
    [accountDetailView_1_ release];
    [accountDetailView_2_ release];
    [amount_1_ release];
    [amount_2_ release];
    
    [editAccountButton_ release];
    [menuButton_ release];
    
    [containerView_ release];
    [myDataSource_ release];
    
    [images_ release];
    [super dealloc];
    
}
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
        return nil;
    return self;   
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // 表示するデータを作成
    keys_ = [[NSArray alloc] initWithObjects:@"Singapore", @"U.K.", @"Malaysia", nil];
    NSArray* object1 = [NSArray arrayWithObjects:@"starbucks", @"daiso", @"fairprice" , nil];
    NSArray* object2 = [NSArray arrayWithObjects:@"amazon", @"facebook", nil];
    NSArray* object3 = [NSArray arrayWithObjects:@"Dog", @"Lion", nil];
    NSArray* objects = [NSArray arrayWithObjects:object1, object2, object3,  nil];
    dataSource_ = [[NSDictionary alloc] initWithObjects:objects forKeys:keys_];
    
    for (id key in keys_){
        for (NSString* name in [dataSource_ objectForKey:key]){
            NSLog(name);
        }
    }
    
    
    [self.containerView addSubview:self.accountDetailTopScreenView_1];
    [self.containerView addSubview:self.accountDetailTopScreenView_2];
    
    self.accountDetailTopScreenView_1.hidden = NO;
    self.accountDetailTopScreenView_2.hidden = YES;
    self.transitioning = NO;
    
    self.navigationItem.title =kAccounts;
    
    self.navigationItem.leftBarButtonItem =self.menuButton;
    
    
    MenuController* menudata = [[MenuController alloc] init ];
    [menudata setMainViewContainer:self];
    myDataSource_ = menudata;
    
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


- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView
{
    return keys_;
}



- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath 
{
    id key = [keys_ objectAtIndex:indexPath.section];
    NSString* message  = [[dataSource_ objectForKey:key] objectAtIndex:indexPath.row];
    NSString *tmp = [message stringByAppendingString:@" current balance"] ;
    self.amount_2.text = tmp; 
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
	self.accountDetailTopScreenView_1.hidden = YES;
	self.accountDetailTopScreenView_2.hidden = NO;
	
	// And so that we will continue to swap between our two images, we swap the instance variables referencing them.
	UIView *tmp = self.accountDetailTopScreenView_2;
	self.accountDetailTopScreenView_2 = self.accountDetailTopScreenView_1;
	self.accountDetailTopScreenView_1 = tmp;
    
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

#pragma mark -
#pragma mark Actios

- (IBAction) editButtonPressed: (id) sender {
//	NSLog(@"%@", @"Add button pressed.");
	
    UIViewController *addViewController = [[AccountListController alloc] initWithNibName:@"AccountListController" bundle:nil];
  	[self.navigationController pushViewController:addViewController animated:YES]; 
	[addViewController release];
 
}

- (IBAction) menuButtonPressed: (id) sender {
	//NSLog(@"%@", @"menu button pressed.");
    
    UIView *nextView = [self nextView];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
    [UIView setAnimationDuration:kAnimationDuration];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES]; 
    [[self.view viewWithTag:kTagViewForTransition] removeFromSuperview];
    [self.view addSubview:nextView];
    [UIView commitAnimations];
    [UIView setAnimationsEnabled:NO];
}


-(IBAction)goToStatementLabelPressed :(id) sender{
    NSLog(@"go to statement pressed");
    
    UIViewController *addViewController = [[AccountStatementController alloc] initWithNibName:@"AccountStatementController" bundle:nil];
  	[self.navigationController pushViewController:addViewController animated:YES];
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
  	[addViewController release];
}

-(void)viewWillAppear:(BOOL)animated{
    
   	self.navigationItem.rightBarButtonItem = self.editAccountButton;
}

- (UIView*)nextView {
  //  static BOOL isFront = YES;
    UIView* view;
    UITableView *table ;
    if (  [self.navigationItem.title isEqualToString:kAccounts] ) {
        table = [[[UITableView alloc] init ]autorelease];
     //   table = [[[MenuController alloc] init] autorelease]; not working as MenuController is not UIView
        table.dataSource = myDataSource_;
        table.delegate = myDataSource_;
        view = table;
        [self.navigationItem setTitle:kMenu]; 
        [self.navigationItem setRightBarButtonItem:nil animated:YES];
       // self.navigationItem.rightBarButtonItem.enabled= NO;
    } else {
        view = nil;
        self.navigationItem.title = kAccounts; 
        [self.navigationItem setRightBarButtonItem:editAccountButton_ animated:YES];
        
    //    self.navigationItem.rightBarButtonItem.enabled= YES;
    }
    //isFront = ( YES != isFront );
    view.tag = kTagViewForTransition;
    view.frame = self.view.bounds;
    view.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.contentMode = UIViewContentModeScaleAspectFill;
    return view;
}

- (void)animationDidStop {
    [UIView setAnimationsEnabled:YES];
    
}


@end
