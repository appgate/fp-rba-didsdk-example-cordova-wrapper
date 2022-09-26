#import "DIDPlugServerHelper.h"
#import "DIDPlugExceptionsHelper.h"
#import "DIDPlugRegexHelper.h"
#import "DIDPlugConstantsHelper.h"

@interface DIDPlugServerHelper()
@property (nonatomic,strong,readonly) NSString *serverURL;
@end

@implementation DIDPlugServerHelper
- (instancetype)initWithUrl:(NSString *)serverURL{
    if(self == [super init]){
        _serverURL = serverURL;
    }
    return self;
}

+ (DIDPlugServerHelper *)getInstance:(NSString *)serverURL {
    [DIDPlugServerHelper validateServerURL:serverURL];
    return [[DIDPlugServerHelper new] initWithUrl:serverURL];
}

+ (void)validateServerURL:(NSString *)url {
    if (![DIDPlugRegexHelper validateStringFormat:url withPattern:serverUrlRegex]) {
        @throw [[DIDPlugExceptionsHelper new] invalidArgumentException];
    }
}

- (NSString *)getServerURL {
    return self.serverURL;
}
@end
