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

@property NSDictionary *repos;
@property NSMutableArray  *photoTitles;         // Titles of images
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        self.repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if(jsonError) {
            //Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return ;
        }
        
        NSArray *photos = [[self.repos objectForKey:@"photos"] objectForKey:@"photo"];

        // If we reach this point, we have successfully retrieved the JSON from the API
        for(NSDictionary *repo in photos) {
            
            NSString *title = [repo objectForKey:@"title"];
            [self.photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
            
            NSString *photoURLString =
            [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@.jpg",
             [repo objectForKey:@"farm"], [repo objectForKey:@"server"],
             [repo objectForKey:@"id"], [repo objectForKey:@"secret"]];
            
            NSLog(@"photoURLString: %@", photoURLString);

            //NSString *repoName = repo[@"photos"];
           // NSLog(@"repo: %@", title);
//            NSLog(@"photoURLString: %@", photoURLString);

        }
        //[self.storePhotosView reloadData];
    }];
    
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.repos.count;
//    
//}
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
//    NSDictionary *dict = self.repos[indexPath.row];
//    NSString *name = dict[@"name"];
//    cell.textLabel.text = name;
//
//    
//    return cell;
//    
//}


//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    // Store incoming data into a string
//    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    
//    // Create a dictionary from the JSON string
//    //NSDictionary *results = [jsonString JSONValue];
//    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//
//    // Build an array from the dictionary for easy access to each entry
//    NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
//    
//    // Loop through each entry in the dictionary...
//    for (NSDictionary *photo in photos)
//    {
//        // Get title of the image
//        NSString *title = [photo objectForKey:@"title"];
//        
//        // Save the title to the photo titles array
//        [photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
//        
//        // Build the URL to where the image is stored (see the Flickr API)
//        // In the format http://farmX.static.flickr.com/server/id_secret.jpg
//        // Notice the "_s" which requests a "small" image 75 x 75 pixels
//        NSString *photoURLString =
//        [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg",
//         [photo objectForKey:@"farm"], [photo objectForKey:@"server"],
//         [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
//        
//        NSLog(@"photoURLString: %@", photoURLString);

//        // The performance (scrolling) of the table will be much better if we
//        // build an array of the image data here, and then add this data as
//        // the cell.image value (see cellForRowAtIndexPath:)
//        [photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
//        
//        // Build and save the URL to the large image so we can zoom
//        // in on the image if requested
//        photoURLString =
//        [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg",
//         [photo objectForKey:@"farm"], [photo objectForKey:@"server"],
//         [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
//        [photoURLsLargeImage addObject:[NSURL URLWithString:photoURLString]];
//        
//        NSLog(@"photoURLsLareImage: %@\n\n", photoURLString); 
//    } 
//}

@end
