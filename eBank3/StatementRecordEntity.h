//
//  StatementRecordEntity.h
//  eBank4
//
//  Created by Yoshiyuki Matsuoka on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface StatementRecordEntity : NSManagedObject

@property (nonatomic, retain) NSString * account;
@property (nonatomic, retain) NSNumber * accumBal;
@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSString * book;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * narrative;
@property (nonatomic, retain) NSNumber * timeStampInserted;

@end
