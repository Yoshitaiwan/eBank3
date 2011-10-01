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
}

- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier;
- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;

@end
