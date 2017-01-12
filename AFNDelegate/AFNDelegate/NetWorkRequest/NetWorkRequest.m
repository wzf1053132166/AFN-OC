//
//  NetWorkRequest.m
//  startogether
//
//  Created by wangzhifei on 12-11-26.
//  Copyright (c) 2016年 bailey. All rights reserved.


#import "NetWorkRequest.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "NSArray+Extend.h"

#define NetworkTimeoutTime 10

@implementation NetWorkRequest

#pragma mark - For Server

#pragma mark -- get请求
+(void)netWorkRequestByGetMode:(NSString*)url parameters:(NSMutableDictionary *)getparameters requestName:(NSString*)getRequestName delegate:(id)getDelegate{
    
    NSString *getUrl = nil;
    
    getUrl = url;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = NetworkTimeoutTime;
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager setSecurityPolicy:[self customSecurityPolicy]];
 
    [manager.requestSerializer setValue: [NSString stringWithFormat:@"Token %@", @""] forHTTPHeaderField:@"Authorization"];
    
    [manager GET:url parameters:getparameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self successResponseDatas:responseObject Delegate:getDelegate requestName:getRequestName parameters:getparameters];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self failedResponseDatas:getDelegate Error:error requestName:getRequestName operation:operation parameters:getparameters];
        

        
    }];
}

+(void)netWorkRequestByPostMode:(NSString *)url parameters:(NSDictionary *)getparameters requestName:(NSString *)postRequestName delegate:(id)postDelegate{

    [self post:getparameters url:url postRequestName:postRequestName postDelegate:postDelegate];
}
#pragma mark -- post请求
+ (void)post:(NSDictionary *)postInfo url:(NSString *)url postRequestName:(NSString *)postRequestName postDelegate:(id)postDelegate{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setValue: [NSString stringWithFormat:@"Token %@", @""] forHTTPHeaderField:@"Authorization"];
    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
////®[manager setSecurityPolicy:[self customSecurityPolicy]];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
//                                                         @"text/json",
//                                                         @"text/javascript",
//                                                         @"text/html",
//                                                         @"application/soap+xml",nil];
//    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer.timeoutInterval = NetworkTimeoutTime;
    
  
    
    [manager POST:url parameters:postInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        [self successResponseDatas:responseObject Delegate:postDelegate requestName:postRequestName parameters:postInfo];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        [self failedResponseDatas:postDelegate Error:error requestName:postRequestName operation:operation parameters:postInfo];
        
        
    }];

}

#pragma mark -- delete请求
+ (void)deleteRequest:(NSDictionary *)deleteInfo url:(NSString *)url deleteRequestName:(NSString *)deleteRequestName deleteDelegate:(id)deleteDelegate{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
    [manager.requestSerializer setValue: [NSString stringWithFormat:@"Token %@", @""] forHTTPHeaderField:@"Authorization"];
    
    
    manager.requestSerializer.timeoutInterval = NetworkTimeoutTime;
    
    [manager DELETE:url parameters:deleteInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self successResponseDatas:responseObject Delegate:deleteDelegate requestName:deleteRequestName parameters:deleteInfo];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
         [self failedResponseDatas:deleteDelegate Error:error requestName:deleteRequestName operation:operation parameters:deleteInfo];
        
        
    }];
}
#pragma mark -- put请求
+ (void)put:(NSDictionary *)postInfo url:(NSString *)url postRequestName:(NSString *)postRequestName postDelegate:(id)postDelegate{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue: [NSString stringWithFormat:@"Token %@", @""] forHTTPHeaderField:@"Authorization"];
    
  
    manager.requestSerializer.timeoutInterval = NetworkTimeoutTime;
    
    
    [manager PUT:url parameters:postInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self successResponseDatas:responseObject Delegate:postDelegate requestName:postRequestName parameters:postInfo];
     
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
        [self failedResponseDatas:postDelegate Error:error requestName:postRequestName operation:operation parameters:postInfo];
        

    }];
}

#pragma mark -- head请求
+ (void)head:(NSDictionary *)postInfo url:(NSString *)url postRequestName:(NSString *)postRequestName postDelegate:(id)postDelegate{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setValue: [NSString stringWithFormat:@"Token %@", @""] forHTTPHeaderField:@"Authorization"];
    manager.requestSerializer.timeoutInterval = NetworkTimeoutTime;
    [manager HEAD:url parameters:postInfo success:^(AFHTTPRequestOperation *operation) {
        [self successResponseDatas:operation Delegate:postDelegate requestName:postRequestName parameters:postInfo];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
     
        [self failedResponseDatas:postDelegate Error:error requestName:postRequestName operation:operation parameters:postInfo];
        

    }];

}

#pragma mark -- head请求
+ (void)patch:(NSDictionary *)postInfo url:(NSString *)url postRequestName:(NSString *)postRequestName postDelegate:(id)postDelegate{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    [manager.requestSerializer setValue: [NSString stringWithFormat:@"Token %@", @""] forHTTPHeaderField:@"Authorization"];
    
    manager.requestSerializer.timeoutInterval = NetworkTimeoutTime;
    [manager PATCH:url parameters:postInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self successResponseDatas:responseObject Delegate:postDelegate requestName:postRequestName parameters:postInfo];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
        [self failedResponseDatas:postDelegate Error:error requestName:postRequestName operation:operation parameters:postInfo];
        
    }];

    
}


#pragma mark - Multip Server
//多个请求
+(void)netWorkMultipleRequestByPostMode:(NSArray *)urlArray postInfoArray:(NSArray *)postInfoArray requestNameArray:(NSArray *)requestNameArray delegate:(id)postDelegate  totalRequestName:(NSString *)totalRequestName {
    
    NSMutableDictionary *resultDic_ = [NSMutableDictionary dictionary];
    NSMutableArray *failedArray_ = [NSMutableArray array];
    NSMutableArray *successArray_ = [NSMutableArray array];

    for (int i = 0; i < [urlArray count]; i++) {

        NSString *url_ = [urlArray objectAtCheckedIndex:i];
        
        NSMutableDictionary *postInfo_ = [postInfoArray objectAtCheckedIndex:i];
        NSString *postRequestName_ = [requestNameArray objectAtCheckedIndex:i];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        [manager setSecurityPolicy:[self customSecurityPolicy]];

        manager.requestSerializer.timeoutInterval = NetworkTimeoutTime;
        
//            NSString *strV = [AESCrypt encrypt:[postInfo_ JSONString]];
//            NSDictionary *dicPost = [NSDictionary dictionaryWithObjectsAndKeys:strV,@"json",nil];

        [manager POST:url_ parameters:postInfo_ success:^(AFHTTPRequestOperation *operation, id responseObject) {

            [successArray_ addObject:postRequestName_];
            [resultDic_ setValue:[self finishResponseDatas:responseObject RequestName:postRequestName_] forKey:postRequestName_];
            
            if ((int)[successArray_ count] + (int)[failedArray_ count] == (int)[urlArray count]) {
                
                if(postDelegate && [postDelegate respondsToSelector:@selector(netWorkMultipleRequestFinished:SuccessRequestNameArray:FailedRequestNameArray:totalRequestName:)])
                {
                    [postDelegate netWorkMultipleRequestFinished:resultDic_ SuccessRequestNameArray:successArray_ FailedRequestNameArray:failedArray_ totalRequestName:totalRequestName];
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [failedArray_ addObject:postRequestName_];
            
            if ((int)[successArray_ count] + (int)[failedArray_ count] == (int)[urlArray count]) {
                
                if(postDelegate && [postDelegate respondsToSelector:@selector(netWorkMultipleRequestFinished:SuccessRequestNameArray:FailedRequestNameArray:totalRequestName:)])
                {
                    [postDelegate netWorkMultipleRequestFinished:resultDic_ SuccessRequestNameArray:successArray_ FailedRequestNameArray:failedArray_ totalRequestName:totalRequestName];
                }
            }
            
        }];
    }
}

+(id)finishResponseDatas:(id)responseData RequestName:(NSString *)getRequestName
{
    NSString *str = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
//    NSString *strResult = [AESCrypt decrypt:str];
    
    id object = [str objectFromJSONString];
    //处理stock请求数据
    if ([getRequestName isEqualToString:@"stock"]) {
        object = [[[str stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString:@", " withString:@" "] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    }else if ([getRequestName isEqualToString:@"stockList"]){
        object = [[[str stringByReplacingOccurrencesOfString:@"\"" withString:@""]stringByReplacingOccurrencesOfString:@", " withString:@" "] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    }else if ([getRequestName isEqualToString:@"Get_K_Map"] || [getRequestName isEqualToString:@"Get_K_MapFromComment"]){
        object = [[str stringByReplacingOccurrencesOfString:@"\"" withString:@""] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    }else if ([getRequestName isEqualToString:@"newStock"] || [getRequestName isEqualToString:@"newStockFromComment"]){
        NSError *error = nil;
        NSString *trimmedResponse = [str stringByReplacingOccurrencesOfString:@"/**/cbfunc" withString:@""];
        
        NSCharacterSet *removeSet = [NSCharacterSet characterSetWithCharactersInString:@"();"];
        NSString *jsonResponse = [[trimmedResponse componentsSeparatedByCharactersInSet: removeSet] componentsJoinedByString: @""];
        
        NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:[jsonResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error];
        
        object = [[[responseDict valueForKey:@"query"] valueForKey:@"results"] valueForKey:@"quote"];
    }
    
    return object;
}

#pragma mark -

+(void)successResponseDatas:(id)responseData Delegate:(id)postDelegate requestName:(NSString *)getRequestName parameters:(NSDictionary *)getparameters
{
    
    @try
    {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:getRequestName,@"username", nil];

//        if (responseData) {
        
            if(postDelegate && [postDelegate respondsToSelector:@selector(netWorkRequestSuccess:userInfo:parameters:)])
            {
                [postDelegate netWorkRequestSuccess:responseData userInfo:dict parameters:getparameters];
                
            }

    }
    @catch (NSException *e)
    {

    }
}

+ (void)failedResponseDatas:(id)postDelegate Error:(NSError *)error requestName:(NSString *)getRequestName operation:(AFHTTPRequestOperation *)operation parameters:(NSDictionary *)getparameters
{
    NSLog(@"请求失败 请求名字为:%@ 错误原因:%@ %@",getRequestName,error ,operation.request.URL.absoluteString);

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:getRequestName,@"username", nil];
    if(postDelegate && [postDelegate respondsToSelector:@selector(netWorkRequestFailed:userInfo:parameters:)])
    {
        [postDelegate netWorkRequestFailed:error userInfo:dict parameters:getparameters];
    }
}


+ (AFSecurityPolicy*)customSecurityPolicy
{
    /**** SSL Pinning ****/
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ser" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [securityPolicy setPinnedCertificates:@[certData]];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
//    securityPolicy.validatesCertificateChain = NO;
    
    return securityPolicy;
}

@end
