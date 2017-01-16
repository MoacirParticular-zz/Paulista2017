//
//  MainViewController.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize clubeCallMethods;
@synthesize jogoCallMethods;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    clubeCallMethods = [[ClubeCallMethods alloc] initWithDelegate:self];
    
    [clubeCallMethods getAllClubes];
    
    jogoCallMethods = [[JogoCallMethods alloc] initWithDelegate:self];
    
    [jogoCallMethods getAllJogos];
    
    //[clubeCallMethods getClubeWithId:@"1"];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

-(void)clubesObtidosComSucessoComJson:(NSDictionary *)json
{
    [DAOClube parseAndInsertObjectsWithJson:json];
}

-(void)jogosObtidosComSucessoComJson:(NSDictionary *)json
{
    [DAOJogo parseAndInsertObjectsWithJson:json];
//    [DAOTurno fetchAllTurno];
    
//    NSArray * arrayTurnos = [DAOTurno fetchAllTurno];
//   
//    Turno *turno = [arrayTurnos objectAtIndex:0];
//    
//    NSArray *arrayJogos = [turno.jogos allObjects];
//    
//    
//    for (Jogo *jogo in [self sortedJogosByName:arrayJogos]) {
//        NSLog(@"%@", [NSDateFormatter localizedStringFromDate:jogo.data dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle]);
//    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSArray *)sortedJogosByName:(NSArray*)jogos {
    NSSortDescriptor *sortNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"data" ascending:YES] ;
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortNameDescriptor, nil];
    
    return [jogos sortedArrayUsingDescriptors:sortDescriptors];
}


@end
