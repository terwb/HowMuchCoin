//
//  NetworkAPI.m
//  HowMuchCoin
//
//  Created by Mikhail on 21.02.2025.
// https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd

#import "NetworkAPI.h"

@implementation NetworkAPI
+ (instancetype) sharedManager {
    static NetworkAPI *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetworkAPI alloc] init];
    });
    return manager;
}
- (void) fetchCostCoin:(NSString *)coin completion:(void (^)(NSString *cost))completion {
    NSString *urlString = [NSString stringWithFormat:@"https://api.coingecko.com/api/v3/simple/price?ids=%@&vs_currencies=usd", coin];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSNumber *cost = [responseObject valueForKeyPath:[NSString stringWithFormat:@"%@.usd", coin]];
        NSString *costString = (cost != nil) ? [cost stringValue] : @"No data";
        if (completion) {
            completion(costString);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        if (completion) {
            completion(@"Error");
        }
    }];
}
@end
