//
//  StatementGroupEntity.h
//  eBank4
//
//  Created by Yoshiyuki Matsuoka on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class StatementRecordEntity;

@interface StatementGroupEntity : NSManagedObject

@property (nonatomic, retain) NSSet *records;
@end

@interface StatementGroupEntity (CoreDataGeneratedAccessors)

- (void)addRecordsObject:(StatementRecordEntity *)value;
- (void)removeRecordsObject:(StatementRecordEntity *)value;
- (void)addRecords:(NSSet *)values;
- (void)removeRecords:(NSSet *)values;

@end
