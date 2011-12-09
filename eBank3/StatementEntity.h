//
//  StatementEntity.h
//  pbtest
//
//  Created by Yoshiyuki Matsuoka on 28/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RecordEntity;

@interface StatementEntity : NSManagedObject

@property (nonatomic, retain) NSSet *records;
@end

@interface StatementEntity (CoreDataGeneratedAccessors)

- (void)addRecordsObject:(RecordEntity *)value;
- (void)removeRecordsObject:(RecordEntity *)value;
- (void)addRecords:(NSSet *)values;
- (void)removeRecords:(NSSet *)values;

@end
