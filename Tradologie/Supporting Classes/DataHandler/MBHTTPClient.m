
//  MBHTTPClient.m
//  CoFETH
//
//  Created by Anil Khanna on 14/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import "MBHTTPClient.h"
#import "AfNetworking.h"
#import "AFHTTPSessionManager+RetryPolicy.h"
#import "SharedManager.h"

#define SHARED_INSTANCE(...) ({\
static dispatch_once_t pred;\
static id sharedObject;\
dispatch_once(&pred, ^{\
sharedObject = (__VA_ARGS__);\
});\
sharedObject;\
})

#define RETRYCOUNTER 2
#define RETRYINTERVAL 1.0
#define FATALSTATUSCODE @[@401, @403]

@interface MBHTTPClient(){
    AFHTTPSessionManager * globalManager;
}
@end

@implementation MBHTTPClient
+(id) sharedInstance
{
    static dispatch_once_t pred = 0;
    static id sharedObject;
    dispatch_once(&pred, ^{
        sharedObject = [self new];
    });
    
    if (![SharedManager sharedInstance].isNetAvailable) {
        [sharedObject cancelAllOperation];
        return nil;
    }
    
    return sharedObject;
}
-(void)cancelAllOperation{
    [globalManager.operationQueue cancelAllOperations];
}

-(void)requestGETServiceOnURL:(NSString *)urlString WithDictionary:(id)requestDictionary withCompletion:(void (^)(NSURLSessionDataTask *task, NSError *error, id response))completion
{
    //[AppDelegate shared].oneAlertViewAlreadyThere = NO;
    NSLog(@"=============================================================================");
    
    NSLog(@"URL : %@",urlString);
    
    if (requestDictionary) {
        NSLog(@"REQUEST : %@",[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:requestDictionary options:0 error:nil] encoding:NSUTF8StringEncoding]);
    }
    
    NSLog(@"=============================================================================");
    
    AFHTTPSessionManager * manager = [self requestOperationManager];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSLog(@"Success = %@",responseObject);
        
        completion(task,nil,responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        completion(task, error, nil);
        
    }retryCount:RETRYCOUNTER retryInterval:RETRYINTERVAL progressive:false fatalStatusCodes:FATALSTATUSCODE];

}

-(void)requestPOSTServiceOnURL:(NSString *)urlString WithDictionary:(id)requestDictionary withCompletion:(void (^)(NSURLSessionDataTask *task, NSError *error, id response))completion{
    
    NSLog(@"=============================================================================");
    
    NSLog(@"URL : %@",urlString);
    
    if (requestDictionary) {
        NSLog(@"REQUEST : %@",[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:requestDictionary options:0 error:nil] encoding:NSUTF8StringEncoding]);
    }
    
    NSLog(@"=============================================================================");
    AFHTTPSessionManager *manager = [self requestOperationManager];
    
    [manager POST:urlString parameters:requestDictionary progress:nil
          success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict   = [NSDictionary dictionaryWithDictionary:[task.currentRequest allHTTPHeaderFields]];
        NSLog(@"Success = %@ %@ ",responseObject,dict);
        
        completion(task,nil,responseObject);
    }
          failure:^(NSURLSessionDataTask *task, NSError *error)
     {
        //NSDictionary *dict   = [NSDictionary dictionaryWithDictionary:[task.currentRequest allHTTPHeaderFields]];
         
        completion(task, error, nil);
        
    } retryCount:RETRYCOUNTER retryInterval:RETRYINTERVAL progressive:false fatalStatusCodes:FATALSTATUSCODE];
    
}

#pragma mark - Request Operation Manager

-(AFHTTPSessionManager *)requestOperationManager
{
    if(globalManager==nil){
        globalManager = [[AFHTTPSessionManager alloc] init];
        [globalManager setRetryPolicyLogMessagesEnabled:YES];
    }

    globalManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [globalManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    ((AFJSONResponseSerializer *)globalManager.responseSerializer).readingOptions=NSJSONReadingAllowFragments;

    //globalManager.requestSerializer  = [self addAuthorizationKey];
    globalManager.requestSerializer.cachePolicy=self.cachePolicy;

    [globalManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    globalManager.requestSerializer.timeoutInterval = 30;
    [globalManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    return  globalManager;
}

//#pragma mark - Set Authorization Key
//-(AFJSONRequestSerializer* )addAuthorizationKey
//{
//    //    x-GeoLocation, x-DeviceId, x-Timestamp
//
//    AFJSONRequestSerializer *jsonSerializer=[AFJSONRequestSerializer serializer];
//    jsonSerializer.timeoutInterval=20;
//
//    if (GET_USER_DEFAULTS(K_ACCESSTOKEN)) {
//
//        [jsonSerializer setValue:[NSString stringWithFormat:@"%@",GET_USER_DEFAULTS(K_ACCESSTOKEN)] forHTTPHeaderField:K_ACCESSTOKEN];
//    }
//
//    [jsonSerializer setValue:@"ios" forHTTPHeaderField:@"DeviceType"];
//    [jsonSerializer setValue:UNIQUE_IDENTIFIER forHTTPHeaderField:@"Deviceid"];
////    [jsonSerializer setValue:KENVIRONMENT forHTTPHeaderField:@"environment"];
////    [jsonSerializer setValue:k_Client forHTTPHeaderField:@"client"];
//
//    return jsonSerializer;
//}


//-(void)requestDELETEServiceOnURL:(NSString *)urlString WithDictionary:(id)requestDictionary withCompletion:(void (^)(NSURLSessionDataTask *task, NSError *error, id response))completion
//{
//    NSLog(@"=============================================================================");
//
//    NSLog(@"URL : %@",urlString);
//
//    if (requestDictionary) {
//        NSLog(@"REQUEST : %@",[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:requestDictionary options:0 error:nil] encoding:NSUTF8StringEncoding]);
//    }
//
//    NSLog(@"=============================================================================");
//
//    AFHTTPSessionManager *manager = [self requestOperationManager];
//
//
//    [manager DELETE:urlString parameters:requestDictionary success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"Success = %@",responseObject);
//        completion(task,nil,responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//        completion(task, error, nil);
//
//    } retryCount:RETRYCOUNTER retryInterval:RETRYINTERVAL progressive:false fatalStatusCodes:FATALSTATUSCODE];
//}
//
//-(void)requestPUTServiceOnURL:(NSString *)urlString WithDictionary:(id)requestDictionary withCompletion:(void (^)(NSURLSessionDataTask *task, NSError *error, id response))completion{
//
//    NSLog(@"=============================================================================");
//
//    NSLog(@"URL : %@",urlString);
//
//    if (requestDictionary) {
//        NSLog(@"REQUEST : %@",[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:requestDictionary options:0 error:nil] encoding:NSUTF8StringEncoding]);
//    }
//
//    NSLog(@"=============================================================================");
//
//
//    AFHTTPSessionManager *manager = [self requestOperationManager];
//
//    [manager PUT:urlString parameters:requestDictionary success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"Success = %@",responseObject);
//        completion(task,nil,responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//        completion(task, error, nil);
//
//
//    } retryCount:RETRYCOUNTER retryInterval:RETRYINTERVAL progressive:false fatalStatusCodes:FATALSTATUSCODE];
//
//}
//
//
//-(void)requestPOSTMultipartServiceOnURL:(NSString *) urlString withData:(NSData *)photoData withParametes:(id)requestDictionary  withCompletion:(void (^)(NSURLSessionDataTask *task, NSError *error, id response))completion{
//    /*
//     // 1. Create `AFHTTPRequestSerializer` which will create your request.
//     AFJSONRequestSerializer *serializer = [self addAuthorizationKey];
//
//     // 2. Create an `NSMutableURLRequest`.
//     NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:requestDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//
//     if (photoData) {
//     [formData appendPartWithFileData:photoData
//     name:@"image_path"
//     fileName:@"profilePic.jpg"
//     mimeType:@"image/jpeg"];
//     }
//     } error:nil];
//     */
//
//
//
//    AFHTTPSessionManager *manager = [self requestOperationManager];
//
//    [manager POST:urlString parameters:requestDictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        if (photoData) {
//            [formData appendPartWithFileData:photoData
//                                        name:@"profile_image"
//                                    fileName:@"profilePic.jpg"
//                                    mimeType:@"image/jpeg"];
//        }
//
//    } progress:nil
//          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//              NSLog(@"%@ ", responseObject);
//              completion(task,nil,responseObject);
//
//          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//              completion(task, error, nil);
//
//
//              NSLog(@"Error: %@", error);
//
//          } retryCount:RETRYCOUNTER retryInterval:RETRYINTERVAL progressive:false fatalStatusCodes:FATALSTATUSCODE];
//
//
//
//
//}
//
//-(void)requestPOSTMultipartServiceOnURL:(NSString *) urlString withImageData:(NSArray *)photoData withParametes:(id)requestDictionary  withCompletion:(void (^)(NSURLSessionDataTask *task, NSError *error, id response))completion{
//  /*
//    // 1. Create `AFHTTPRequestSerializer` which will create your request.
//    AFJSONRequestSerializer *serializer = [self addAuthorizationKey];
//
//    // 2. Create an `NSMutableURLRequest`.
//    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:requestDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//
//        if (photoData) {
//            [formData appendPartWithFileData:photoData
//                                        name:@"image_path"
//                                    fileName:@"profilePic.jpg"
//                                    mimeType:@"image/jpeg"];
//        }
//    } error:nil];
//    */
//
//
//
//    AFHTTPSessionManager *manager = [self requestOperationManager];
//
//
//    [manager POST:urlString parameters:requestDictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        //this code is used to set send extra param in multipart
////        NSDictionary *paramDict = @{@"caption" : [requestDictionary objectForKey:@"caption"]};
////        NSDictionary *taggedUserDict = @{@"tagged_users" : [requestDictionary objectForKey:@"tagged_users"]};
////        for (NSDictionary *userDetail in [taggedUserDict objectForKey:@"" ]) {
////            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userDetail options:0 error:nil];
////            [formData appendPartWithFormData:jsonData name:@"tagged_user"];
////        }
//    if(photoData.count > 0){
//        for(int i = 0; i < photoData.count; i++){
//    [formData appendPartWithFileData:[photoData objectAtIndex:i]
//                                name:[NSString stringWithFormat:@"image_path[%d]", i]
//                            fileName:[NSString stringWithFormat:@"profilePic[%d].jpg", i]
//                            mimeType:@"image/jpeg"];
//            NSLog(@"%@ Image Path", formData);
//}
//
//
//
//}
//
//    } progress:nil
//          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSLog(@"%@ ", responseObject);
//        completion(task,nil,responseObject);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        completion(task, error, nil);
//
//
//        NSLog(@"Error: %@", error);
//
//    } retryCount:RETRYCOUNTER retryInterval:RETRYINTERVAL progressive:false fatalStatusCodes:FATALSTATUSCODE];
//
//}
//
//
////-(void)requestPOSTMultipartServiceOnURL:(NSString *) urlString withImageData:(NSArray *)photoData withParametes:(id)requestDictionary WithProgressBlock:(void (^) (float progress))progressBlock withCompletion:(void (^)(NSURLSessionDataTask *task, NSError *error, id response))completion{
////
////    // 1. Create `AFHTTPRequestSerializer` which will create your request.
////    AFJSONRequestSerializer *serializer = [self addAuthorizationKey];
////
////    // 2. Create an `NSMutableURLRequest`.
////    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:requestDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
////
////        if(photoData){
////            for(int i = 0; i < photoData.count; i++){
////                [formData appendPartWithFileData:[photoData objectAtIndex:i]
////                                            name:[NSString stringWithFormat:@"image_path[%d]", i]
////                                        fileName:@"profilePic.jpg"
////                                        mimeType:@"image/jpeg"];
////            }
////        }
////    } error:nil];
////
////    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
////
////    NSURLSessionUploadTask *uploadTask;
////    uploadTask = [manager
////                  uploadTaskWithStreamedRequest:request
////                  progress:^(NSProgress * _Nonnull uploadProgress) {
////                      // This is not called back on the main queue.
////                      // You are responsible for dispatching to the main queue for UI updates
////                      dispatch_async(dispatch_get_main_queue(), ^{
////                          //Update the progress view
////                          //                          [progressView setProgress:uploadProgress.fractionCompleted];
////                      });
////                  }
////                  completionHandler:^(NSURLResponse  *_Nonnull response, id  _Nullable responseObject, NSError  *_Nullable error) {
////                      if (error) {
////                          NSLog(@"Error: %@", error);
////                          completion(uploadTask,error,responseObject);
////                      } else {
////                          NSLog(@"%@ %@", response, responseObject);
////                          completion(uploadTask,nil,responseObject);
////                      }
////                  }];
////
////    [uploadTask resume];
////
////}
//

////#pragma mark - upload image on server
////
////-(void)requestPOSTImageURL:(NSString *) urlString withImageData:(NSData *)photoData fileName:(NSString *)filename imageName:(NSString *)imageName mimeType:(NSString *)mimeType withParametes:(id)requestDictionary WithProgressBlock:(void (^) (float progress))progressBlock withCompletion:(void (^)(NSURLSessionDataTask *task, NSError *error, id response))completion{
////
////    // 1. Create `AFHTTPRequestSerializer` which will create your request.
////    AFJSONRequestSerializer *serializer = [self addAuthorizationKey];
////
////    // 2. Create an `NSMutableURLRequest`.
////    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:requestDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
////
////        if (photoData) {
////            [formData appendPartWithFileData:photoData
////                                        name:imageName
////                                    fileName:filename
////                                    mimeType:mimeType];
////        }
////    } error:nil];
////
////    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//
//    NSURLSessionUploadTask *uploadTask;
//    uploadTask = [manager
//                  uploadTaskWithStreamedRequest:request
//                  progress:nil
//                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//
//                      if (error) {
//                          completion(nil,error,nil);
//                      } else {
//                          completion(nil,nil,responseObject);
//                      }
//                  }];
//
//    [uploadTask resume];
//
//}


@end
