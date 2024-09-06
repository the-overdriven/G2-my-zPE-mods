/*
Hides the glowing white ball from the Light spell (hovering over hero's head), 
so that it doesn't obstruct the view.
*/

META
{
    Parser = PFX
    MergeMode = TRUE
};

INSTANCE MFX_LIGHT_INIT (C_PARTICLEFX) {
    MFX_LIGHT_INIT_OLD();
};

INSTANCE MFX_LIGHT_ORIGIN (C_PARTICLEFX) {
    MFX_LIGHT_ORIGIN_OLD();
    vistexcolorstart_s = "0";
};

INSTANCE MFX_LIGHT_ORIGIN_LESS (C_PARTICLEFX)
{
    MFX_LIGHT_ORIGIN_LESS_OLD();
    vistexcolorstart_s = "0";
};
