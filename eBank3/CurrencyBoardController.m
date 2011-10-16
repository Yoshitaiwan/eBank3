//
//  CurrencyBoardController.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 27/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CurrencyBoardController.h"
#import "CurrencyBoardTableController.h"
#import <QuartzCore/QuartzCore.h>
#import "CurrencyBoardInputController.h"

//#import "CurrencyBoardSettingController.h"
//#import "CurrencyBoardTableController.h"

@implementation CurrencyBoardController
@synthesize currentInputView=currencyInputView_;
@synthesize transitioning;


- (void)dealloc
{
//    [images_ release];
 //   [details_ release];
    [dataSource_ release];
    [currencyInputView_ release];
    [super dealloc];
}



-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        CurrencyBoardTableController* currencyBoardSell = [[CurrencyBoardTableController alloc] initWithNibName:@"CurrencyBoardTableController" bundle:nil];
        UIImage* icon1 = [UIImage imageNamed:@"Dog.png"];
        currencyBoardSell.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Sell" image:icon1 tag:0] autorelease];
       
        CurrencyBoardTableController* currencyBoardBuy = [[CurrencyBoardTableController alloc]initWithNibName:@"CurrencyBoardTableController" bundle:nil];
        UIImage* icon2 = [UIImage imageNamed:@"Moneky.png"];
        currencyBoardBuy.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Buy" image:icon2 tag:0] autorelease];
        
        CurrencyBoardTableController* currencyBoardSellMyCurrency = [[CurrencyBoardTableController alloc]initWithNibName:@"CurrencyBoardTableController" bundle:nil];
        UIImage* icon3 = [UIImage imageNamed:@"Lion.png"];
        currencyBoardSellMyCurrency.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"My Currency" image:icon3 tag:0] autorelease];
      
        NSArray* controllers = [NSArray arrayWithObjects:currencyBoardBuy,currencyBoardSell,currencyBoardSellMyCurrency, nil];
        
      /*  
        UIImage* icon = [UIImage imageNamed:@"Dog.png"];
        self.viewControllerBuy.tabBarItem= [[[UITabBarItem alloc] initWithTitle:@"Hello" image:icon tag:0] autorelease];
        NSArray* controllers = [NSArray arrayWithObjects:self.viewControllerBuy, self.viewControllerBuy, nil];
        */
        [self setViewControllers:controllers];
    
    }
    return self;
    
}


-(void) buttonClicked:(id)sender
{
    UIViewController *addViewController = [[CurrencyBoardInputController alloc] initWithNibName:@"CurrencyBoardInputController" bundle:nil];
    addViewController.title= @"Create New";
  	[self.navigationController pushViewController:addViewController animated:YES]; 
	[addViewController release];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
/*    dataSource_ = [[NSArray alloc] initWithObjects:@"Monkey", @"Dog", @"Lion", @"Elephant", nil];
    images_ = [[NSMutableArray alloc] initWithCapacity:8];
    for ( NSString* name in dataSource_ ) {
        NSString* imageName = [NSString stringWithFormat:@"%@.png", name];
        UIImage* image = [UIImage imageNamed:imageName];
        [images_ addObject:image];
    }
*/
    //self.navigationItem.rightBarButtonItem = self.editButton;
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose  target:self action:@selector(buttonClicked:) ]autorelease];

}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataSource_ count];
}



- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath 
{
    //self.shopName.text=[dataSource_ objectAtIndex:indexPath.row];  
    //self.shopImage.image = [images_ objectAtIndex:indexPath.row];
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
	// Finally, to avoid overlapping transitions we assign ourselves as the delegate for the animation and wait for the
	// -animationDidStop:finished: message. When it comes in, we will flag that we are no longer transitioning.
	transitioning = YES;
    transition.delegate = self;
	
	// Next add it to the containerView's layer. This will perform the transition based on how we change its contents.
    [self.view.layer addAnimation:transition forKey:nil];
	
	// Here we hide view1, and show view2, which will cause Core Animation to animate view1 away and view2 in.
	self.currentInputView.hidden = NO;

}

#pragma mark 

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath     
{
    // UIViewController *addViewController = [[CurrencyBoardSettingController alloc] initWithNibName:@"CurrencyBoardSettingController" bundle:nil];
 //   UIViewController *addViewController = [[UIViewController alloc]init ];
    
 /*   addViewController.title=[dataSource_ objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:addViewController animated:YES]; 
	[addViewController release];   
*/
  }


@end
