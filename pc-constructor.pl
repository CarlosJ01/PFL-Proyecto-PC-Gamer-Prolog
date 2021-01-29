procesador(intel_corei7,8000).
procesador(intel_corei5,5500).
procesador(amd_ryzen5,6000).
procesador(amd_ryzen7,7500).

grafica(nvidia_rtx_2080,15000).
grafica(nvidia_rtx_3080,25000).
grafica(amd_radeon_vega8,4000).
grafica(amd_radeon_vega10,6000).

ram(kingston_8gb,971).
ram(gigabyte_8gb,1000).
ram(hyperx_16gb,1750).

motherboard(asus_atx_rog,3000).
motherboard(asus_atx_tuf,2500).
motherboard(gigabyte,4000).

almacenamiento(ssd_adata_650gb,750).
almacenamiento(ssd_kingston_960gb,2000).
almacenamiento(ssd_m2_adata_960gb,4000).
almacenamiento(hdd_seagate_1tb, 500).

juego(warzone).
juego(league_of_legends).
juego(fornite).
juego(star_wars_battlefont).
juego(gta_v).
juego(cyberpunk_2077).

compatibilidad(amd_ryzen5, amd_radeon_vega10, [league_of_legends, fornite]).
compatibilidad(amd_ryzen7, nvidia_rtx_3080, [warzone, star_wars_battlefont, fornite, cyberpunk_2077, gta_v]).
compatibilidad(intel_corei7, nvidia_rtx_2080, [league_of_legends, fornite, gta_v, fornite]).
compatibilidad(intel_corei5, nvidia_rtx_2080, [league_of_legends, fornite]).

miembro(X, [X|_]):-!.
miembro(X, [_|T]):-miembro(X,T).

%% indica que juego quiero correr
%% X->Lista juegos, J ->juego
computadora2(P,G,R,M,A, Costo, Tope, J):-procesador(P, Pp), grafica(G, Gp), 
				ram(R, Rp), motherboard(M, Mp), almacenamiento(A, Ap), juego(J),
				compatibilidad(P, G, X), miembro(J, X),
				Costo is Pp + Gp + Rp + Mp + Ap,
				Tope>=Costo.

%%								(J=lista de juego)
computadora(P,G,R,M,A, Costo, Tope):-procesador(P, Pp), grafica(G, Gp), 
				ram(R, Rp), motherboard(M, Mp), almacenamiento(A, Ap),
				compatibilidad(P, G, _),
				Costo is Pp + Gp + Rp + Mp + Ap,
				Tope>=Costo.






