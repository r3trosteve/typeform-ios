//
//  CreateFormViewController.m
//  TypeForm
//
//  Created by Steven Schofield on 14/05/2015.
//  Copyright (c) 2015 Nuwe. All rights reserved.
//

#import <Parse/Parse.h>
#import "CreateFormViewController.h"
#import "Form.h"
#import "Field.h"
#import "CreateFieldViewController.h"
#import "BaseApi.h"

@interface CreateFormViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UIButton *addQuestionButton;
@property (strong, nonatomic) IBOutlet UIButton *saveFormButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *fields;

@end

@implementation CreateFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    if (_form != nil) {
        [self getLatestFields];
        _titleTextField.text = _form.title;
    }
    
    [self.tableView reloadData];
    
}

- (void) getLatestFields {
    [_form ensureFields:^(NSMutableArray *fields) {
        _fields = fields;
        [self.tableView reloadData];
    }];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getLatestFields];
    [_titleTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"addQuestionSegue"]) {
        CreateFieldViewController *createFieldVC = segue.destinationViewController;
        createFieldVC.form = _form;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return _fields.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Field *field = _fields[indexPath.row];
    cell.textLabel.text = field.question;
    cell.detailTextLabel.text = field.type;
    
    return cell;
}


- (void) insertNewForm {
    Form *form = [Form object];
    form.title = _titleTextField.text;
    form.url = @"https://forms.typeform.io/to/CT7ei6huux2Ltw";
    [form saveInBackgroundWithBlock: ^(BOOL succeeded, NSError *error) {
        _form = form;
        if (_form) {
            if ([_form.fields firstObject]) {
                [self createTypeFormRemote];
            }
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your Form Was Created" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }];
}


- (void) createTypeFormRemote {
    
    // implement POST request to typeform in this method or move this to the From Class ideally.
    NSString *url = [NSString stringWithFormat:@"%@", kFormApi];
   
    // Create the array of Field Dictionaires
    NSMutableArray *fieldsArray = [[NSMutableArray alloc] init];
    for (Field * field in _form.fields) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@", field.question], @"question", [NSString stringWithFormat:@"%@", field.type], @"type", nil];
        [fieldsArray addObject:dict];
    }
    NSArray *fields = [fieldsArray copy];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_form.title, @"title", fields, @"fields",  nil];
    
    [[BaseApi client] postJSONWithURL:url Param:params onSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Handle Success
        
        NSLog(@"%@", responseObject);
    } onError:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle Error
        NSLog(@"%@", error);
    }];
}

- (void) updateForm {
    _form.title = _titleTextField.text;
}

- (void) dissmissSelf {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)closeWasPressed:(id)sender {
    [self dissmissSelf];
}
- (IBAction)saveFormWasPressed:(id)sender {
    if (_form != nil) {
        if (_form.uid == nil) {
            [self createTypeFormRemote];
        }
        [self updateForm];
        
        
        [self dissmissSelf];
    } else {
        [self insertNewForm];
    }
    
}
- (IBAction)addQuestionButtonWasPressed:(id)sender {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

@end
