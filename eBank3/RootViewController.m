//
//  RootViewController.m
//  eBank2
//
//  Created by Yoshiyuki Matsuoka on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "AccountList.h"

#define kTagViewForTransition 1.0


@implementation RootViewController

//@synthesize  myTableView= myTableView_;
@synthesize amount_1 = amount_1_;
@synthesize accountDetailView_1 = accountDetailView_1_;
@synthesize amount_2 = amount_2_;
@synthesize accountDetailView_2= accountDetailView_2_;

@synthesize transitioning;
@synthesize addButton=addButton_;
@synthesize menuButton=menuButton_;

@synthesize containerView =containerView_;
//@synthesize rightItem=rightItem_;


- (void)dealloc
{
    [keys_ release];
    [dataSource_ release];
    [accountDetailView_1_ release];
    [accountDetailView_2_ release];
  //  [rightItem_ release];
    [amount_1_ release];
    [amount_2_ release];
    
    [addButton_ release];
    [menuButton_ release];
    
    [containerView_ release];
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
    keys_ = [[NSArray alloc] initWithObjects:@"Singapore", @"U.K.", @"Malaysia", @"Indonesia", nil];
    NSArray* object1 = [NSArray arrayWithObjects:@"Monkey", @"Dog", @"Lion", @"Elephant", nil];
    NSArray* object2 = [NSArray arrayWithObjects:@"Snake", @"Gecko", nil];
    NSArray* object3 = [NSArray arrayWithObjects:@"Frog", @"Newts", nil];
    NSArray* object4 = [NSArray arrayWithObjects:@"Shark", @"Salmon", nil];
    NSArray* objects = [NSArray arrayWithObjects:object1, object2, object3, object4, nil];
    dataSource_ = [[NSDictionary alloc] initWithObjects:objects forKeys:keys_];
    
    [self.containerView addSubview:self.accountDetailView_1];
    [self.containerView addSubview:self.accountDetailView_2];
    
    self.accountDetailView_1.hidden = NO;
    self.accountDetailView_2.hidden = YES;
    self.transitioning = NO;
    
    self.navigationItem.title =@"Accounts";
    
	self.navigationItem.rightBarButtonItem = self.addButton;
    self.navigationItem.leftBarButtonItem =self.menuButton;
    
    
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
    
    /*     UIAlertView* alert = [[[UIAlertView alloc] init] autorelease];
     alert.message = message;
     [alert addButtonWithTitle:@"OK"];
     [alert show];
     */
    NSString *tmp = [message stringByAppendingString:@" current balance"] ;
    self.amount_2.text = tmp; 
    
    [self nextTransition];
}    


-(void)performTransition
{
   
	// First create a CATransition object to describe the transition
	CATransition *transition = [CATransition animation];
	// Animate over 3/4 of a second
	transition.duration = 0.70;
	// using the ease in/out timing function
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	// Now to set the type of transition. Since we need to choose at random, we'll setup a couple of arrays to help us.
    //	NSString *types[4] = {kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
    //	NSString *subtypes[4] = {kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
    //	int rnd = random() % 4;
    //	transition.type = types[rnd];
	transition.type = kCATransitionMoveIn;
	transition.subtype = kCATransitionFromRight;
	// Finally, to avoid overlapping transitions we assign ourselves as the delegate for the animation and wait for the
	// -animationDidStop:finished: message. When it comes in, we will flag that we are no longer transitioning.
	transitioning = YES;
	
    
    transition.delegate = self;
	
	// Next add it to the containerView's layer. This will perform the transition based on how we change its contents.
	[self.containerView.layer addAnimation:transition forKey:nil];
	
	// Here we hide view1, and show view2, which will cause Core Animation to animate view1 away and view2 in.
	self.accountDetailView_1.hidden = YES;
	self.accountDetailView_2.hidden = NO;
	
	// And so that we will continue to swap between our two images, we swap the instance variables referencing them.
	UIView *tmp = self.accountDetailView_2;
	self.accountDetailView_2 = self.accountDetailView_1;
	self.accountDetailView_1 = tmp;
    
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
#pragma mark Actions

- (IBAction) addButtonPressed: (id) sender {
	NSLog(@"%@", @"Add button pressed.");
	
    UIViewController *addViewController = [[AccountList alloc] initWithNibName:@"AccountList" bundle:nil];
    
//	UINavigationController *addNavController = [[UINavigationController alloc] initWithRootViewController: [[UIViewController alloc] init]];
	[self.navigationController pushViewController:addViewController animated:YES]; 
//	[addNavController release];
	[addViewController release];
  
  //  [self.navigationController pushViewController: [[UIViewController alloc] init] animated:YES];
 
}

- (IBAction) menuButtonPressed: (id) sender {
	NSLog(@"%@", @"menu button pressed.");
    
    // static UIViewAnimationTransition transition = UIViewAnimationTransitionFlipFromLeft;
    
    UIView* nextView = [self nextView];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    [[self.view viewWithTag:kTagViewForTransition] removeFromSuperview];
    [self.view addSubview:nextView];
    [UIView commitAnimations];
    [UIView setAnimationsEnabled:NO];
    

    
    
}

- (UIView*)nextView {
    static BOOL isFront = YES;
    UIImage* image;
    UIView* view;
    if ( isFront ) {
        image = [UIImage imageNamed:@"dog.jpg"]; //< 表用の画像
       // view = [[[UIImageView alloc] initWithImage: image] autorelease];
        view = [[[UITableView alloc] init ] autorelease];
        
        self.navigationItem.title =@"Menu"; 
        
        self.navigationItem.rightBarButtonItem.enabled= NO;
        
    } else {
        view = nil;
        
        self.navigationItem.title =@"Accounts"; 
        
        self.navigationItem.rightBarButtonItem.enabled= YES;
    }
    isFront = ( YES != isFront );
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
