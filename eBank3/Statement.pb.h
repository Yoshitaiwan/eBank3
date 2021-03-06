// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class Record;
@class Record_Builder;
@class Statement;
@class Statement_Builder;

@interface StatementRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface Statement : PBGeneratedMessage {
@private
  NSMutableArray* mutableRecordsList;
}
- (NSArray*) recordsList;
- (Record*) recordsAtIndex:(int32_t) index;

+ (Statement*) defaultInstance;
- (Statement*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (Statement_Builder*) builder;
+ (Statement_Builder*) builder;
+ (Statement_Builder*) builderWithPrototype:(Statement*) prototype;

+ (Statement*) parseFromData:(NSData*) data;
+ (Statement*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (Statement*) parseFromInputStream:(NSInputStream*) input;
+ (Statement*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (Statement*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (Statement*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface Statement_Builder : PBGeneratedMessage_Builder {
@private
  Statement* result;
}

- (Statement*) defaultInstance;

- (Statement_Builder*) clear;
- (Statement_Builder*) clone;

- (Statement*) build;
- (Statement*) buildPartial;

- (Statement_Builder*) mergeFrom:(Statement*) other;
- (Statement_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (Statement_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (NSArray*) recordsList;
- (Record*) recordsAtIndex:(int32_t) index;
- (Statement_Builder*) replaceRecordsAtIndex:(int32_t) index with:(Record*) value;
- (Statement_Builder*) addRecords:(Record*) value;
- (Statement_Builder*) addAllRecords:(NSArray*) values;
- (Statement_Builder*) clearRecordsList;
@end

@interface Record : PBGeneratedMessage {
@private
  BOOL hasAmount_:1;
  BOOL hasTimeStampInsert_:1;
  BOOL hasAccumBal_:1;
  BOOL hasBook_:1;
  BOOL hasAccount_:1;
  BOOL hasNarrative_:1;
  int64_t amount;
  int64_t timeStampInsert;
  int64_t accumBal;
  NSString* book;
  NSString* account;
  NSString* narrative;
}
- (BOOL) hasBook;
- (BOOL) hasAccount;
- (BOOL) hasAmount;
- (BOOL) hasNarrative;
- (BOOL) hasTimeStampInsert;
- (BOOL) hasAccumBal;
@property (readonly, retain) NSString* book;
@property (readonly, retain) NSString* account;
@property (readonly) int64_t amount;
@property (readonly, retain) NSString* narrative;
@property (readonly) int64_t timeStampInsert;
@property (readonly) int64_t accumBal;

+ (Record*) defaultInstance;
- (Record*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (Record_Builder*) builder;
+ (Record_Builder*) builder;
+ (Record_Builder*) builderWithPrototype:(Record*) prototype;

+ (Record*) parseFromData:(NSData*) data;
+ (Record*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (Record*) parseFromInputStream:(NSInputStream*) input;
+ (Record*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (Record*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (Record*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface Record_Builder : PBGeneratedMessage_Builder {
@private
  Record* result;
}

- (Record*) defaultInstance;

- (Record_Builder*) clear;
- (Record_Builder*) clone;

- (Record*) build;
- (Record*) buildPartial;

- (Record_Builder*) mergeFrom:(Record*) other;
- (Record_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (Record_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasBook;
- (NSString*) book;
- (Record_Builder*) setBook:(NSString*) value;
- (Record_Builder*) clearBook;

- (BOOL) hasAccount;
- (NSString*) account;
- (Record_Builder*) setAccount:(NSString*) value;
- (Record_Builder*) clearAccount;

- (BOOL) hasAmount;
- (int64_t) amount;
- (Record_Builder*) setAmount:(int64_t) value;
- (Record_Builder*) clearAmount;

- (BOOL) hasNarrative;
- (NSString*) narrative;
- (Record_Builder*) setNarrative:(NSString*) value;
- (Record_Builder*) clearNarrative;

- (BOOL) hasTimeStampInsert;
- (int64_t) timeStampInsert;
- (Record_Builder*) setTimeStampInsert:(int64_t) value;
- (Record_Builder*) clearTimeStampInsert;

- (BOOL) hasAccumBal;
- (int64_t) accumBal;
- (Record_Builder*) setAccumBal:(int64_t) value;
- (Record_Builder*) clearAccumBal;
@end

