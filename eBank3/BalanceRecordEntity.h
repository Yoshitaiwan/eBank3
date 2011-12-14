//
//  BalanceRecordEntity.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 13/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BalanceRecordEntity : NSManagedObject

@property (nonatomic, retain) NSString * account;
@property (nonatomic, retain) NSNumber * accumBal;
@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSNumber * timeStampInserted;

@end
