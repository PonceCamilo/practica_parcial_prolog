/* auto(modelo)
moto(anioDeFabricacion, suspensionesExtras)
camion(items)
cuatri(marca) */
%ganador(AnioGanado, Ganador, Vehiculo).

ganador(1997,peterhansel,moto(1995, 1)).
ganador(1998,peterhansel,moto(1998, 1)).
ganador(2010,sainz,auto(touareg)).
ganador(2010,depress,moto(2009, 2)).
ganador(2010,karibov,camion([vodka, mate])).
ganador(2010,patronelli,cuatri(yamaha)).
ganador(2011,principeCatar,auto(touareg)).
ganador(2011,coma,moto(2011, 2)).
ganador(2011,chagin,camion([repuestos, mate])).
ganador(2011,patronelli,cuatri(yamaha)).
ganador(2012,peterhansel,auto(countryman)).
ganador(2012,depress,moto(2011, 2)).
ganador(2012,deRooy,camion([vodka, bebidas])).
ganador(2012,patronelli,cuatri(yamaha)).
ganador(2013,peterhansel,auto(countryman)).
ganador(2013,depress,moto(2011, 2)).
ganador(2013,nikolaev,camion([vodka, bebidas])).
ganador(2013,patronelli,cuatri(yamaha)).
ganador(2014,coma,auto(countryman)).
ganador(2014,coma,moto(2013, 3)).
ganador(2014,karibov,camion([tanqueExtra])).
ganador(2014,casale,cuatri(yamaha)).
ganador(2015,principeCatar,auto(countryman)).
ganador(2015,coma,moto(2013, 2)).
ganador(2015,mardeev,camion([])).
ganador(2015,sonic,cuatri(yamaha)).
ganador(2016,peterhansel,auto(2008)).
ganador(2016,prince,moto(2016, 2)).
ganador(2016,deRooy,camion([vodka, mascota])).
ganador(2016,patronelli,cuatri(yamaha)).
ganador(2017,peterhansel,auto(3008)).
ganador(2017,sunderland,moto(2016, 4)).
ganador(2017,nikolaev,camion([ruedaExtra])).
ganador(2017,karyakin,cuatri(yamaha)).
ganador(2018,sainz,auto(3008)).
ganador(2018,walkner,moto(2018, 3)).
ganador(2018,nicolaev,camion([vodka, cama])).
ganador(2018,casale,cuatri(yamaha)).
ganador(2019,principeCatar,auto(hilux)).
ganador(2019,prince,moto(2018, 2)).
ganador(2019,nikolaev,camion([cama, mascota])).
ganador(2019,cavigliasso,cuatri(yamaha)).

pais(peterhansel,francia).
pais(sainz,espania).
pais(depress,francia).
pais(karibov,rusia).
pais(patronelli,argentina).
pais(principeCatar,catar).
pais(coma,espania).
pais(chagin,rusia).
pais(deRooy,holanda).
pais(nikolaev,rusia).
pais(casale,chile).
pais(mardeev,rusia).
pais(sonic,polonia).
pais(prince,australia).
pais(sunderland,reinoUnido).
pais(karyakin,rusia).
pais(walkner,austria).
pais(cavigliasso,argentina).

%marcas autos

tiene(peugeot, 2008).
tiene(peugeot, 3008).
tiene(volkswagen, touareg ).
tiene(mini, countryman ).
tiene(toyota, hilux ).

%para agregar que el modelo buggy es marca mini, solo hace falta agregar tiene(mini, buggy).
%para decir que el modelo dkr no lo es, no hace falta agregar nada, por el concepto del universo cerrado.

ganadorReincidente(Ganador):-
    ganador(Anio1, Ganador, _),
    ganador(Anio2, Ganador, _),
    Anio1 \= Anio2.

inspiraA(Inspirador, Inspirado):-
    ganador(_, Inspirador, _),
    not(ganador(_, Inspirado, _)),
    pais(Inspirador, Pais),
    pais(Inspirado, Pais2),
    Pais = Pais2.

inspiraA(Inspirador, Inspirado):-
    ganador(Anio1, Inspirador, _),
    ganador(Anio2, Inspirado, _),
    Anio1 < Anio2,
    pais(Inspirador, Pais),
    pais(Inspirado, Pais2),
    Pais = Pais2.

tipoMarca(auto(Modelo), Marca):-
    tiene(Marca, Modelo).

tipoMarca(moto(AnioDeFabricacion, _), Marca):-
    AnioDeFabricacion >= 2000,
    Marca = ktm.

tipoMarca(moto(AnioDeFabricacion, _), Marca):-
    AnioDeFabricacion < 2000,
    Marca = yamaha.

tipoMarca(camion(Items), Marca):-
    member(vodka, Items),
    Marca = kamaz.

tipoMarca(camion(Items), Marca):-
    not(member(vodka, Items)),
    Marca = iveco.

tipoMarca(cuatri(Marca), Marca).

marcaDeLaFortuna(Conductor, Marca):-
    ganador(_, Conductor, Vehiculo),
    tipoMarca(Vehiculo, Marca).

vehiculoCaro(Vehiculo):-
    tipoMarca(Vehiculo) = mini.

vehiculoCaro(Vehiculo):-
    tipoMarca(Vehiculo) = toyota.

vehiculoCaro(Vehiculo):-
    tipoMarca(Vehiculo) = iveco.

vehiculoCaro(moto(_,SuspensionesExtras)):-
    SuspensionesExtras >= 3.

vehiculoCaro(cuatri(_)).

heroePopular(Heroe) :-
    inspiraA(Heroe, _),
    ganador(Anio, Heroe, Vehiculo),
    not(vehiculoCaro(Vehiculo)),
    forall((ganador(Anio, OtroCorredor, OtroVehiculo), OtroCorredor \= Heroe), vehiculoCaro(OtroVehiculo)).


etapa(marDelPlata,santaRosa,60).
etapa(santaRosa,sanRafael,290).
etapa(sanRafael,sanJuan,208).
etapa(sanJuan,chilecito,326).
etapa(chilecito,fiambala,177).
etapa(fiambala,copiapo,274).
etapa(copiapo,antofagasta,477).
etapa(antofagasta,iquique,557).
etapa(iquique,arica,377).
etapa(arica,arequipa,478).
etapa(arequipa,nazca,246).
etapa(nazca,pisco,276).
etapa(pisco,lima,29).

distanciaEntreLocaciones(Origen, Destino, Kilometros):-
    etapa(Origen, Destino, Kilometros).

distanciaEntreLocaciones(Origen, Destino, TotalKilometros):-
    etapa(Origen, LocacionIntermedia, KilometrosIntermedios),
    distanciaEntreLocaciones(LocacionIntermedia, Destino, KilometrosRestantes),
    TotalKilometros is KilometrosIntermedios + KilometrosRestantes.

distanciaMax(Vehiculo, 2000):-
    vehiculoCaro(Vehiculo).

distanciaMax(Vehiculo, 1800):-
    not(vehiculoCaro(Vehiculo)).

distanciaMax(camion(Items), Distancia):-
    length(Items,  Cantidad),
    Distancia is Cantidad * 1000.

destinoMasLejano(Vehiculo, Origen, Distancia, DestinoFinal):-
    distanciaMax(Vehiculo, Distancia),
    findall(DestinoPosible, (distanciaEntreLocaciones(Origen, DestinoPosible, DistanciaMax), DistanciaMax < Distancia), ListaDestinos),
    last(ListaDestinos, DestinoFinal).