//
//  ImageDownload.m
//  Image Downloader
//

#import "ImageDownload.h"

@interface ImageDownload()
@property (nonatomic, retain) NSMutableData *receivedData;
@end

@implementation ImageDownload
@synthesize urlString;
@synthesize image;
@synthesize imageView;
@synthesize activityIndicator;
@synthesize delegate;
@synthesize receivedData;
#pragma mark -

- (UIImage *)image
{
    if (image == nil && !downloading)
    {
        if (urlString != nil && [urlString length] > 0)
        {
            NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString]];
            NSURLConnection *con = [[NSURLConnection alloc]
                                    initWithRequest:req
                                    delegate:self
                                    startImmediately:NO];
            [con scheduleInRunLoop:[NSRunLoop currentRunLoop]
                           forMode:NSRunLoopCommonModes];
            [con start];
            
            
            
            if (con) 
            {
                NSMutableData *data = [[NSMutableData alloc] init];
                self.receivedData=data;
                [data release];
            } 
            else 
            {
                NSError *error = [NSError errorWithDomain:ImageDownloadErrorDomain 
                                                     code:ImageDownloadErrorNoConnection 
                                                 userInfo:nil];
                if ([self.delegate respondsToSelector:@selector(download:didFailWithError:)])
                    [delegate download:self didFailWithError:error];
            }   
            [req release];
            
            downloading = YES;
        }
    }
    return image;
}
- (NSString *)filename
{
    return [urlString lastPathComponent];
}
- (void)dealloc 
{
    [urlString release];
    [image release];
    delegate = nil;
    [receivedData release];
    [super dealloc];
}
#pragma mark -
#pragma mark NSURLConnection Callbacks
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
    [receivedData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    [receivedData appendData:data];
}
- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error 
{
    [connection release];
    if ([delegate respondsToSelector:@selector(download:didFailWithError:)])
        [delegate download:self didFailWithError:error];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    self.image = [UIImage imageWithData:receivedData];
    if ([delegate respondsToSelector:@selector(downloadDidFinishDownloading:)])
        [delegate downloadDidFinishDownloading:self];
    
    [connection release];
    self.receivedData = nil;
}
#pragma mark -
#pragma mark Comparison
- (NSComparisonResult)compare:(id)theOther
{
    ImageDownload *other = (ImageDownload *)theOther;
    return [self.filename compare:other.filename];
}
@end
