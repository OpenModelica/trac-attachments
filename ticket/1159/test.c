int Count_Fkt(double omega)
{
    static double lastomega = 0;
    static int x = -20;

    if (omega != lastomega)
    {
        x++;

        lastomega = omega;
    }

    return x;
}
