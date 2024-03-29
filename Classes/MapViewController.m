/*
     File: MapViewController.m
 Abstract: Controls the map view and manages the reverse geocoder to get the current address.
  Version: 1.3
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2012 Apple Inc. All Rights Reserved.
 
 */

#import "MapViewController.h"
#import "PlacemarkViewController.h"
#import "Person.h"

@interface MapViewController ()

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *getAddressButton;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) MKPlacemark *placemark;
@property (nonatomic) CLLocationCoordinate2D *centerCoodinate;
@property (nonatomic, strong) NSMutableArray *vetorDePessoas;

//@property (strong, nonatomic) Person *pessoa;
@end


// inicio
//
//@interface MyCustomAnnotation : NSObject <MKAnnotation> {
//    CLLocationCoordinate2D coordinate;
//}
//@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
//
//
//- (id)initWithLocation:(CLLocationCoordinate2D)coord;
//


// Other methods and properties.
//@end


// fim


@implementation MapViewController

- (NSMutableArray *)vetorDePessoas {
    if (!_vetorDePessoas) {
        _vetorDePessoas = [[NSMutableArray alloc]init];
    }
    return _vetorDePessoas;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.showsUserLocation = YES;
    
    self.geocoder = [[CLGeocoder alloc] init];
    
    // create a custom navigation bar button and set it to always say "Back"
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Kd a Daphine";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
  //  Person *pessoa1 = [[Person alloc] init];
   // pessoa1.coordenadas = self.mapView.userLocation.coordinate;
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushToDetail"])
    {
        PlacemarkViewController *viewController = segue.destinationViewController;
        viewController.placemark = self.placemark;
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [mapView setCenterCoordinate:mapView.userLocation.location.coordinate animated:YES];
    
    // 
    {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        
        
   //     MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    //    point.coordinate = userLocation.coordinate;
    //    point.title = @"You Are Here";
    //    point.subtitle = @"Your current location";
        
    //    [self.mapView addAnnotation:point];
        
        // objeto <> struct;
        
     // !  CLLocationCoordinate2D minhaLocalizacao = CLLocationCoordinate2DMake(
     //  !                                                   -21.2310,
     //   !                                                   -44.9999);
        Person *pessoa1 = [[Person alloc] init]; // pessoa1 é o próprio usuário
        Person *pessoa2 = [[Person alloc] init]; // pessoa2 serão os outros usuários
        
        
        pessoa1.coordenadas = self.mapView.userLocation.coordinate;
        pessoa1.timestamp = @"12:30pm";
        pessoa1.name = @"Daphine";
     // [ pessoa 1, eu, está montada. Enviar essa pessoa para o servidor ]
        
        
        
        
        
        
        
        
        
     // [ receber pessoas(aqui haverá um for) 2 do servidor, montá-la, e inserir no vetorDePessoas ]
        [self.vetorDePessoas addObject:pessoa1];

        
  
        
        pessoa2 = [self.vetorDePessoas objectAtIndex:0];
        
        
     
        
        for (NSUInteger numeroDePessoas = 0; numeroDePessoas <= self.vetorDePessoas.count; numeroDePessoas++) {
            MKPointAnnotation *point2 = [[MKPointAnnotation alloc] init];
           
            point2.coordinate = pessoa2.coordenadas;
            point2.title = pessoa2.name;
            point2.subtitle = pessoa2.timestamp;
            
            [self.mapView addAnnotation:point2];
        }
        
        
       

        
    }
    
    // fim do codigo adicionado pelo mario
    
    
    
    [self.geocoder reverseGeocodeLocation:self.mapView.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        _placemark = [placemarks objectAtIndex:0];
        
        // we have received our current location, so enable the "Get Current Address" button
        [self.getAddressButton setEnabled:YES];
    }];
}



@end
