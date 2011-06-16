//
//  ImageDownload.h
//  Image Downloader
//

#import <Foundation/Foundation.h>

#define ImageDownloadErrorDomain      @"Image Download Error Domain"
enum 
{
    ImageDownloadErrorNoConnection = 1000,
};

@class ImageDownload;
@protocol ImageDownloadDelegate
@optional
- (void)downloadDidFinishDownloading:(ImageDownload *)download;
- (void)download:(ImageDownload *)download didFailWithError:(NSError *)error;
@end


@interface ImageDownload : NSObject 
{  
    NSString                                *urlString;
    UIImage                                 *image;
    UIImageView                             *imageView;
    UIActivityIndicatorView                 *activityIndicator;
    
    id <NSObject, ImageDownloadDelegate>  delegate;

@private
    NSMutableData                           *receivedData;
    BOOL                                    downloading;
}
@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, readonly) NSString *filename;
@property (nonatomic, assign) id <NSObject, ImageDownloadDelegate> delegate;
@end
