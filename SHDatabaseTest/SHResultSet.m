//
//  SHResultSet.m
//  SHDatabase
//
//  Created by Shayan on 6/10/14.
//  Copyright (c) 2014 Shayan Hashemi. All rights reserved.
//

#import "SHResultSet.h"

@implementation SHResultSet{
    sqlite3_stmt *statement;
}

- (id)initWithStatement:(sqlite3_stmt*)stmnt
{
    self = [super init];
    if (self) {
        statement=stmnt;
    }
    return self;

}
-(BOOL)next{
    return sqlite3_step(statement)==SQLITE_ROW;
}
-(void)close{
    sqlite3_finalize(statement);
}
-(NSString*)stringForColumnIndex:(int)columnIndex{
    const unsigned char* text=sqlite3_column_text(statement, columnIndex);
    return [NSString stringWithUTF8String:text?(char*)text:""];
}
-(NSData*)dataForColumnIndex:(int)columnIndex{
    return [[NSData alloc] initWithBytes:sqlite3_column_blob(statement, columnIndex) length: sqlite3_column_bytes(statement, columnIndex)];
}
-(int)intForColumnIndex:(int)columnIndex{
    return sqlite3_column_int(statement, columnIndex);
}
-(double)doubleForColumnIndex:(int)columnIndex{
    return sqlite3_column_double(statement, columnIndex);
}
-(int) columnCount{
    return sqlite3_column_count(statement);
}
-(long long)longForColumnIndex:(int)columnIndex{
    return sqlite3_column_int64(statement, columnIndex);
}

#pragma mark - Column name and type
-(int)columnTypeForColumnIndex:(int)columnIndex{
    return sqlite3_column_type(statement, columnIndex);
}
-(NSString*)columnNameForColumnIndex:(int)columnIndex{
    const char* text=sqlite3_column_name(statement, columnIndex);
    return [NSString stringWithUTF8String:text?(char*)text:nil];
}
-(void)dealloc{
    [self close];
}
@end
