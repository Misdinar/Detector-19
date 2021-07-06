:- dynamic iya/1,tidak/1.

start_sistem :-
    write('===== - - - - - - INITIALIZATION. - - - - - - ====='),nl,
    write('.............................................................................'),nl,
    write('===== - - - - - - LOADING ( ◡́.◡̀) - - - - - - ====='),nl,
    write('.............................................................................'),nl,
    write('===== - - - SYSTEM ONLINE ( ͡ᵔ ͜ʖ ͡ᵔ)/ - - - ====='),nl,
    write('.............................................................................'),nl,
    write('===== -  WELCOME TO DETECTOR-19 - ====='),nl,
    write('.............................................................................'),nl,
    mulai.

mulai :-
    write('👋(✿◠‿◠) : Halo, Aku Hana! yang akan membantumu disini'),nl,
    write('(✿◠‿◠) :sebelum mulai, boleh tahu siapa namamu?'),
    read(Nama),
	write('(✿◠‿◠) : halo '),write(Nama),nl,write('(✿◠‿◠) : Nama yang bagus ya. Oh iya, sekarang berapa usiamu?'),nl,
    read(Usia),
    
    % cek usia user
    (Usia > 30 -> (write('(✿◠‿◠) : Usia rentan penyakit nih, jaga kesehatan ya ( ◡́.◡̀)'),nl, Risiko is 5); 
                  (write('(✿◠‿◠) : Jaga lupa olahraga dan makan makanan yang sehat juga ya ᕙ(`▿´)ᕗ)'),nl, Risiko is 3)),
    write('(✿◠‿◠) : Berapa suhu tubuh saat ini?'),
	read(Suhu), 
    
    % cek umur user
    (Suhu > 37.4 -> (write('(✿◠‿◠) : Wah, kamu sepertinya terkena Demam nih (. ͡⊙ _> ͡⊙.)'),nl, Risiko1 is Risiko+5);
    	(write('(✿◠‿◠) : Jaga kesehatan ya, Jangan lupa pakai masker (^◡^ )'),nl, Risiko1 is Risiko)),
    write('(✿◠‿◠) : Apakah kamu sudah divaksin? iya/tidak'),
    read(Vaksin),
    
    % cek vaksinasi user
    (Vaksin == iya ->  write('(✿◠‿◠) : Amboy! mantap kali! Sudah berapa kali divaksin? satu/dua'),read(Vaksin1),
        (Vaksin1 == satu ->  Kebal is 0.79, write('(✿◠‿◠) : Keren! jangan lupa vaksinasi yang kedua ya (👍 ͡ᵔ ͜ʖ ͡ᵔ)👍');
    	write('(✿◠‿◠) : Mantap jiwa, ajak yang lain ikutan vaksinasi ya! (👍 ͡ᵔ ͜ʖ ͡ᵔ)👍'), Kebal is 0.85),nl;
    	write('(✿◠‿◠) : Wah, Ayo ikut vaksin secepatnya! (ɔ◔‿◔)ɔ ♥'),Kebal is 0, nl,true),

    % diagnosis umum
    write('(✿◠‿◠) : Baiklah, kita mulai skriningnya. Jawab dengan jujur, okey ( ͡ᵔ ͜ʖ ͡ᵔ) '), nl,
	diagnosis('penyakit umum', Risk_umum), nl,
    Total is Risk_umum + Risiko1,
    
    % diagnosis alpa
	write('(✿◠‿◠) : Ingin melanjutkan diagnosa Alpha/Beta? iya/tidak'),
    read(Jawaban),
	(Jawaban == iya -> diagnosis('Alpha/Beta',Risk_alpa), nl;
    	Risk_alpa_fix is Total, true),
    ((Jawaban == iya, Risk_alpa == 0) ->  Risk_alpa_fix is Total;true),
    ((Jawaban == iya, Risk_alpa =\= 0) ->  Risk_alpa_fix is Risk_alpa;true),
    Total2 is Total + Risk_alpa_fix,
    write( Risk_alpa_fix),
    % diagnosis delta
	write('(✿◠‿◠) : Ingin melanjutkan diagnosis Delta? iya/tidak'), nl,
    read(Jawaban2),
    (Jawaban2 == iya -> diagnosis('Delta',Risk_delta),nl;
    	Risk_delta_fix is Total,true),
    (Jawaban2 == iya, Risk_delta == 0 ->  Risk_delta_fix is Total;true),
    (Jawaban2 == iya, Risk_delta =\= 0 ->  Risk_delta_fix is Risk_delta;true),

    write('.............................................................................'),nl,
    write('===== - - CALCULATING (✿─‿‿─) - - ====='),nl,
    write('.............................................................................'),nl,
    
    nl, write('Dear, '), write(Nama),nl,
    write('- Kemungkinan Hasil tes positif: '),
    %hitung Kemungkinan Hasil tes positif
    (Jawaban == iya, Jawaban2 == tidak -> Total_umum is Total2; 
  	(Jawaban == tidak, Jawaban2 == iya -> Total_umum is Total + Risk_delta_fix; 
    (Jawaban == tidak, Jawaban2 == tidak -> Total_umum is Total; Total_umum is Total+Risk_alpa_fix+Risk_delta_fix, true))),
    PersenUmum is ((Total_umum)/88*82.3 - (Total_umum)/88*Kebal ), format("~2f", [PersenUmum]), write('%'),nl,
    
    %hitung Kemungkinan Terjangkit Virus COVID-19 varian Alpha/Beta
    write('- Kemungkinan Terjangkit Virus COVID-19 varian Alpha/Beta: '),
    PersenAlpha is (Risk_alpa_fix*1.74 - (Risk_alpa_fix*Kebal)),format("~2f", [PersenAlpha]),write('%'),nl,
    write(Risk_alpa_fix),nl,
    
    %hitung Kemungkinan Terjangkit Virus COVID-19 varian Delta
    write('- Kemungkinan Terjangkit Virus COVID-19 varian Delta: '),
    PersenDelta is (Risk_delta_fix *1.74*1.64 - (Risk_delta_fix*Kebal)),format("~2f", [PersenDelta]),write('%'),nl,nl,
    
    %saran penanganan berdasarkan hasil tes >50%
	(PersenUmum > 50 -> (write('(✿◠‿◠) : Wah kamu harus segera cek ke rumah sakit nih⁀⊙﹏☉⁀'),nl,
                 (write('(✿◠‿◠) : Jangan panik. Segera lakukan tes swab antigen ya, ini demi kamu dan orang disekitarmu (ɔ◔‿◔)ɔ ♥'),nl));
    %saran penanganan berdasarkan hasil tes <=50%        
    (write('(✿◠‿◠) : Tetap jaga kesehatan ya jangan lupa olahraga dan patuhi protokol kesehatan ✌≧◠‿◠≦'),nl,
            write('(✿◠‿◠) : Sepertinya badanmu sedang tidak fit,（っ＾▿＾）sebaiknya perbanyak istirahat dulu ya'), nl)),
    
    %saran penanganan varian COVID-19
	(PersenAlpha > PersenDelta -> (write('(✿◠‿◠) :Hati-hati dengan COVID-19 varian alpha/betha yaa, gunakan masker 2 lapis ya! (^◡^ )'),nl);
    	(write('(✿◠‿◠) : Hati-hati dengan COVID-19 varian delta yaa, gunakan masker 2 lapis ya! (^◡^ )'),nl,true)),
   
    % tes ulang atau selesai
   	write('(✿◠‿◠) : Apakah kamu ingin melakukan tes kembali? iya/tidak'),
        read(Jawaban3),
        (Jawaban3 == iya -> undo, mulai; 
        write('(✿◠‿◠) : Terima kasih telah menggunakan DETECTOR-19 (ɔ◔‿◔)ɔ ♥')).
  
%start diagnosis
diagnosis('penyakit umum', Sum_risk) :- umum( Sum_risk).
diagnosis('Alpha/Beta', Sum_risk) :- alpa(Sum_risk).
diagnosis('Delta',  Sum_risk) :- delta(Sum_risk).

umum(Sum_risk) :-
    Risiko is 0,
    symptom(pilek), (iya(pilek) -> Risiko1 is Risiko + 3; Risiko1 is Risiko, true),
	symptom('batuk kering'), (iya('batuk kering') -> Risiko2 is Risiko1 + 3; Risiko2 is Risiko1, true),
	symptom('sakit tenggorokan'), (iya('sakit tenggorokan') -> Risiko3 is Risiko2 + 3; Risiko3 is Risiko2, true),
	symptom(demam), (iya(demam) -> Sum_risk is Risiko3 + 3;Sum_risk is Risiko3, true),
    write('Selesai diagnosa umum. ✍(◔◡◔)').

alpa(Sum_risk) :-
    Risiko is 0,
	symptom('kelelahan/malaise'), (iya('kelelahan/malaise') -> Risiko1 is Risiko + 10; Risiko1 is Risiko, true),
	symptom('sesak nafas'), (iya('sesak nafas') -> Risiko2 is Risiko1 + 10; Risiko2 is Risiko1, true),
	symptom('Pusing/sakit kepala'), (iya('Pusing/sakit kepala') -> Risiko3 is Risiko2 + 10; Risiko3 is Risiko2, true),
	symptom('nyeri dada'), (iya('nyeri dada') -> Sum_risk is Risiko3 + 10; Sum_risk is Risiko3, true),
    write('Selesai diagnosis Alpha/Beta ✍(◔◡◔)').

delta(Sum_risk) :-
    Risiko is 0,
	symptom('pendengaran terganggu'), (iya('pendengaran terganggu') -> Risiko1 is Risiko + 8; Risiko1 is Risiko),
	symptom('sakit perut'), (iya('sakit perut') -> Risiko2 is Risiko1 + 5; Risiko2 is Risiko1),
	symptom('kekurangan darah'), (iya('kekurangan darah') -> Risiko3 is Risiko2 + 8; Risiko3 is Risiko2),
	symptom(diare), (iya(diare) -> Sum_risk is Risiko3 + 5; Sum_risk is Risiko3),
	write('Selesai diagnosis Delta ✍(◔◡◔)').

%menyimpan data gejala yang ada pada user di database iya
tanya(Gejala) :-
write('Apakah kamu merasakan '), write(Gejala), write('? iya/tidak'),
read(Jawaban),
((Jawaban == iya) -> assert(iya(Gejala)) ; assert(tidak(Gejala)),true).

symptom(S) :-
(iya(S) -> true ; (tidak(S) -> fail ; tanya(S))).

%reset database
undo :- retract(iya(_)),fail.
undo :- retract(tidak(_)),fail.
undo.
