//
//  BaseApi.m
//  TypeForm
//
//  Created by Steven Schofield on 14/05/2015.
//  Copyright (c) 2015 Nuwe. All rights reserved.
//

#import "BaseApi.h"
#import "Defines.h"

@implementation NSDictionary (Utility)

// in case of [NSNull null] values a nil is returned ...
- (id)objectForKeyNotNull:(id)key {
    id object = [self objectForKey:key];
    if (object == [NSNull null])
        return nil;
    
    return object;
}

@end


@implementation BaseApi

+ (BaseApi *) client
{
    static BaseApi * staticInstance = nil;
    
    if ( !staticInstance )      // Initialize base client
    {
        staticInstance = [[BaseApi alloc] init];
    }
    
    return staticInstance;
}

- (void) getJSONWithURL: (NSString*) url
                  Param: (id) params
              onSuccess: (ResponseSuccessBlock) successBlock
                onError: (ResponseFailBlock) errorBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [manager.requestSerializer setValue:[NSString stringWithFormat:TYPEFORM_API_KEY ] forHTTPHeaderField:@"x-api-token"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"get Json: %@", responseObject);
        successBlock(operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"get JSON error: %@", error);
        
        errorBlock(operation, error);
    }];
}

- (void) postJSONWithURL: (NSString*) url
                   Param: (id) params
               onSuccess: (ResponseSuccessBlock) successBlock
                 onError: (ResponseFailBlock) errorBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:TYPEFORM_API_KEY ] forHTTPHeaderField:@"x-api-token"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"get Json: %@", responseObject);
        successBlock(operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"get JSON error: %@", error);
        
        errorBlock(operation, error);
    }];
}


@end
