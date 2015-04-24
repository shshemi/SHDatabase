//
//  SHDatabase.h
//  SHDatabase
//
//  Created by Shayan on 6/10/14.
//  Copyright (c) 2014 Shayan Hashemi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SHResultSet.h"

@interface SHDatabase : NSObject
@property (strong,nonatomic) NSString* databasePath;
+(SHDatabase*)openAssetsDatabase:(NSString*)name withExtention:(NSString*)extention;
+(SHDatabase*)copyAndOpenAssetsDatabase:(NSString*)name withExtention:(NSString*)extention;
+(SHDatabase*)copyAndOpenAssetsDatabase:(NSString*)name withExtention:(NSString*)extention withVersion:(int)version;
+(SHDatabase*)openOrCreateDatabase:(NSString*)path;
+(SHDatabase*)openOrCreateManagedDatabase:(NSString*)name;
+(SHDatabase*)createAndOpenDatabaseInMemory;
+(NSError*)lastError;
-(BOOL)open;
-(void)close;
-(SHResultSet*)executeQuery:(NSString*)query;
-(BOOL)execute:(NSString*)command;
@end
