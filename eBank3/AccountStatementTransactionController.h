//
//  AccountStatementTransactionView.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 26/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

typedef enum
{
    kSlideNone,
    kSlideHorizontal,
    kSlideVertical,
} DirectionForSlide;

@interface AccountStatementTransactionController : UIViewController
{
@private
    CGPoint touchBegan_;
    CGPoint originalCentrePoint_;
    
    DirectionForSlide direction_;
    
    UIView  *transactionDetailView_1;
    UIView  *transactionDetailView_2;
    
    UIView *view ;
    UILabel *account_1;
    UILabel *amount_1;
    UILabel *narrative_1;
    UILabel *timeStamp_1;
    UILabel *page_1;

    UILabel *account_2;
    UILabel *amount_2;
    UILabel *narrative_2;
    UILabel *timeStamp_2;
    UILabel *page_2;

    
    NSNumberFormatter* formatter;
 
    NSFetchedResultsController* previouslyObtainedFetchedResultsController;
    NSIndexPath* lastSelectedIndexPath;
    
    NSInteger currentPage ;
    NSArray* datasource;
}

@property(nonatomic,retain) IBOutlet UIView *transactionDetailView_1;
@property(nonatomic,retain) IBOutlet UIView *transactionDetailView_2;


@property(nonatomic,retain) IBOutlet UILabel *account_1;
@property(nonatomic,retain) IBOutlet UILabel *amount_1;
@property(nonatomic,retain) IBOutlet UILabel *narrative_1;
@property(nonatomic,retain) IBOutlet UILabel *timeStamp_1;
@property(nonatomic,retain) IBOutlet UILabel *page_1;


@property(nonatomic,retain) IBOutlet UILabel *account_2;
@property(nonatomic,retain) IBOutlet UILabel *amount_2;
@property(nonatomic,retain) IBOutlet UILabel *narrative_2;
@property(nonatomic,retain) IBOutlet UILabel *timeStamp_2;
@property(nonatomic,retain) IBOutlet UILabel *page_2;

@property BOOL transitioning;

@property (nonatomic, retain) NSNumberFormatter*  formatter;

@property(nonatomic,retain) NSFetchedResultsController* previouslyObtainedFetchedResultsController ;
@property(nonatomic,retain) NSIndexPath *lastSelectedIndexPath;

@property(nonatomic) NSInteger currentPage;

@property(nonatomic,retain) NSArray* datasource;

@end
