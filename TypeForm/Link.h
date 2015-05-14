//
//  Link.h
//  TypeForm
//
//  Created by Steven Schofield on 14/05/2015.
//  Copyright (c) 2015 Nuwe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class Form;

@interface Link : PFObject <PFSubclassing>

@property (strong, nonatomic) Form *form;
@property (strong, nonatomic) NSString *url;

+ (void) load;
+ (NSString *) parseClassName;

@end
