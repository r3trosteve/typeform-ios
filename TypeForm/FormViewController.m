//
//  FormViewController.m
//  TypeForm
//
//  Created by Steven Schofield on 14/05/2015.
//  Copyright (c) 2015 Nuwe. All rights reserved.
//

#import "FormViewController.h"
#import "Form.h"
#import "CreateFormViewController.h"

@interface FormViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *formView;
@property (strong, nonatomic) NSURL *url;

@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_form) {
        [self loadForm];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadForm {
    _url = [NSURL URLWithString:_form.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [_formView loadRequest:request];
    _formView.delegate = self;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"editForm"]) {
        CreateFormViewController *createFormVC = (CreateFormViewController *)segue.destinationViewController;
        createFormVC.form = _form;
    }
}

- (IBAction)closeWasPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
