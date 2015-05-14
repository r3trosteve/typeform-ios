//
//  Link.m
//  TypeForm
//
//  Created by Steven Schofield on 14/05/2015.
//  Copyright (c) 2015 Nuwe. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>
#import "Link.h"
#import "Form.h"

@implementation Link

@dynamic form;
@dynamic url;

+ (void) load {
    [self registerSubclass];
}

+ (NSString *) parseClassName {
    return NSStringFromClass([Link class]);
}

@end
