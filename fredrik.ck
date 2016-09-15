BPM bpm;
PentaScale scale;

fun void frKick() {
    SndBuf mySound => dac;
    me.dir()+"./audio/fredrik_kick.wav" => mySound.read;
    1.0 => mySound.rate; 
    0 => mySound.pos;
    bpm.quarter => now;
}

fun void frWholeKick() {
    4 => int times;
    while (times > 0) {
        spork ~ frKick();
        bpm.quarter => now;
        times--;
    }
}

fun void frDoubleKick() {
    3 => int times;
    while (times > 0) {
        spork ~ frKick();
        bpm.quarter => now;
        times--;
    }
    
    2 => times;
    while (times > 0) {
        spork ~ frKick();
        bpm.eighth => now;
        times--;
    }
}

fun void frFourKick() {
    3 => int times;
    while (times > 0) {
        spork ~ frKick();
        bpm.quarter => now;
        times--;
    }
    
    4 => times;
    while (times > 0) {
        spork ~ frKick();
        bpm.sixteenth => now;
        times--;
    }
}

fun void frSixteenthKick() {
    16 => int times;
    while (times > 0) {
        spork ~ frKick();
        bpm.sixteenth => now;
        times--;
    }
}

fun void frThirtysecondKick() {
    32 => int times;
    while (times > 0) {
        spork ~ frKick();
        bpm.thirtysecond => now;
        times--;
    }
}

// KICK 2

fun void frKick2() {
    SndBuf mySound => dac;
    me.dir()+"./audio/fredrik_kick2.wav" => mySound.read;
    1.0 => mySound.rate; 
    0 => mySound.pos;
    bpm.quarter => now;
}

fun void frWholeKick2() {
    4 => int times;
    while (times > 0) {
        spork ~ frKick2();
        bpm.quarter => now;
        times--;
    }
}

fun void frDoubleKick2() {
    3 => int times;
    while (times > 0) {
        spork ~ frKick2();
        bpm.quarter => now;
        times--;
    }
    
    2 => times;
    while (times > 0) {
        spork ~ frKick2();
        bpm.eighth => now;
        times--;
    }
}

fun void frFourKick2() {
    3 => int times;
    while (times > 0) {
        spork ~ frKick2();
        bpm.quarter => now;
        times--;
    }
    
    4 => times;
    while (times > 0) {
        spork ~ frKick2();
        bpm.sixteenth => now;
        times--;
    }
}

fun void frSixteenthKick2() {
    16 => int times;
    while (times > 0) {
        spork ~ frKick2();
        bpm.sixteenth => now;
        times--;
    }
}

fun void frThirtysecondKick2() {
    32 => int times;
    while (times > 0) {
        spork ~ frKick2();
        bpm.thirtysecond => now;
        times--;
    }
}

fun void melody() {
    // patch
    Wurley voc => dac;
    
    220.0 => voc.freq;
    1 => voc.gain;
    
    // our main loop
    while( true ) { 
        // pentatonic
        scale.freq(3, 5) => voc.freq;
        1 => voc.noteOn;
        bpm.quarter => now;
        
        scale.freq(0, 5) => voc.freq;
        1 => voc.noteOn;
        bpm.quarter => now;
        
        scale.freq(1, 5) => voc.freq;
        1 => voc.noteOn;
        bpm.quarter => now;
        
        scale.freq(1, 5) => voc.freq;
        1 => voc.noteOn;
        bpm.quarter => now;
        
        // LULZ
        
        scale.freq(4, 5) => voc.freq;
        1 => voc.noteOn;
        bpm.quarter => now;
        scale.freq(6, 5) => voc.freq;
        1 => voc.noteOn;
        bpm.quarter => now;
        scale.freq(3, 5) => voc.freq;
        1 => voc.noteOn;
        bpm.quarter => now;
        scale.freq(1, 5) => voc.freq;
        1 => voc.noteOn;
        bpm.quarter => now;
    }
}

bpm.tempo(120);

frWholeKick();         // 1
frDoubleKick();        // 2
frWholeKick();         // 3
frFourKick();          // 4
frWholeKick();         // 5
frDoubleKick();        // 6
frSixteenthKick();     // 7
frThirtysecondKick();  // 8

spork ~ melody();

frWholeKick2();        // 9
frDoubleKick2();       // 10
frWholeKick2();        // 11
frFourKick2();         // 12
frWholeKick2();        // 13
frDoubleKick2();       // 14
frSixteenthKick2();    // 15
frThirtysecondKick2(); // 16

