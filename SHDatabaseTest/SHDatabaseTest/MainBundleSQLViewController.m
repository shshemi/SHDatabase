//
//  MainBundleSQLViewController.m
//  SHDatabaseTest
//
//  Created by Shayan on 4/25/15.
//  Copyright (c) 2015 Shayan. All rights reserved.
//

#import "MainBundleSQLViewController.h"

@interface MainBundleSQLViewController ()

@end

@implementation MainBundleSQLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)initDatabase{
    self.database = [SHDatabase copyAndOpenDatabaseFromMainBundleWithName:@"MyDatabase" andExtention:@"db"];
}
@end
