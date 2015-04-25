//
//  SHResultSet.h
//  SHDatabase
//
//  Created by Shayan on 6/10/14.
//  Copyright (c) 2014 Shayan Hashemi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
/**
 *  Custom data type based on sqlite database types
 */
typedef enum{
    kSHSqliteColumnTypeInteger = 1,
    kSHSqliteColumnTypeFloat = 2,
    kSHSqliteColumnTypeBlob = 4,
    kSHSqliteColumnTypeText = 3,
    kSHSqliteColumnTypeNull = 5,
} SHSqliteColumnType;
/**
 The results of a query will be saved and fetched from ResultSet object
 */
@interface SHResultSet : NSObject

//init methods
/**
 *  Initialize an object with sqlite3_stmt, You usually dont need to use it in your code and will be called internally
 *
 *  @param stmnt sqlite3_stmt object
 *
 *  @return self object
 */
- (instancetype)initWithStatement:(sqlite3_stmt*)stmnt;

//moving methods
/**
 *  Move to next record(row) of database
 *
 *  @return A boolean to determined weather the result set has a new record (row) or not, NO value mean that current item is nil
 */
-(BOOL)next;

//close method
/**
 *  Close the database connection
 */
-(void)close;

//data fetching methods
/**
 *  Get the string value of given column
 *
 *  @param columntIndex Index of column
 *
 *  @return String value of column
 */
-(NSString*)stringForColumnIndex:(int)columntIndex;
/**
 *  Get the data value of given column
 *
 *  @param columnIndex Index of column
 *
 *  @return Data(NSData) value of column
 */
-(NSData*)dataForColumnIndex:(int)columnIndex;
/**
 *  Get the int value of given column
 *
 *  @param columnIndex Index of column
 *
 *  @return Int value of column
 */
-(int)intForColumnIndex:(int)columnIndex;
/**
 *  Get the double value of given column
 *
 *  @param columnIndex Index of column
 *
 *  @return Double value of column
 */
-(double)doubleForColumnIndex:(int)columnIndex;
/**
 *  Get the long value of given column
 *
 *  @param columnIndex Index of column
 *
 *  @return Long value of column
 */
-(long long)longForColumnIndex:(int)columnIndex;
/**
 *  Get a dictionary with a keys of column names and values of column values of the keys
 *
 *  @return Dictionary with key-value for row
 */
-(NSDictionary*)dictionaryForCurrentRow;
/**
 *  Get a generic type id for given column
 *
 *  @param columnIndex Index of column
 *
 *  @return Generic type value of column
 */
-(id)valueForColumnIndex:(int)columnIndex;

//column type & name
/**
 *  Get the type of column for given column
 *
 *  @param columnIndex Index of column
 *
 *  @return The column type
 */
-(SHSqliteColumnType)columnTypeForColumnIndex:(int)columnIndex;
/**
 *  Get the name of column for given column
 *
 *  @param columnIndex Index of column
 *
 *  @return The column name
 */
-(NSString*)columnNameForColumnIndex:(int)columnIndex;
/**
 *  Get the number of column for current row(result set)
 */
@property (nonatomic,readonly) int columnCount;

@end
