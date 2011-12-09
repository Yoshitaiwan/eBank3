//
//  RecordEntity.h
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 9/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RecordEntity : NSManagedObject

@property (nonatomic, retain) NSString * account;
@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSString * narrative;
@property (nonatomic, retain) NSNumber * timeStampInserted;
@property (nonatomic, retain) NSNumber * accumBal;

@end
