BPM bpm;
PentaScale scale;

fun void fiaCOOL() {
     
     
     SndBuf click_01 =>  Pan2 panny => dac;
     me.dir()+"/audio/kick_01.wav" => click_01.read;
     
     SndBuf click_02 => dac;
     me.dir()+"/audio/clap_01.wav" => click_02.read;
     
    while (true) {
        Math.random2f( -1, 1 ) => panny.pan;
        bpm.sixteenth => now;     
        0 => click_01.pos;
        bpm.sixteenth => now;     
        0 => click_01.pos;
        
        bpm.eighth => now;
        scale.freq(4,4) => click_02.freq;              
        0 => click_02.pos;


        bpm.eighth => now;
        0 => click_01.pos;
                
        bpm.eighth => now;
        scale.freq(2,4) => click_02.freq;     
        0 => click_02.pos;   

            
    }
    
}

bpm.tempo(120);

spork ~ fiaCOOL();
16*bpm.whole => now; 