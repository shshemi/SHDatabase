//
//  ViewController.h
//  SHDatabaseTest
//
//  Created by Shayan on 4/24/15.
//  Copyright (c) 2015 Shayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHDatabase.h"

@interface BaseSQLViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *commandTextField;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
@property (strong,nonatomic) SHDatabase *database;

@end

