//
//  TransferAmountController.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 3/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TransferAmountController.h"
#import <QuartzCore/QuartzCore.h>
#import "AccountListController.h"
#import "CustomView.h"


@implementation TransferAmountController
@synthesize toAmountButton=toAmountButton_;
@synthesize toPayee = toPayee_;
@synthesize viewController1=viewController1_;
@synthesize viewController2=viewController2_;
@synthesize transitioning;

@synthesize amountInputButton=amountInputButton_;
@synthesize amountInputView=amountInputView_;
@synthesize fromInputButton = fromInputButton_;
@synthesize sendTypePicker=sendTypePicker_;
@synthesize dataSourceArray=dataSourceArray_;

-(void) dealloc{
    [toAmountButton_ release];
    
    [toPayee_ release];
    [viewController1_ release];
    
    [viewController2_ release];
    [amountInputButton_ release];
    [amountInputView_ release];
    [fromInputButton_ release];

    [sendTypePicker_ release];
    [dataSourceArray_ release];
  
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

//#pragm  a mark - View lifecycle

- (void)viewDidLoad
{   
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = toAmountButton_;

   
    NSMutableArray* viewArray = [[NSMutableArray alloc] init];
    
    CustomView* phoneView = [[CustomView alloc] initWithFrame:CGRectZero];
    phoneView.title = @"Mobile Phone";
    phoneView.image = [UIImage imageNamed:@"Phone.png"];
    [viewArray addObject:phoneView];
    [phoneView release];
    
    CustomView* facebookView = [[CustomView alloc] initWithFrame:CGRectZero];
    facebookView.title = @"Facebook";
    facebookView.image = [UIImage imageNamed:@"facebook.png"];
    [viewArray addObject:facebookView];
    [facebookView release];
    
    CustomView* twitter = [[CustomView alloc] initWithFrame:CGRectZero];
    twitter.title = @"Twitter";
    twitter.image = [UIImage imageNamed:@"twitter.png"];
    [viewArray addObject:twitter];
    [twitter release];
    
    CustomView* email = [[CustomView alloc] initWithFrame:CGRectZero];
    email.title = @"Email";
    email.image = [UIImage imageNamed:@"email.png"];
    [viewArray addObject:email];
    [email release];
    
    
    CustomView* bump = [[CustomView alloc] initWithFrame:CGRectZero];
    email.title = @"bump";
    email.image = [UIImage imageNamed:@"bump.png"];
    [viewArray addObject:bump];
    [bump release];
    
    self.dataSourceArray = viewArray;
    [viewArray release];
}



- (IBAction) toAmountButtonPressed:(id)sender{
 
    UIViewController* addViewController = [[UIViewController alloc] init];
    addViewController.view = self.viewController1;
    self.amountInputView.hidden = YES;
    [self.viewController1 addSubview:self.amountInputView];

    addViewController.navigationItem.rightBarButtonItem = self.toPayee;
    addViewController.navigationItem.title =@"Transfer 2/3";
    [self.navigationController pushViewController:addViewController animated:YES]; 
	[addViewController release];
    
    
}
- (IBAction) toPayeeButtonPressed:(id)sender{
    
    UIViewController* addViewController = [[UIViewController alloc] init];
    addViewController.view = self.viewController2;
    addViewController.navigationItem.title =@"Transfer 3/3";
    [self.navigationController pushViewController:addViewController animated:YES]; 
	[addViewController release];
   
}


-(IBAction)fromInputButtonPressed:(id)sender
{
    NSLog(@"test");
    
    AccountListController *addViewController = [[AccountListController alloc] initWithNibName:@"AccountList" bundle:nil];
    addViewController.tableView.delegate = self;
    addViewController.navigationItem.title= @"From";
    addViewController.navigationItem.rightBarButtonItem = nil;

    UINavigationController *addNavController = [[UINavigationController alloc] initWithRootViewController:addViewController];
    addNavController.navigationBar.tintColor = [UIColor colorWithRed:(0.0) green:0.8  blue:0.0 alpha:1.0];
    [self presentModalViewController:addNavController animated:YES];
  	[addViewController release];
    
    [addNavController release];
    
    
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
	// Finally, to avoid overlapping transitions we assign ourselves as the delegate for the animation and wait for the
	// -animationDidStop:finished: message. When it comes in, we will flag that we are no longer transitioning.
	transitioning = YES;
    transition.delegate = self;
	
	// Next add it to the containerView's layer. This will perform the transition based on how we change its contents.
    [self.amountInputView.layer addAnimation:transition forKey:nil];
	
	// Here we hide view1, and show view2, which will cause Core Animation to animate view1 away and view2 in.
	self.amountInputView.hidden = NO;
    
}


- (IBAction)amountInputButtonPressed:(id)sender
{
    [self nextTransition];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tetaa");
    [self dismissModalViewControllerAnimated:YES];
    
}    
#pragma mark -
#pragma mark Picker Datasource Protocol 
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView 
{
	return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component 
{
    return [self.dataSourceArray count];
}


#pragma mark -
#pragma mark Picker Delegate Protocol

/*- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
{
		return [dataSourceArray_ objectAtIndex:row];
}
*/
// tell the picker which view to use for a given component and row, we have an array of views to show
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
		  forComponent:(NSInteger)component reusingView:(UIView *)view
{
    return [self.dataSourceArray objectAtIndex:row];
}


@end
