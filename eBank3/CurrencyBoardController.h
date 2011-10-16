//
//  CurrencyBoardController.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 27/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyBoardController : UITabBarController
{
  @private  
    NSArray* details_;    
    NSMutableArray* images_;
    NSDictionary* dataSource_;
    
    UIView* currencyInputView_;
    
    BOOL transitioning;
    
}

@property(nonatomic, retain) IBOutlet UIView* currentInputView;

@property BOOL transitioning;
-(void) buttonClicked:(id)sender;

@end
