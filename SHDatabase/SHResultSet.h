//
//  SHResultSet.h
//  SHDatabase
//
//  Created by Shayan on 6/10/14.
//  Copyright (c) 2014 Shayan Hashemi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
typedef enum{
    kSHSqliteColumnTypeInteger = 1,
    kSHSqliteColumnTypeFloat = 2,
    kSHSqliteColumnTypeBlob = 4,
    kSHSqliteColumnTypeText = 3,
    kSHSqliteColumnTypeNull = 5,
} SHSqliteColumnType;

@interface SHResultSet : NSObject

//init methods
- (id)initWithStatement:(sqlite3_stmt*)stmnt;

//moving methods
-(BOOL)next;

//close method
-(void)close;

//data fetching methods
-(NSString*)stringForColumnIndex:(int)columntIndex;
-(NSData*)dataForColumnIndex:(int)columnIndex;
-(int)intForColumnIndex:(int)columnIndex;
-(double)doubleForColumnIndex:(int)columnIndex;
-(long long)longForColumnIndex:(int)columnIndex;

//column type & name
-(int)columnTypeForColumnIndex:(int)columnIndex;
-(NSString*)columnNameForColumnIndex:(int)columnIndex;

@property (nonatomic,readonly,getter = columnCount) int columntCount;

@end
