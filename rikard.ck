BPM bpm;
PentaScale scale;
[4,4,5,5,6,5,6,5,2,-1,1,0,1,2,3,4,5,6,5,4,3,2,1,0,2,6,0,6,2,5,2,2,4,4,5,5,2,0,2,0,3,0,3,0,3,5,5,0,1,2,3,4,5,3,3,6,6,3,3,6,5,2,1,0,2,4,6,5,4,5,6,5,4,4,5,6,7,6,5,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] @=> int voice1[];
[1,1,1,1,0,0,0,0,2,1,1,1,1,0,0,0,0,0,2,1,1,1,1,1,2,2,2,0,0,0,1,1,0,0,3,3,3,3,3,3,1,1,1,3,3,3,3,1,1,1,1,1,0,0,1,1,0,1,1,2,3,3,3,3,0,3,0,2,1,2,2,1,0,0,0,1,1,1,1,1,1,1,1] @=> int len1[];

fun void sinwave() {
    SinOsc s => dac;
    while (true) {
        0.5 => s.gain;
        scale.freq(0,3) => s.freq;
        bpm.quarter => now;
        0.0 => s.gain;
        bpm.quarter => now;

        0.5 => s.gain;
        scale.freq(2,3) => s.freq;
        bpm.quarter => now;
        0.0 => s.gain;
        bpm.quarter => now;
    }
}


fun void guitarplucks(int voice[],int len[],int ofs) {
    Noise nois => ADSR pluck => DelayA str => dac;
    str => OneZero lowPass => str;
    // OBS! Sätt äver 0.5. Du blåser trumhinnorna!
    0.48 => lowPass.b0;
    pluck.set(0.002 :: second, 0.002 :: second, 0.0, 0.01 :: second);
    0 => int index;
    while (true) {
      voice[index]=> int tonwtf;
      if(tonwtf==-1) {
        0=>pluck.keyOn;
      } else {
        scale.delayInSamps((voice[index]+ofs) % 7,4) :: samp => str.delay;
        1 => pluck.keyOn;
      }
      if(len[index]==0) bpm.eighth => now;
      if(len[index]==1) bpm.quarter => now;
      if(len[index]==2) bpm.half => now;
      if(len[index]==3) bpm.sixteenth => now;
      index+1 => index;
    }
}

bpm.tempo(120);
spork ~ sinwave();
spork ~ guitarplucks(voice1,len1,0);
spork ~ guitarplucks(voice1,len1,5);
spork ~ guitarplucks(voice1,len1,4);
spork ~ guitarplucks(voice1,len1,2);
0.4*bpm.sixteenth => now;
spork ~ guitarplucks(voice1,len1,0);
0.4*bpm.sixteenth => now;
spork ~ guitarplucks(voice1,len1,0);
0.4*bpm.sixteenth => now;
spork ~ guitarplucks(voice1,len1,0);
0.4*bpm.sixteenth => now;
spork ~ guitarplucks(voice1,len1,0);
0.5*bpm.sixteenth => now;
spork ~ guitarplucks(voice1,len1,0);
0.6*bpm.sixteenth => now;
spork ~ guitarplucks(voice1,len1,0);


16*bpm.whole => now;
