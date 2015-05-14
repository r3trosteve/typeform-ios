//
//  Form.m
//  TypeForm
//
//  Created by Steven Schofield on 14/05/2015.
//  Copyright (c) 2015 Nuwe. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>
#import "Form.h"
#import "Field.h"
#import "Link.h"

@implementation Form

@synthesize fields = _fields;
@synthesize links = _links;

@dynamic title;
@dynamic typeformID;
@dynamic uid;
@dynamic url;

+ (void) load {
    [self registerSubclass];
}

+ (NSString *) parseClassName {
    return NSStringFromClass([Form class]);
}

+ (void) allForms:(void (^)(NSMutableArray *forms))completion {
    PFQuery *query = [PFQuery queryWithClassName:[Form parseClassName]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (completion) completion([objects mutableCopy]);
    }];
}

- (void)ensureFields:(void (^)(NSMutableArray *fields))completion
{
    if (_fields) {
        if (completion) completion(_fields);
    } else {
        PFQuery *query = [PFQuery queryWithClassName:[Field parseClassName]];
        [query whereKey:NSStringFromSelector(@selector(form)) equalTo:self];
        __weak typeof(self) wSelf = self;
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            __strong typeof(self) sSelf = wSelf;
            sSelf.fields = [NSMutableArray array];
            [sSelf.fields addObjectsFromArray:objects];
            
            if (completion) completion(sSelf.fields);
        }];
    }
}

- (void)ensureLinks:(void (^)(NSMutableArray *links))completion
{
    if (_links) {
        if (completion) completion(_fields);
    } else {
        PFQuery *query = [PFQuery queryWithClassName:[Link parseClassName]];
        [query whereKey:NSStringFromSelector(@selector(form)) equalTo:self];
        __weak typeof(self) wSelf = self;
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            __strong typeof(self) sSelf = wSelf;
            sSelf.links = [NSMutableArray array];
            [sSelf.links addObjectsFromArray:objects];
            
            if (completion) completion(sSelf.links);
        }];
    }
}

@end
