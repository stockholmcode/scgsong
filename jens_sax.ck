BPM bpm;
PentaScale scale;

fun void playing() {
  Saxofony s => NRev rev => dac;
  0.04 => rev.mix;

  0 => int i;
  while (i < 17) {
    1 => s.startBlowing;
    scale.freq(0,3) => s.freq;
    bpm.eighth => now;
    1 => s.stopBlowing;
    bpm.eighth => now;

    1 => s.stopBlowing;
    bpm.eighth => now;
    
    1 => s.startBlowing;
    scale.freq(1,3) => s.freq;    
    bpm.eighth => now;

    1 => s.stopBlowing;

    1 => s.stopBlowing;
    bpm.eighth => now;

    1 => s.startBlowing;
    scale.freq(2,3) => s.freq;
    bpm.eighth => now;

    1 => s.startBlowing;
    scale.freq(3,3) => s.freq;
    bpm.eighth => now;
    1 => s.stopBlowing;
    bpm.eighth => now;

    i++;
  }
}

fun void horns(int note) {
  Brass s => NRev rev => dac;
  0.04 => rev.mix;

  0 => int i;
  while (i < 5) {
    1 => s.startBlowing;
    scale.freq(note,7) => s.freq;
    bpm.whole => now;
    bpm.whole => now;
    0.8 => s.stopBlowing;
    bpm.whole => now;
    bpm.whole => now;
    i++;
  }
}


bpm.tempo(120);
spork ~ playing();
4*bpm.whole => now;
spork ~ horns(0);
4*bpm.whole => now;
spork ~ horns(3);
spork ~ horns(6);
8*bpm.whole => now;
