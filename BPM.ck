//  Listing 9.5 Redefining BPM's variables as static

public class BPM
{
    // global variables  // (1) Declaring variables as static makes
                         // them global to all instances of BPM
    static dur whole, half, quarter, eighth, sixteenth, thirtysecond;

    fun void tempo(float beat) {
        // beat argument is BPM, example 120 beats per minute
        60.0/(beat) => float SPB; // seconds per beat
        SPB :: second => quarter;
        quarter*4.0 => whole;
        quarter*2.0 => half;
        quarter*0.5 => eighth;
        eighth*0.5 => sixteenth;
        sixteenth*0.5 => thirtysecond;
    }
}
