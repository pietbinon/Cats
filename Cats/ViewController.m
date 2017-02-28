//
//  ViewController.m
//  Cats
//
//  Created by Hyung Jip Moon on 2017-02-27.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"

@interface ViewController ()

@property NSDictionary *photoDictionary;
//@property NSMutableArray  *photoTitles;         // Titles of images
@property NSMutableArray  *storeAllPhotos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.photoTitles = [NSMutableArray new];
    self.storeAllPhotos = [NSMutableArray new];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=500a485bcdb5d40ef46da98c4c7f8806&tags=cat"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        NSError *jsonError = nil;
        self.photoDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if(jsonError) {
            //Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return ;
        }
        
        NSDictionary *photos = [[self.photoDictionary objectForKey:@"photos"] objectForKey:@"photo"];
        // If we reach this point, we have successfully retrieved the JSON from the API
        for(NSDictionary *tempPhotoDictionary in photos) {
            
            NSString *title = [tempPhotoDictionary objectForKey:@"title"];
            //[self.photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
            
//            NSString *photoURLString =
//            [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@.jpg",
//             [tempPhotoDictionary objectForKey:@"farm"], [tempPhotoDictionary objectForKey:@"server"],
//             [tempPhotoDictionary objectForKey:@"id"], [tempPhotoDictionary objectForKey:@"secret"]];
            
            Photo *newPhoto = [[Photo alloc] initWithServer:[tempPhotoDictionary objectForKey:@"server"] initWithFarm:[tempPhotoDictionary objectForKey:@"farm"] initWithID:[tempPhotoDictionary objectForKey:@"id"] initWithSecret:[tempPhotoDictionary objectForKey:@"secret"] initWithTitle:title initWithURL:url];
            
            [self.storeAllPhotos addObject:newPhoto];
            //self item at index path, it's gonna give me indexpath.row
            //row will be index of array of photos
            
            NSLog(@"%@",self.storeAllPhotos);
            //NSLog(@"photoURLString: %@", photoURLString);

            //NSString *repoName = repo[@"photos"];
           // NSLog(@"repo: %@", title);
//            NSLog(@"photoURLString: %@", photoURLString);

        }
        //[self.storePhotosView reloadData];
    }];
    
    [dataTask resume];
}

//- (void)flickrJsonPhotoDownload {
////    NSURL *jsonUrl = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=a7e8eeb660518f4cb05325751027181d&tags=cat"];
////    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonUrl];
//    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//    
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//
//        
//        NSDictionary *photosDict = jsonDictionary[@"photos"];
//        NSArray *arrayOfPhotos = photosDict[@"photo"];
//        
//        for (NSDictionary *photoInfo in arrayOfPhotos) {
//            NSNumber *farmNum = photoInfo[@"farm"];
//            NSString *serverId = photoInfo[@"server"];
//            NSString *photoId = photoInfo[@"id"];
//            NSString *photoSecret = photoInfo[@"secret"];
//            NSString *photoTitle = photoInfo[@"title"];
//            
//            Photo *newPhoto = [[Photo alloc] initWithfarmNumber:farmNum serverId:serverId photoId:photoId secret:photoSecret andTitle:photoTitle];
//            [self.listOfPhotos addObject:newPhoto];
//            newPhoto.delegate = self;
//        }
//        
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            
//            [self.collectionView reloadData];
//        }];
//    }];
//    
//    [dataTask resume];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
