//
//  CreateFieldViewController.m
//  TypeForm
//
//  Created by Steven Schofield on 14/05/2015.
//  Copyright (c) 2015 Nuwe. All rights reserved.
//

#import "CreateFieldViewController.h"
#import "Form.h"
#import "Field.h"

@interface CreateFieldViewController ()

@property (weak, nonatomic) IBOutlet UILabel *formTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *questionTextField;
@property (weak, nonatomic) IBOutlet UITextField *questionTypeTextField;

@end

@implementation CreateFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     // Do any additional setup after loading the view.
    
    if (_form) {
        _formTitleLabel.text = _form.title;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) dissmissSelf {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) insertNewQuestion {
    Field *field = [Field object];
    field.form = _form;
    field.question = _questionTextField.text;
    field.type = _questionTypeTextField.text;
    
    [field saveInBackground];
    [_form ensureFields:^(NSMutableArray *fields) {
        [fields addObject:field];
        
        [self dissmissSelf];
    }];
    
}

- (IBAction)saveQuestionWasPressed:(id)sender {
    [self insertNewQuestion];
    
}
- (IBAction)closeQuestionWasPressed:(id)sender {
    [self dissmissSelf];
}

@end
