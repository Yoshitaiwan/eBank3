//
//  AccountStatementDetailController.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 26/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AccountStatementTransactionController : UIViewController
{
@private
   
    UILabel *amount_1;
    UILabel *amount_2;
    UILabel *narrative_1;
    UILabel *narrative_2;
    
    UILabel *timeStamp_1;
    UILabel *timeStamp_2;
    
    UILabel *page_1;
    UILabel *page_2;
    
    UIView  *transactionDetailView_1;
    UIView  *transactionDetailView_2;

    
    UIView *containerView;
    NSNumberFormatter* formatter;
    NSFetchedResultsController* previouslyObtainedFetchedResultsController;
    NSIndexPath* lastSelectedIndexPath;
    
}


@property(nonatomic,retain) IBOutlet UILabel *amount_1;
@property(nonatomic,retain) IBOutlet UILabel *amount_2;
@property(nonatomic,retain) IBOutlet UILabel *narrative_1;
@property(nonatomic,retain) IBOutlet UILabel *narrative_2;
@property(nonatomic,retain) IBOutlet UILabel *timeStamp_1;
@property(nonatomic,retain) IBOutlet UILabel *timeStamp_2;

@property(nonatomic,retain) IBOutlet UILabel *page_1;
@property(nonatomic,retain) IBOutlet UILabel *page_2;


@property(nonatomic,retain) IBOutlet UIView  *transactionDetailView_1;
@property(nonatomic,retain) IBOutlet UIView  *transactionDetailView_2;

@property(nonatomic,retain) NSIndexPath *lastSelectedIndexPath;
@property BOOL transitioning;

@property (nonatomic, retain) IBOutlet UIView *containerView;


@property (nonatomic, retain) NSNumberFormatter*  formatter;

@property(nonatomic,retain) NSFetchedResultsController* previouslyObtainedFetchedResultsController ;
@end
