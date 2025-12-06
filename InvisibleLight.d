/*
Hides the glowing white ball from the Light spell (hovering over hero's head), 
so that it doesn't obstruct the view.
*/

META
{
    Parser = PFX
    MergeMode = TRUE
};

test MFX_LIGHT_INIT
{
    INSTANCE MFX_LIGHT_INIT (C_PARTICLEFX) {
        MFX_LIGHT_INIT_OLD();
        vistexcolorstart_s = "0";
    };
};

test MFX_LIGHT_ORIGIN
{
    INSTANCE MFX_LIGHT_ORIGIN (C_PARTICLEFX) {
        MFX_LIGHT_ORIGIN_OLD();
        vistexcolorstart_s = "0";
    };
};

test MFX_LIGHT_ORIGIN_LESS
{
    INSTANCE MFX_LIGHT_ORIGIN_LESS (C_PARTICLEFX)
    {
        MFX_LIGHT_ORIGIN_LESS_OLD();
        vistexcolorstart_s = "0";
    };
};

test MFX_PALLIGHT_INIT
{
    INSTANCE MFX_PALLIGHT_INIT (C_PARTICLEFX)
    {
        MFX_PALLIGHT_INIT_OLD();
        vistexcolorstart_s = "0";
        vistexcolorend_s = "0";
    };
};

test MFX_PALLIGHT_ORIGIN
{
    INSTANCE MFX_PALLIGHT_ORIGIN (C_PARTICLEFX)
    {
        MFX_PALLIGHT_ORIGIN_OLD();
        vistexcolorstart_s = "0";
        vistexcolorend_s = "0";
    };
};
