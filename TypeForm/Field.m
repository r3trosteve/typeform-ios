//
//  Field.m
//  TypeForm
//
//  Created by Steven Schofield on 14/05/2015.
//  Copyright (c) 2015 Nuwe. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>
#import "Field.h"

@implementation Field

@dynamic form;
@dynamic type;
@dynamic question;

+ (void) load {
    [self registerSubclass];
}

+ (NSString *) parseClassName {
    return NSStringFromClass([Field class]);
}

@end
