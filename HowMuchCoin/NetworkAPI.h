//
//  NetworkAPI.h
//  HowMuchCoin
//
//  Created by Mikhail on 21.02.2025.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface NetworkAPI : NSObject
+ (instancetype) sharedManager;
- (void) fetchCostCoin:(NSString *)coin completion:(void (^)(NSString *cost))completion;
@end

NS_ASSUME_NONNULL_END
