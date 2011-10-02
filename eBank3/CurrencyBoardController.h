//
//  CurrencyBoardController.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 27/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyBoardController : UITableViewController
{
  @private  
    NSArray* details_;    
    NSMutableArray* images_;
    NSDictionary* dataSource_;
    
    UIView* currencyInputView_;
    UILabel* shopName_;
    UIImageView* shopImage_;
    
    BOOL transitioning;
}

@property(nonatomic, retain) IBOutlet UIView* currentInputView;
@property(nonatomic,retain) IBOutlet UILabel* shopName;
@property(nonatomic,retain) IBOutlet UIImageView* shopImage;

@property BOOL transitioning;


- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier;
- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;

@end
