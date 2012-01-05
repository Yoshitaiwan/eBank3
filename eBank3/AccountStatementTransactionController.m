//
//  AccountStatementTransactionView.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 26/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AccountStatementTransactionController.h"
#import "StatementRecordEntity.h"
#import "DateTimeHelper.h"

#define kTagViewForTransition 1.0
#define kTransitionDuration   0.30
#define kAnimationDuration    0.50

@implementation AccountStatementTransactionController
@synthesize transactionDetailView_1,transactionDetailView_2 ;
@synthesize account_1,amount_1,narrative_1,timeStamp_1,page_1;
@synthesize account_2,amount_2,narrative_2,timeStamp_2,page_2;
@synthesize transitioning;
@synthesize formatter ;
@synthesize previouslyObtainedFetchedResultsController,lastSelectedIndexPath;
@synthesize currentPage, datasource;


-(void) dealloc
{
    [transactionDetailView_1 release];
    [transactionDetailView_2 release];
    [amount_1 release];
    [amount_2 release];
    [narrative_1 release];
    [narrative_2 release];
    [page_1 release];
    [page_2 release];
    [timeStamp_1 release];
    [timeStamp_2 release];
    [account_1 release];
    [account_2 release];
    
    [formatter release];
    [previouslyObtainedFetchedResultsController release];
    [lastSelectedIndexPath release];    
    
    [datasource release];
    [super dealloc];
}


- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor blueColor]; 
    self.view = [[[UIView alloc]init]autorelease ];//  rightfully this should be in nib, but if in nib, then cannot capture "touches" events, so set it here
    
    [self.view addSubview:transactionDetailView_1];
    [self.view addSubview:transactionDetailView_2];
    
     self.transactionDetailView_1.hidden = NO;
     self.transactionDetailView_2.hidden = YES;
    
    formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];

    
   // StatementRecordEntity* recordEntity =[self.previouslyObtainedFetchedResultsController  objectAtIndexPath:self.lastSelectedIndexPath];
    
    datasource =[self.previouslyObtainedFetchedResultsController fetchedObjects];
    currentPage= lastSelectedIndexPath.row;
    StatementRecordEntity* recordEntity = [datasource objectAtIndex:currentPage];
    
      
    self.account_1.text= [recordEntity account];    
    self.amount_1.text= [[formatter stringFromNumber:recordEntity.amount] stringByAppendingString:@" pt."];    
    self.narrative_1.text= [recordEntity narrative];
    self.page_1.text =[NSString stringWithFormat:@"%d/%d", currentPage+1,datasource.count]; 
    self.timeStamp_1.text =[DateTimeHelper  convertNSNumberToDate:recordEntity.timeStampInserted withTime:TRUE ];
     
   
}


-(BOOL)canBecomeFirstResponder
{
    return YES;
}


#pragma mark ----- Responder -----
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
 //   NSLog(@"touches Began !!");
    // タッチした位置を保存
    touchBegan_ = [[touches anyObject] locationInView:self.view];
    // ラベルの元の位置を保存
    originalCentrePoint_ = self.view.center;
    // 動く方向を初期化
    direction_ = kSlideNone;
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    static const NSInteger kNeedMove = 10;
    CGPoint point = [[touches anyObject] locationInView:self.view];
    // はじめにタッチした位置と、現在の位置の差を取得
    NSInteger distanceHorizontal = point.x - touchBegan_.x;
    NSInteger distanceVertical = point.y - touchBegan_.y;
    
  //  NSLog(@"distanceHorizontal=%d", distanceHorizontal);
    
    if ( kSlideNone == direction_ ) {
        // 動く方向の決定
        if ( ABS( distanceHorizontal ) > ABS( distanceVertical )  ) {
            // 横方向に動く
            if ( kNeedMove <= ABS( distanceHorizontal ) ) {
                direction_ = kSlideHorizontal;
            } 
        } else {
            // 縦方向に動く
            if ( kNeedMove <= ABS( distanceVertical ) ) {
         //       direction_ = kSlideVertical;
            } 
        }
    }
    if ( kSlideNone != direction_ ) {
        // 動く距離の決定
        CGPoint newPoint = originalCentrePoint_;
        if ( kSlideHorizontal == direction_ ) {
            newPoint.x += distanceHorizontal;
        } else {
            newPoint.y += distanceVertical;
        }
        // 移動の適用
        self.view.center = newPoint;
    }
    // move to the lower
    if (distanceHorizontal > 50) {
        [self nextTransition:FALSE];
        
    }else if (distanceHorizontal < -50){
        [self nextTransition:TRUE];
    }
        
//    NSLog(@"currentPage=%d",currentPage);
    
}


- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    // 指を話したらラベルが元の位置に戻る
    [UIView beginAnimations:nil context:nil];
    self.view.center = originalCentrePoint_;
    [UIView commitAnimations];
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event {
    [self touchesEnded:touches withEvent:event];
}

- (void)suspend {
    [self touchesCancelled:nil withEvent:nil];
}



-(void)performTransition:(NSString*) transitionType
{
    
	// First create a CATransition object to describe the transition
	CATransition *transition = [CATransition animation];
	// Animate over 3/4 of a second
	transition.duration = kTransitionDuration;
	// using the ease in/out timing function
	transition.timingFunction = [CAMediaTimingFunction functionWithName:  kCAMediaTimingFunctionDefault];
	transition.type = kCATransitionPush;
	transition.subtype = transitionType;

	// Finally, to avoid overlapping transitions we assign ourselves as the delegate for the animation and wait for the
	// -animationDidStop:finished: message. When it comes in, we will flag that we are no longer transitioning.
	transitioning = YES;
    transition.delegate = self;
	
	// Next add it to the containerView's layer. This will perform the transition based on how we change its contents.
    [self.view.layer addAnimation:transition forKey:nil];
	
	// Here we hide view1, and show view2, which will cause Core Animation to animate view1 away and view2 in.
	self.transactionDetailView_1.hidden = YES;
	self.transactionDetailView_2.hidden = NO;
	
    
	// And so that we will continue to swap between our two images, we swap the instance variables referencing them.
	UIView *tmp = self.transactionDetailView_2;
	self.transactionDetailView_2 = self.transactionDetailView_1;
	self.transactionDetailView_1 = tmp;
    
}

-(void)updateTransactionDetailForNextView 
{
 
    StatementRecordEntity* recordEntity = [datasource objectAtIndex:currentPage];
    self.amount_2.text=   [[formatter stringFromNumber:recordEntity.amount] stringByAppendingString:@" pt."];   
    UILabel* lblTemp = self.amount_2;
    self.amount_2= self.amount_1 ;
    self.amount_1 =lblTemp ;
 
    self.account_2.text=  [recordEntity account];
    UILabel* lblTemp2 = self.account_2;
    self.account_2= self.account_1 ;
    self.account_1 =lblTemp2 ;
    
    self.narrative_2.text=  [recordEntity narrative];
    UILabel* lblTemp3 = self.narrative_2;
    self.narrative_2= self.narrative_1 ;
    self.narrative_1 =lblTemp3 ;
    
    self.page_2.text=  [NSString stringWithFormat:@"%d/%d", currentPage+1,datasource.count]; 
    UILabel* lblTemp4 = self.page_2;
    self.page_2= self.page_1 ;
    self.page_1 =lblTemp4 ;
    
    self.timeStamp_1.text=  [DateTimeHelper  convertNSNumberToDate:recordEntity.timeStampInserted withTime:TRUE ];
    UILabel* lblTemp5 = self.timeStamp_2;
    self.timeStamp_2= self.timeStamp_1 ;
    self.timeStamp_1 =lblTemp5 ;
    
    
}


-(void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
	self.transitioning = NO;
}

-(void)nextTransition:(BOOL)isIncrement  
{
	if(!self.transitioning){
        if (isIncrement){
            if (++currentPage >= [datasource count]){
                currentPage = [datasource count]-1;   
            }else{
               [self performTransition:kCATransitionFromRight];
            }
        }else{
            if (--currentPage < 0 ){
                currentPage = 0;
            }else{
                [self performTransition:kCATransitionFromLeft];
            }
        }
        [self updateTransactionDetailForNextView];
 	}
}



@end
