BPM bpm;
PentaScale scale;


// Kick drum function
fun void kick() {         // (2) Function to play kick drum.
    SndBuf kick => dac;
    me.dir()+"./audio/kick_01.wav" => kick.read;
    // only play every whole note
    while (true) {
        bpm.quarter => now;
        0 => kick.pos;
    }
}

fun void doubleKick() {         // (2) Function to play kick drum.
    SndBuf kick => dac;
    me.dir()+"./audio/kick_01.wav" => kick.read;

    bpm.half => now;
    0 => kick.pos;
    bpm.half => now;
    0 => kick.pos;
}

fun void bass() { 
    SinOsc s => dac;
    while (true) {
        0.4 => s.gain;
        scale.freq(0,4) => s.freq;
        bpm.eighth => now;
        scale.freq(5,4) => s.freq;
        bpm.eighth => now;
    }
}

fun void betterBass() { 
    // PulseOsc s => dac;
    Noise nois => ADSR pluck => DelayA str => dac;
    str => OneZero lowPass => str;
    0.48 => lowPass.b0;
    pluck.set(0.002 :: second, 0.002 :: second, 0.0, 0.01 :: second);

    0.8 => str.gain;

    while (true) {
      scale.delayInSamps(0, 2) :: samp => str.delay;
      1 => pluck.keyOn;  
      bpm.eighth => now;
      scale.delayInSamps(5, 2) :: samp => str.delay;
      1 => pluck.keyOn;  
      bpm.eighth => now;
    }
}


fun void horns(int note) {
  // PulseOsc s => dac; // connect a new PulseOsc to dac
  Brass trump => NRev rev => dac;
  0.02 => rev.mix;

  while (true) {
    1 => trump.stopBlowing;
    bpm.whole / 2.0 => now;

    // one
    1 => trump.stopBlowing;
    bpm.thirtysecond / 2.0 => now;

    0.5 => trump.startBlowing;
    scale.freq(note,6) => trump.freq;
    bpm.thirtysecond / 2.0 => now;
    
    scale.freq(note,6) => trump.freq;
    bpm.thirtysecond / 2.0 => now;

    1 => trump.stopBlowing;    
    bpm.thirtysecond / 2.0 => now;

    // Two
    1 => trump.stopBlowing;    
    bpm.thirtysecond / 2.0 => now;

    0.4 => trump.startBlowing;
    scale.freq(note,6) => trump.freq;
    bpm.sixteenth / 2.0 => now;

    1 => trump.stopBlowing;
    bpm.thirtysecond / 2.0 => now;
    

    // third
    1 => trump.stopBlowing;
    bpm.eighth / 2.0 => now;
    
    // four
    1 => trump.stopBlowing;    
    bpm.sixteenth / 2.0 => now;

    0.6 => trump.startBlowing;    
    scale.freq(note,6) => trump.freq;
    bpm.sixteenth / 2.0 => now;
    
    scale.freq(note,6) => trump.freq;
    bpm.sixteenth / 2.0 => now;
    1 => trump.stopBlowing;
    bpm.sixteenth / 2.0 => now;

    // five 
    1 => trump.stopBlowing;
    bpm.quarter / 2.0 => now;
    1 => trump.stopBlowing;
    bpm.eighth / 2.0 => now;


    // 0.0 => s.gain;
    // bpm.quarter / 2.0 => now;
    // 0.0 => s.gain;
    // bpm.eighth / 2.0 => now;

    // 0.0 => s.gain;
    // bpm.whole / 2.0 => now;

    // 0.0 => s.gain;
    // bpm.half / 2.0 => now;

  }

}


fun void hornsLong(int note) {
  // PulseOsc s => dac; // connect a new PulseOsc to dac
  Brass trump => NRev rev => dac;
  0.02 => rev.mix;

  while (true) {
    1 => trump.stopBlowing;
    bpm.whole / 2.0 => now;

    // one
    1 => trump.stopBlowing;
    bpm.thirtysecond / 2.0 => now;

    0.5 => trump.startBlowing;
    scale.freq(note,6) => trump.freq;
    bpm.thirtysecond / 2.0 => now;
    
    scale.freq(note,6) => trump.freq;
    bpm.thirtysecond / 2.0 => now;

    1 => trump.stopBlowing;    
    bpm.thirtysecond / 2.0 => now;

    // Two
    1 => trump.stopBlowing;    
    bpm.thirtysecond / 2.0 => now;

    0.4 => trump.startBlowing;
    scale.freq(note,6) => trump.freq;
    bpm.sixteenth / 2.0 => now;

    1 => trump.stopBlowing;
    bpm.thirtysecond / 2.0 => now;
    

    // third
    1 => trump.stopBlowing;
    bpm.eighth / 2.0 => now;
    
    // four
    1 => trump.stopBlowing;    
    bpm.sixteenth / 2.0 => now;

    0.6 => trump.startBlowing;    
    scale.freq(note,6) => trump.freq;
    bpm.sixteenth / 2.0 => now;
    
    scale.freq(note,6) => trump.freq;
    bpm.sixteenth / 2.0 => now;
    // 1 => trump.stopBlowing;
    bpm.sixteenth / 2.0 => now;

    // five 
    // 1 => trump.stopBlowing;
    bpm.quarter / 2.0 => now;

    1 => trump.stopBlowing;
    bpm.eighth / 2.0 => now;

    // 0.0 => s.gain;
    // bpm.quarter / 2.0 => now;
    // 0.0 => s.gain;
    // bpm.eighth / 2.0 => now;

    // 0.0 => s.gain;
    // bpm.whole / 2.0 => now;

    // 0.0 => s.gain;
    // bpm.half / 2.0 => now;

  }

}

fun void guitar() { 
    // PulseOsc s => dac;
    Noise nois => ADSR pluck => DelayA str => dac;
    str => OneZero lowPass => str;
    0.48 => lowPass.b0;
    pluck.set(0.002 :: second, 0.002 :: second, 0.0, 0.01 :: second);

    0.8 => str.gain;

    while (true) {
      scale.delayInSamps(0, 6) :: samp => str.delay;
      1 => pluck.keyOn;  
      bpm.eighth => now;
      scale.delayInSamps(2, 6) :: samp => str.delay;
      1 => pluck.keyOn;  
      bpm.eighth => now;
      scale.delayInSamps(3, 6) :: samp => str.delay;
      1 => pluck.keyOn;  
      bpm.eighth => now;
      scale.delayInSamps(4, 6) :: samp => str.delay;
      1 => pluck.keyOn;  
      bpm.eighth => now;

    }
}

// Snare drum function
fun void snare() {        // (3) Function to play snare drum.
    SndBuf snare => dac;
    me.dir()+"./audio/snare_01.wav" => snare.read;
    // play with half note tempo
    while (true) {
        bpm.half => now;
        0 => snare.pos;
    }
}
// Hi hat drum function
fun void hihat() {        // (4) Function to play hi-hat.
    SndBuf hihat => dac;
    me.dir()+"./audio/hihat_01.wav" => hihat.read;
    0.1 => hihat.gain;
    // play every quarter note
    while (true) {
        0.05 => hihat.gain;
        bpm.sixteenth => now;
        0 => hihat.pos;
        0.1 => hihat.gain;
        bpm.sixteenth => now;
        0 => hihat.pos;
        0.05 => hihat.gain;
        bpm.sixteenth => now;
        0 => hihat.pos;
        0.05 => hihat.gain;
        bpm.sixteenth => now;
        0 => hihat.pos;
        0.05 => hihat.gain;
        bpm.sixteenth => now;
        0 => hihat.pos;

    }
}

bpm.tempo(120);

spork ~ hihat();
spork ~ snare();
1*bpm.whole => now;
spork ~ doubleKick();
1*bpm.whole => now;
spork ~ bass();
spork ~ kick();
2*bpm.whole => now;
spork ~ guitar();
4*bpm.whole => now;
spork ~ horns(5);
4*bpm.whole => now;
spork ~ horns(3);
1*bpm.whole => now;
spork ~ horns(1);
spork ~ horns(0);
2*bpm.whole => now;
spork ~ hornsLong(0);
// spork ~ hornsLong(1);
spork ~ hornsLong(2);
spork ~ hornsLong(3);
// spork ~ hornsLong(4);
spork ~ hornsLong(5);
// spork ~ hornsLong(6);
1*bpm.whole => now;

