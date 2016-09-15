BPM bpm;
CScale scale;


fun void sinwave() { 
    SinOsc s => dac;
    while (true) {
        0.5 => s.gain;
        scale.freq(0,3) => s.freq;
        bpm.quarter => now;
        0.0 => s.gain;
        bpm.quarter => now;        
    }
}

fun void guitarplucks() { 
    Noise nois => ADSR pluck => DelayA str => dac;
    str => OneZero lowPass => str;
    // OBS! Sätt inte äver 0.5. Du blåser trumhinnorna!
    0.48 => lowPass.b0;
    pluck.set(0.002 :: second, 0.002 :: second, 0.0, 0.01 :: second);

    while (true) {
      scale.delayInSamps(Math.random2(0, 6), 4) :: samp => str.delay;
      1 => pluck.keyOn;  
      bpm.quarter => now;
    }
}

// Snare drum function
fun void snare() {        // (3) Function to play snare drum.
    SndBuf snare => dac;
    me.dir()+"../audio/snare_01.wav" => snare.read;
    // play with half note tempo
    while (true) {
        bpm.half => now;
        0 => snare.pos;
    }
}

// Hi hat drum function
fun void hihat() {        // (4) Function to play hi-hat.
    SndBuf hihat => dac;
    me.dir()+"../audio/hihat_01.wav" => hihat.read;
    0.2 => hihat.gain;
    // play every quarter note
    while (true) {
        bpm.quarter => now;
        0 => hihat.pos;
    }
}

// Main program to spork our individual drum functions
// start off with kick drum for two measures


bpm.tempo(120);

spork ~ guitarplucks();         
spork ~ sinwave();         
2*bpm.whole => now;

// then add in hi hat after two measures
spork ~ hihat();        // (6) Sporks hi-hat after a time
2*bpm.whole => now;

// add snare, but on off beats (quarter delayed start)
bpm.quarter => now;
spork ~ snare();        // (7) Sporks snare starting on off beat

// let it run for four more measures
4*bpm.whole => now;         // (8) Lets it all run for four more measures
