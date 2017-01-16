//
//  DAOFarroupilha.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "DAOFarroupilha.h"
#import "AppDelegate.h"
#import "DAOClube.h"
#import "Clube.h"

@implementation DAOFarroupilha

+(Farroupilha*)fetchFarroupilhaWithCode:(int)codigo
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allFarroupilha = [[NSFetchRequest alloc] init];
    [allFarroupilha setEntity:[NSEntityDescription entityForName:@"Farroupilha" inManagedObjectContext:context]];
    
    NSError * readError = nil;
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"codigo == %i", codigo];
    [allFarroupilha setPredicate:predicate];
    
    NSArray *fetchArray = [context executeFetchRequest:allFarroupilha error:&readError];
    
    if (fetchArray.count > 0) {
        return [fetchArray objectAtIndex:0];
    }
    else
    {
        return nil;
    }
}

+(NSArray*)fetchAllFarroupilha
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allFarroupilha = [[NSFetchRequest alloc] init];
    [allFarroupilha setEntity:[NSEntityDescription entityForName:@"Farroupilha" inManagedObjectContext:context]];
    
    //    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pontosGanhos" ascending:NO];
    //    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"nrVitorias" ascending:NO];
    //    NSSortDescriptor *sortDescriptor3 = [[NSSortDescriptor alloc] initWithKey:@"saldoGols" ascending:NO];
    //    NSSortDescriptor *sortDescriptor4 = [[NSSortDescriptor alloc] initWithKey:@"nrGolsMarcados" ascending:NO];
    //    NSSortDescriptor *sortDescriptor5 = [[NSSortDescriptor alloc] initWithKey:@"clube.nome" ascending:YES];
    //
    //    [allFarroupilha setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, sortDescriptor2, sortDescriptor3, sortDescriptor4, sortDescriptor5, nil]];
    
    
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"posicao" ascending:YES];
    NSSortDescriptor *sortDescriptor5 = [[NSSortDescriptor alloc] initWithKey:@"clube.nome" ascending:YES];
    
    [allFarroupilha setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor,sortDescriptor5 ,nil]];
    
    NSError * readError = nil;
    
    NSArray *fetchArray = [context executeFetchRequest:allFarroupilha error:&readError];
    
    return fetchArray;
}

+(void)parseAndInsertObjectsWithJson:(NSDictionary*)json;
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSMutableArray *FarroupilhaArray = [json objectForKey:@"Classificacao"];
    
    for (NSDictionary *dictFarroupilha in FarroupilhaArray) {
        Farroupilha *farroupilha = [DAOFarroupilha fetchFarroupilhaWithCode:[[dictFarroupilha objectForKey:@"codigo"] intValue]];
        
        if (farroupilha == nil) {
            farroupilha = [NSEntityDescription insertNewObjectForEntityForName:@"Farroupilha" inManagedObjectContext:context];
            farroupilha.codigo = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"codigo"] integerValue]];
            farroupilha.pontosGanhos = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"pontosganhos"] integerValue]];
            farroupilha.nrVitorias = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"nrvitorias"] integerValue]];
            farroupilha.saldoGols = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"saldogols"] integerValue]];
            farroupilha.nrGolsMarcados = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"nrgolsmarcados"] integerValue]];
            farroupilha.dsgrupo = [dictFarroupilha objectForKey:@"grupo"];
            farroupilha.posicao = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"posicao"] integerValue]];
            farroupilha.nrGolsContra = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"nrgolscontra"] integerValue]];
            farroupilha.empates = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"empates"] integerValue]];
            farroupilha.derrotas = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"derrotas"] integerValue]];
            farroupilha.jogos = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"jogos"] integerValue]];
        }
        else
        {
            farroupilha.pontosGanhos = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"pontosganhos"] integerValue]];
            farroupilha.nrVitorias = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"nrvitorias"] integerValue]];
            farroupilha.saldoGols = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"saldogols"] integerValue]];
            farroupilha.nrGolsMarcados = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"nrgolsmarcados"] integerValue]];
            farroupilha.dsgrupo = [dictFarroupilha objectForKey:@"grupo"];
            farroupilha.posicao = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"posicao"] integerValue]];
            farroupilha.nrGolsContra = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"nrgolscontra"] integerValue]];
            farroupilha.empates = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"empates"] integerValue]];
            farroupilha.derrotas = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"derrotas"] integerValue]];
            farroupilha.jogos = [NSNumber numberWithInteger:[[dictFarroupilha objectForKey:@"jogos"] integerValue]];
        }
        
        Clube *clube = [DAOClube fetchClubeWithCode:[[dictFarroupilha objectForKey:@"codigo"] intValue]];
        
        if (clube == nil)
        {
            NSDictionary *dictClube = [dictFarroupilha objectForKey:@"clube"];
            clube = [NSEntityDescription insertNewObjectForEntityForName:@"Clube" inManagedObjectContext:context];
            clube.codigo = [NSNumber numberWithInteger:[[dictClube objectForKey:@"codigo"] integerValue]];
            clube.nome = [dictClube objectForKey:@"nome"];
            clube.escudo = [dictClube objectForKey:@"escudo"];
            clube.sigla = [dictClube objectForKey:@"sigla"];
        }
        
        [farroupilha setClube:clube];
        
    }
    
    NSError *saveError;
    
    [context save:&saveError];
}

@end

