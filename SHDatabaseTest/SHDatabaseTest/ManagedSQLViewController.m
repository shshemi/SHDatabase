//
//  ManagedSQLViewController.m
//  SHDatabaseTest
//
//  Created by Shayan on 4/25/15.
//  Copyright (c) 2015 Shayan. All rights reserved.
//

#import "ManagedSQLViewController.h"

@interface ManagedSQLViewController ()

@end

@implementation ManagedSQLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)initDatabase{
    self.database = [SHDatabase openOrCreateManagedDatabaseWithName:@"MyManagedDatabase" andInitBlock:^(SHDatabase *db) {
        [db execute:@"CREATE TABLE sql_table (id integer PRIMARY KEY NOT NULL,name TEXT)"];
        [db execute:@"INSERT INTO sql_table(id,name)VALUES(1,'Shayan')"];
        [db execute:@"INSERT INTO sql_table(id,name)VALUES(2,'Ali')"];
        [db execute:@"INSERT INTO sql_table(id,name)VALUES(3,'Hassan')"];
        [db execute:@"INSERT INTO sql_table(id,name)VALUES(4,'Hossein')"];
        NSLog(@"Managed database created");
    }];
}
@end
