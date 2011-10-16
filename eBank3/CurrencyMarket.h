//
//  CurrencyMarket.h
//  currencyboard
//
//  Created by Yoshiyuki Matsuoka on 16/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrencyMarketCell.h"
@interface CurrencyMarket : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    @private
    CurrencyMarketCell* ccyMarketCell_ ;
}

@property(nonatomic,retain) IBOutlet UITableViewCell* ccyMarketCell;  

@end
