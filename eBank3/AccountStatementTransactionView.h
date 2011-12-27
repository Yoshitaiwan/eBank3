//
//  AccountStatementTransactionView.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 26/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    kSlideNone,
    kSlideHorizontal,
    kSlideVertical,
} DirectionForSlide;

@interface AccountStatementTransactionView : UIView
{
@private
    CGPoint touchBegan_;
    CGPoint originalCentrePoint_;
    
    DirectionForSlide direction_;

}
@end
