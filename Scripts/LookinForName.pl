################################################################################################
## Minería de datos: Buscar transcritos relacionados con auxinas, giberelinas y etileno       ##                                                                  
## Author: Olga Andrea Hernandez Miranda, Miranda H                                           ##
## Date: 23/01/2021                                                                           ##
## Este script permite buscar un nombre como auxinas, giberelinas y etileno en tperminos GO   ##
## para generar una base de datos con transcritos asociados a esa anotación.                  ##                                                                                     
################################################################################################
#!/usr/bin/perl -w
use strict;
my $archivoAnotada="Anotada.Trinity.isoform.counts.matrix.ETAPA3_vs_ETAPA4.DESeq2.DE_results.csv";
open(INPUT1,"$archivoAnotada"); 
my @contenidoAnotada = <INPUT1>; 
chomp @contenidoAnotada;
my $longitudarreglo1=scalar@contenidoAnotada;
print "Imprimiendo la longitud del arreglo de la tabla $longitudarreglo1\n";

my $archivoSalida="Aux_Et_GA_E3vsE4.csv";
open(OUTPUT1,">$archivoSalida"); 


for(my $i=0;$i<$longitudarreglo1;$i++){
    my $FilaAnotada =$contenidoAnotada[$i];
    my @segmentos =split(",",$FilaAnotada);
        chomp@segmentos;
        my$BP= $segmentos[25];
        my$MF= $segmentos[27];
        my$CC= $segmentos[29];
        
if ($BP =~ "ethylene" or $MF =~ "ethylene" or $CC =~ "ethylene"){
            print "$FilaAnotada\n";
            print OUTPUT1 "$FilaAnotada\n";
        }
        if ($BP =~ "gibberellin" or $MF =~ "gibberellin" or $CC =~ "gibberellin"){
            print "$FilaAnotada\n";
            print OUTPUT1 "$FilaAnotada\n";
        }
        if ($BP =~ "auxin" or $MF =~ "auxin" or $CC =~ "auxin"){
            print "$FilaAnotada\n";
            print OUTPUT1 "$FilaAnotada\n";
            }
}