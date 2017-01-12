//
//  NetWorkRequest.h
//  startogether
//
//  Created by wangzhifei on 12-11-26.
//  Copyright (c) 2016年 bailey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"

@class AFHTTPRequestOperation;
@protocol NetWorkRequestDelegate;

@interface NetWorkRequest : NSObject

//get 方式
+(void) netWorkRequestByGetMode:(NSString*)url parameters:(NSMutableDictionary *)getparameters requestName:(NSString*)getRequestName delegate:(id)getDelegate;

// 网络请求 POST 方式
+(void) netWorkRequestByPostMode:(NSString *)url parameters:(NSDictionary *)getparameters requestName:(NSString*)postRequestName delegate:(id)postDelegate;

// 网络请求 POST 方式
+ (void)patch:(NSDictionary *)postInfo url:(NSString *)url postRequestName:(NSString *)postRequestName postDelegate:(id)postDelegate;

+ (void)put:(NSDictionary *)postInfo url:(NSString *)url postRequestName:(NSString *)postRequestName postDelegate:(id)postDelegate;

+ (void)head:(NSDictionary *)postInfo url:(NSString *)url postRequestName:(NSString *)postRequestName postDelegate:(id)postDelegate;

+ (void)deleteRequest:(NSDictionary *)deleteInfo url:(NSString *)url deleteRequestName:(NSString *)deleteRequestName deleteDelegate:(id)deleteDelegate;

// post + datas
//+(void) netWorkRequestByPostModeWithDatas:(NSString *)url WithPostValue:(NSMutableDictionary *)postValue WithPostDatas:(NSMutableDictionary *)postDatas requestName:(NSString *)postRequestName delegate:(id)postDelegate;

// 多个请求
+(void)netWorkMultipleRequestByPostMode:(NSArray *)urlArray postInfoArray:(NSArray *)postInfoArray requestNameArray:(NSArray *)requestNameArray delegate:(id)postDelegate totalRequestName:(NSString *)totalRequestName;

//登录
+(void)netWorkRequestForUserReLogin:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+(void)netWorkRequestForUserLoginWithLoginType:(NSString *)loginType parameters:(id)parameters result:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end

@protocol NetWorkRequestDelegate <NSObject>

-(void)netWorkRequestSuccess:(id)data userInfo:(NSDictionary *)userInfo parameters:(NSDictionary *)getparameters;
-(void)netWorkRequestFailed:(NSError*)error userInfo:(NSDictionary *)userInfo parameters:(NSDictionary *)getparameters;

-(void)netWorkMultipleRequestFinished:(NSMutableDictionary *)resuleDict SuccessRequestNameArray:(NSArray *)successRequestNameArray FailedRequestNameArray:(NSMutableArray *)failedRequestNameArray totalRequestName:(NSString *)totalRequestName;


@optional
-(void)netWorkRequestSuccessWithNoJson:(NSString *)dataStr userInfo:(NSDictionary *)userInfo;

-(void)netWorkUploadProgress:(long long)didSendBytes totalBytes:(long long) totalBytes;
-(void)netWorkDownloadProgress:(long long)didSendBytes totalBytes:(long long) totalBytes;

@end
