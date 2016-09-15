BPM bpm;
PentaScale scale;


fun void sinwave() { 
    SinOsc s => dac;
    while (true) {
        0.5 => s.gain;
        scale.freq(0,2) => s.freq;
//        440.0 => s.freq;
        bpm.quarter => now;
        0.0 => s.gain;
        bpm.quarter => now;        
    }
}

bpm.tempo(120);

spork ~ sinwave();         
16*bpm.whole => now;

