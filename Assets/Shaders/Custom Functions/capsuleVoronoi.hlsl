float2 hash22( in float2 uv) // code version of my Hash22
{
    float3 a = frac(uv.xyx * float3(123.34, 234.34, 345.65));
    a += dot(a, a + 34.45);
    return frac(float2(a.x * a.y, a.y * a.z)); // returns a random float2
}

float distLine(float2 a, float2 b) // code version of my Distance Line sub graph
{
    float2 distA = a - b;
    float distB = saturate(dot(a, distA) / dot(distA, distA));
    
    return length(a - distA * distB);

}
void capsuleVoronoi_float (float2 uv, float time, float2 scale, float2 capsuleLength, out float output) // uv needs to be between -1 to 1
{
    uv *= scale;
    float2 gridUV = frac(uv) - .5;
    float2 id = floor(uv); //giving each cell a 2D coordinate between -1 and 1

    float minDist = 1;
    

    for (float y = -1; y <= 1; y++) // loop through each column of the 3x3 grid
    {
        for (float x = -1; x <= 1; x++) //for each column of the 3x3 grid, loop through each row
        {
            float2 offset = float2(x, y);
            
            float2 randomCoord = hash22(id + offset); // create random coord value for each cell

            float2 position = offset + sin(randomCoord * time) * 0.5f; //from the grid position, offset the cell to a random point


            float dist = distLine(gridUV - position, gridUV - (position - capsuleLength)); // create the capsule shape

            minDist = min(minDist, dist); // clamp the result so its below 1
        }

    }
    
    output = minDist;

}