//
//  BaseApi.h
//  TypeForm
//
//  Created by Steven Schofield on 14/05/2015.
//  Copyright (c) 2015 Nuwe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

#import "Form.h"

#define kFormApi @"https://api.typeform.io/v0.1/forms"

typedef  void (^ResponseSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef  void (^ResponseFailBlock)(AFHTTPRequestOperation *operation, NSError * error);

@interface NSDictionary (Utility)

- (id)objectForKeyNotNull:(id)key;

@end

@interface BaseApi : NSData

+ (BaseApi *) client;

- (void) postJSONWithURL: (NSString*) url
                   Param: (id) params
               onSuccess: (ResponseSuccessBlock) successBlock
                 onError: (ResponseFailBlock) errorBlock;

- (void) getJSONWithURL: (NSString*) url
                  Param: (id) params
              onSuccess: (ResponseSuccessBlock) successBlock
                onError: (ResponseFailBlock) errorBlock;

@end
