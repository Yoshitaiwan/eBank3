//
//  RootViewController.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 17/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MenuController.h"
#import "BalanceGroupEntity.h"


@interface RootViewController : UIViewController  <UITableViewDelegate,UITableViewDataSource>

{
@private
    NSDictionary* dataSourceImage_;
    
    UILabel *amount_1_;
    UIView  *accountDetailView_1_;
    UIView *containerView_;
    UILabel *amount_2_;
    UIView  *accountDetailView_2_;
    
    UIView *menuView ; 
    UIView *accountView;
    NSMutableArray* images_;

    
    BOOL transitioning;
    BOOL isMenuClicked;
    
    
	UIBarButtonItem *editAccountButton_;
    UIBarButtonItem *menuButton_;
    
    MenuController *menuController; 

    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;

    BalanceGroupEntity* balanceGroupEntity ; 
    BalanceRecordEntity* lastSelectedBalanceRecordEntity;
    NSNumberFormatter* formatter;
    
    CGPoint originalCentrePoint_;
}

@property(nonatomic,retain) IBOutlet UILabel *amount_1;
@property(nonatomic,retain) IBOutlet UIView  *accountDetailTopScreenView_1;
@property(nonatomic,retain) IBOutlet UILabel *amount_2;
@property(nonatomic,retain) IBOutlet UIView  *accountDetailTopScreenView_2;

@property(nonatomic,retain) IBOutlet UIView *menuView; 
@property(nonatomic,retain) IBOutlet UIView *accountView; 

@property (nonatomic, retain) IBOutlet UIBarButtonItem *editAccountButton;
@property(nonatomic,retain) IBOutlet UIBarButtonItem *menuButton;

//@property BOOL transitioning;

@property (nonatomic, retain) IBOutlet UIView *containerView;
@property (nonatomic,retain) IBOutlet MenuController *menuController;
@property (nonatomic,retain) NSMutableArray* images;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) BalanceGroupEntity* balanceGroupEntity ;
@property (nonatomic, retain) NSNumberFormatter*  formatter;
@property (nonatomic, retain) BalanceRecordEntity*  lastSelectedBalanceRecordEntity;



- (IBAction) editButtonPressed: (id) sender;
- (IBAction) menuButtonPressed: (id) sender;
- (IBAction) goToStatementLabelPressed: (id) sender;

-(UIView*)nextView;
-(void)nextTransition;
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil context:(NSManagedObjectContext *) context;

-(void) moveMenuView; 

-(void) downloadAndSaveStatement:(NSManagedObjectContext *)context   ;

@end
