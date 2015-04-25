//
//  ViewController.m
//  SHDatabaseTest
//
//  Created by Shayan on 4/24/15.
//  Copyright (c) 2015 Shayan. All rights reserved.
//

#import "BaseSQLViewController.h"


@interface BaseSQLViewController ()

@end

@implementation BaseSQLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatabase];
}
-(void)initDatabase{
    
}
#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self clearResultText];
    [textField resignFirstResponder];
    NSString *command = textField.text;
    SHResultSet *resultSet = [_database executeQuery:command];
    if (resultSet) {
        while (resultSet.next) {
            NSString *result = [resultSet dictionaryForCurrentRow].description;
            [self addResultText:result];
        }
    }else{
        [self addResultText:[SHDatabase lastError].description];
    }
    return YES;
}
#pragma mark - User Interface Helper Methods

-(void)addResultText:(NSString*)text{
    _resultTextView.text = [_resultTextView.text stringByAppendingString:[NSString stringWithFormat:@"\n%@",text]];
}
-(void)clearResultText{
    _resultTextView.text = @"";
}

@end
