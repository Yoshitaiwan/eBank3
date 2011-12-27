//
//  AccountStatementTransactionView.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 26/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AccountStatementTransactionView.h"

@implementation AccountStatementTransactionView

- (void)viewDidLoad
{
    self.userInteractionEnabled = YES; 
}

/*// this hitTest needs to be deleted later. this is only for me to understand this method
-(UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event {  
   UIView *hitView = [super hitTest:point withEvent:event];
     
    return (hitView == self) ? nil : hitView;
}
*/

#pragma mark ----- Responder -----
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    NSLog(@"touches Began !!");
    // タッチした位置を保存
    touchBegan_ = [[touches anyObject] locationInView:self];
    // ラベルの元の位置を保存
    originalCentrePoint_ = self.center;
    // 動く方向を初期化
    direction_ = kSlideNone;
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    static const NSInteger kNeedMove = 10;
    CGPoint point = [[touches anyObject] locationInView:self];
    // はじめにタッチした位置と、現在の位置の差を取得
    NSInteger distanceHorizontal = point.x - touchBegan_.x;
    NSInteger distanceVertical = point.y - touchBegan_.y;
    
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
        self.center = newPoint;
    }
}


- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    // 指を話したらラベルが元の位置に戻る
    [UIView beginAnimations:nil context:nil];
    self.center = originalCentrePoint_;
    [UIView commitAnimations];
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event {
    [self touchesEnded:touches withEvent:event];
}

- (void)suspend {
    [self touchesCancelled:nil withEvent:nil];
}



@end
