BPM bpm;
PentaScale scale;

fun void sinwave() { 
    dur tempo;
    bpm.sixteenth => tempo;    
    
    SinOsc s => Gain input => dac;
    0.5 => input.gain;
    
    input => Delay d1 => dac;
    input => Delay d2 => dac;
    input => Delay d3 => dac;
    d1 => d1;
    d2 => d2;
    d3 => d3;
    
    //0.6 => d1.gain => d2.gain => d3.gain;
    //0.057 :: second => d1.max => d1.delay; 
    //0.083 :: second => d2.max => d2.delay; 
    //0.97 :: second => d3.max => d3.delay;
    
    0.4 => s.gain;
    while(true) {
        scale.freq(0,3) => s.freq;
        tempo => now;
        scale.freq(2,3) => s.freq;    
        tempo => now;
        scale.freq(3,3) => s.freq;        
        tempo => now;
        scale.freq(4,3) => s.freq;        
        tempo => now;
        scale.freq(5,3) => s.freq;        
        tempo => now;
        scale.freq(2,3) => s.freq;        
        tempo => now;
        scale.freq(4,3) => s.freq;        
        tempo => now;
        scale.freq(5,3) => s.freq;        
        tempo => now;
    }
}

// Main program to spork our individual drum functions
// start off with kick drum for two measures


bpm.tempo(120);
spork ~ sinwave();

16*bpm.whole => now;
