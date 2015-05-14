//
//  Form.h
//  TypeForm
//
//  Created by Steven Schofield on 14/05/2015.
//  Copyright (c) 2015 Nuwe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Form : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray *fields;
@property (strong, nonatomic) NSString *typeformID;
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSMutableArray *links;
@property (strong, nonatomic) NSString *url;

+ (NSString *) parseClassName;
+ (void)allForms:(void (^)(NSMutableArray *forms))completion;
- (void)ensureFields:(void (^)(NSMutableArray *fields))completion;
- (void)ensureLinks:(void (^)(NSMutableArray *links))completion;

@end

