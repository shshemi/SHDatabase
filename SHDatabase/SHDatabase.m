//
//  SHDatabase.m
//  SHDatabase
//
//  Created by Shayan on 6/10/14.
//  Copyright (c) 2014 Shayan Hashemi. All rights reserved.
//
#import <sqlite3.h>
#import "SHDatabase.h"

static NSError* _lastError;
@implementation SHDatabase{
    sqlite3 *db;
}
+(SHDatabase*)openDatabaseInMainBundleWithName:(NSString*)name andExtention:(NSString*)extention{
    SHDatabase *db=[[SHDatabase alloc]init];
    db.databasePath=[[NSBundle mainBundle]pathForResource:name ofType:extention];
    [db open];
    return db;
}
+(SHDatabase*)copyAndOpenDatabaseFromMainBundleWithName:(NSString*)name andExtention:(NSString*)extention{
    NSString *source=[[NSBundle mainBundle]pathForResource:name ofType:extention];
    NSString *dirInDomain=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *dest=[dirInDomain stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.shdb",name]];
    [self copyFileFrom:source  to:dest];
    SHDatabase *db=[[SHDatabase alloc]init];
    db.databasePath=dest;
    [db open];
    return db;
}
+(SHDatabase*)copyAndOpenDatabaseFromMainBundleWithName:(NSString*)name extention:(NSString *)extention andVersion:(unsigned int)version{
    NSString *source=[[NSBundle mainBundle]pathForResource:name ofType:extention];
    NSString *dirInDomain=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *dest=[dirInDomain stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%i.shdb",name,version]];
    [self copyFileFrom:source  to:dest];
    SHDatabase *db=[[SHDatabase alloc]init];
    db.databasePath=dest;
    [db open];
    return db;
}
+(SHDatabase*)openOrCreateDatabaseWithPath:(NSString*)path{
    SHDatabase *db=[[SHDatabase alloc]init];
    db.databasePath=path;
    [self createFileIfneededAt:path];
    [db open];
    return db;
    
}
+(SHDatabase*)openOrCreateManagedDatabaseWithName:(NSString*)name{
    NSString *fileName=[NSString stringWithFormat:@"%@.shdb",name];
    NSString *dirName=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    SHDatabase *db=[[SHDatabase alloc]init];
    db.databasePath=[dirName stringByAppendingPathComponent:fileName];
    [self createFileIfneededAt:db.databasePath];
    [db open];
    return db;
}
+(SHDatabase*)openOrCreateManagedDatabaseWithName:(NSString*)name andInitBlock:(SHDatabaseInitBlock)block{
    NSString *fileName=[NSString stringWithFormat:@"%@.shdb",name];
    NSString *dirName=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    SHDatabase *db=[[SHDatabase alloc]init];
    db.databasePath=[dirName stringByAppendingPathComponent:fileName];
    BOOL firstTime = [self createFileIfneededAt:db.databasePath];
    [db open];
    if (firstTime) {
        block(db);
    }
    return db;
}
+(SHDatabase*)createAndOpenDatabaseInMemory{
    SHDatabase *db=[[SHDatabase alloc]init];
    db.databasePath=@":memory:";
    [db open];
    return db;
}
+(NSError *)lastError{
    return _lastError;
}

-(BOOL)open{
    int result = sqlite3_open([_databasePath UTF8String], &db);
    if(result != SQLITE_OK){
        [SHDatabase setLastErrorWithCode:result andDescription:@"Unable to open database,the database file may be corrupted"];
        return false;
    }
    return  true;
}
-(void)close{
    sqlite3_close(db);
}
-(SHResultSet*)executeQuery:(NSString*)query{
    sqlite3_stmt *stmt;
    int result = sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, NULL);
    if( result == SQLITE_OK){
        return [[SHResultSet alloc]initWithStatement:stmt];
    }else{
        [SHDatabase setLastErrorWithCode:result andDescription:@"Unable to prepare query double check the syntex and try again"];
        return nil;
    }
}
-(BOOL)execute:(NSString*)command{
    char *err;
    return sqlite3_exec(db, [command UTF8String], NULL, NULL, &err);
}

#pragma mark - Overrited From NSObject
-(void)dealloc{
    [self close];
}

#pragma mark - Helper Private Functions
+(void)setLastErrorWithCode:(int)code andDescription:(NSString*)error{
    _lastError = [NSError errorWithDomain:@"" code:code userInfo:@{NSLocalizedDescriptionKey:error}];
}
+(BOOL)createFileIfneededAt:(NSString*)path{
    NSFileManager *fManager=[NSFileManager defaultManager];
    if(![fManager fileExistsAtPath:path]){
        [fManager createFileAtPath:path contents:nil attributes:nil];
        return YES;
    }
    return NO;
}
+(void)copyFileFrom:(NSString*)source to:(NSString*)dest{
    NSFileManager *fManager=[NSFileManager defaultManager];
    if(![fManager fileExistsAtPath:dest]){
        NSError* err;
        [fManager copyItemAtPath:source toPath:dest error:&err];
        _lastError = err;
    }else{
        //        _lastError = nil;
    }
}
@end
