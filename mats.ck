BPM bpm;
PentaScale scale;

fun void daSaw() {
    TriOsc t => PitShift p => dac;
    1.0 => p.mix;
    
    0.0 => float theshift;
    scale.freq(2,4) => t.freq;
    while (true) {
        theshift + 0.05 => theshift;
        theshift => p.shift;
        if (theshift > 30.0) {
           0.0 => theshift;
        }
        1 :: ms => now; 
    }
}

fun void testBend() {
    TriOsc t => PitShift p => dac;
    1.0 => p.mix;
    [BPM.sixteenth,BPM.eighth,BPM.sixteenth,BPM.sixteenth,BPM.quarter] @=> dur scratchdurations[];
    
    0.0 => float theshift;
    scale.freq(2,5) => t.freq;
    0 => int scratchindex;
    while (true) {
        scale.freq(Math.random2(0,6),4) => t.freq;
        bend(p, scratchdurations[scratchindex], BPM.sixteenth);
        0.0 => t.gain;
        BPM.thirtysecond*0.5 => now;
        1.0 => t.gain; 
        scratchindex++;
        if (scratchindex > 4) {
            0 => scratchindex;
        }
    }
}

fun float bend(PitShift pit, dur duration, dur upduration) {
    0.0 :: samp => dur thetime;
    0.0 :: samp => dur zerotime;
    30::samp => dur step; 
    0.0 => float bendvalue;
    0.03 => float bendstep;
    while (thetime < zerotime + upduration) {
       thetime + step => thetime;
       bendvalue + bendstep => bendvalue;
       bendvalue => pit.shift; 
       step => now;
       <<< thetime >>>;  
    }
    while (thetime < duration) {
        thetime + step => thetime;
        bendvalue - bendstep => bendvalue;
        if (bendvalue < 0.0 ) {
            0.0 => bendvalue;
        }
        bendvalue => pit.shift; 
        step => now;
        <<< thetime, bendvalue>>>;  
    }
}
    

fun void matsMain() {
    PulseOsc tone => ADSR pluck => DelayA str => dac;
    
    // hook string back into itself
    // Feedback delay through a low-pass loop filter
    //str => OneZero lowPass => str;
    
    0.03 => tone.width;
    
    // OBS! Satt inte aver 0.5. Du blaser trumhinnorna!
    //0.48 => lowPass.b0;    
    
    // set ADSR noise envelope parameters
    // Sets ADSR parameters to pluck rapidly and then stick at 0.0
    pluck.set(0.002 :: second, 0.002 :: second, 0.5, 0.01 :: second);
    
    // Play random notes forever
    while (true)
    {
        // Can now set delay length to any arbitrary float number
        // Notera att lagre delay ju blir snabbare frekvens, sa hogre ton.
        1 => pluck.keyOn;  // Plucks by sending keyOn to float number ADSR, 
        slideUp(str, 5, 0, 3, BPM.thirtysecond, BPM.quarter);
        0 => pluck.keyOn;  // Plucks by sending keyOn to float number ADSR, 
        
        //scale.delayInSamps(Math.random2(0, 6),4) :: samp => str.delay;
        
        // gates noise into string
        BPM.quarter => now;
    }
}

fun void slideUp(DelayA d, int octave, int starttone, int stoptone, dur steptime, dur sustaintime) {
    scale.delayInSamps(starttone, octave) :: samp => dur delay;
    scale.delayInSamps(stoptone, octave) :: samp => dur stopdelay;
    while (delay > stopdelay) {
        //<<< "delay=" delay  " stopdelay=" stopdelay >>> 
       <<< delay, stopdelay >>>; 
       delay - 5::samp => delay; 
       delay => d.delay;
       steptime => now;  
    }
    stopdelay => d.delay;
    sustaintime => now;    
}


fun void sinwave() { 
    SinOsc s => dac;
    while (true) {
        0.5 => s.gain;
        scale.freq(0,4) => s.freq;
        bpm.quarter => now;
        0.0 => s.gain;
        bpm.quarter => now;        
    }
}

bpm.tempo(120);

spork ~ testBend();         
16*bpm.whole => now;

