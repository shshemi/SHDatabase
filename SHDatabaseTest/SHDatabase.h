//
//  SHDatabase.h
//  SHDatabase
//
//  Created by Shayan on 6/10/14.
//  Copyright (c) 2014 Shayan Hashemi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHResultSet.h"

@class SHDatabase;

typedef void(^SHDatabaseInitBlock)(SHDatabase* db);

@interface SHDatabase : NSObject
/**
 *  Path to database file
 */
@property (strong,nonatomic) NSString* databasePath;
/**
 *  Open a database in application's main bundle
 *
 *  @param name      Name of database file in application bundle
 *  @param extention Extention of database file in application bundle
 *
 *  @return An OPENED database connected to application bundle database
 */
+(SHDatabase*)openDatabaseInMainBundleWithName:(NSString*)name andExtention:(NSString*)extention;
/**
 *  Copy (if needed) the application to documents directory and then open it from there
 *
 *  @param name      Name of database file in application bundle
 *  @param extention Extention of database file in application bundle
 *
 *  @return An OPENED database connected to the copied file in application's documents directory
 */
+(SHDatabase*)copyAndOpenDatabaseFromMainBundleWithName:(NSString*)name andExtention:(NSString*)extention;
/**
 *  Copy (if needed) the application to documents directory and then open it from there with a version controller that let's you use new databases from applicaion's bundle
 *
 *  @param name      Name of database file in application bundle
 *  @param extention Extenstion of database file in application bundle
 *  @param version   Version of database (cannot be less than 0)
 *
 *  @return An OPENED database object connected to the copied file in applicaiton's documents directory
 */
+(SHDatabase*)copyAndOpenDatabaseFromMainBundleWithName:(NSString*)name extention:(NSString*)extention andVersion:(unsigned int)version;
/**
 *  Create (if needed) a database file in given path
 *
 *  @param path Path of database file
 *
 *  @return An OPENED database object connected to the file at given path
 */
+(SHDatabase*)openOrCreateDatabaseWithPath:(NSString*)path;
/**
 *  Managed database is a database that SHDatabase manage the file for you and you just provide a name in order to use it, Obviously you have to use same name to access the same database.
 *
 *  @param name Name of managed database
 *
 *  @return An OPENED database object connected to managed database
 */
+(SHDatabase*)openOrCreateManagedDatabaseWithName:(NSString*)name;
/**
 *  Same as openOrCreateDatabaseWithPath: but it let you run code at init (creating) time of database to create your tables and insert needed rows
 *
 *  @param name  Name of managed database
 *  @param block SHDatabaseInitBlock the runs at init time of database
 *
 *  @return An OPENED database object connected to managed database
 */
+(SHDatabase*)openOrCreateManagedDatabaseWithName:(NSString*)name andInitBlock:(SHDatabaseInitBlock)block;
/**
 *  Create a sqlite database in randmo access memory in order to fast sql aciton (SELECT,INSERT,UPDATE and...).
    WARINING:The database will be deleted when the application terminates.
 *
 *  @return An OPENED database created in memory
 */
+(SHDatabase*)createAndOpenDatabaseInMemory;
/**
 *  Get the last error of database
 *
 *  @return Last error of database
 */
+(NSError*)lastError;
/**
 *  Open the database
 *
 *  @return Weather the database opened successfully or not
 */
-(BOOL)open;
/**
 *  Close the database, This method will be called automatically when the database is released from memory
 */
-(void)close;
/**
 *  Execute a querry on database and return a result set
 *
 *  @param query Query to execute
 *
 *  @return Result set of a query
 */
-(SHResultSet*)executeQuery:(NSString*)query;
/**
 *  Execute a command on database adn return a boolean to indicates wather the command executed successfully or not
 *
 *  @param command Command to execute
 *
 *  @return Boolean to indicates weather the command executed successfully
 */
-(BOOL)execute:(NSString*)command;
@end
