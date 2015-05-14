//
//  Form.h
//  TypeForm
//
//  Created by Steven Schofield on 14/05/2015.
//  Copyright (c) 2015 Nuwe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Form : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray *fields;
@property (strong, nonatomic) NSString *typeformID;
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSMutableArray *links;

@end
